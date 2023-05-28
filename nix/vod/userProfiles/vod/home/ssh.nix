{ pkgs, lib, name, config, osConfig, ... }:
with lib;
let
  defaults = {
    # identityFile = "~/.ssh/id_rsa.pub";
  };
  defaults_git = { user = "git"; } // defaults;
  defaults_njk = { user = "admin"; forwardAgent = true; } // defaults;
  defaults_njk_gitea = { user = "gitea"; } // defaults;
  inherit (osConfig.users.users.${name}) uid;
in
mkMerge [
  (mkIf config.services.gpg-agent.enable {
    services.gpg-agent.sshKeys = [ "E3C4C12EDF24CA20F167CC7EE203A151BB3FD1AE" ];
  })

  (mkIf (config.services.gpg-agent.enable && config.services.gpg-agent.enableExtraSocket) {
    programs.ssh.matchBlocks."eadrax eadrax.njk.*".remoteForwards = [{
      bind.address = "/run/user/${toString uid}/gnupg/S.gpg-agent";
      host.address = replaceStrings [ "%t" ] [ "/run/user/${toString uid}" ]
        osConfig.home-manager.users.${name}.systemd.user.sockets.gpg-agent-extra.Socket.ListenStream;
    }];
  })

  {
    programs.ssh = {
      enable = true;
      compression = true;
      serverAliveInterval = 15;
      extraOptionOverrides = {
        StrictHostKeyChecking = "no";
        IdentitiesOnly = "no";
      };

      matchBlocks = {
        "eadrax eadrax.njk.*" = defaults_njk // { user = name; };
        "git.0a.njk.li" = defaults_njk_gitea;
        "*.0a.njk.li" = defaults_njk;
        "*.0.njk.li" = defaults_njk;
        "nowhat* nowhat*.0*.njk.li".port = 65522;
        "maintenance* maintenance*.0*.njk.li".port = 65522;
        "kakrafoon* kakrafoon*.0*.njk.li".port = 65522;
        "bitbucket.org" = defaults_git;
        "github.com" = defaults_git;
      };
    };
  }
  # (mkIf ((length osConfig.users.users.${name}.openssh.authorizedKeys.keys) > 0) {
  #   home.file.".ssh/id_rsa.pub".text = head osConfig.users.users.${name}.openssh.authorizedKeys.keys;
  # })
]
