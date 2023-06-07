{ inputs, cell, ... }:

{ pkgs, lib, config, ... }:
let
  inherit (lib) mkMerge mkIf;
in
mkMerge [
  {
    fonts.fonts = with pkgs;
      [
        material-icons
        weather-icons
        all-the-icons
        material-symbols
        windows-fonts
      ];

    fonts.fontconfig = {
      enable = lib.mkDefault true;
      antialias = true;
      hinting.enable = true;
      hinting.autohint = true;
      defaultFonts = {
        monospace = [ "UbuntuMono Nerd Font Mono" ];
        sansSerif = [ "UbuntuMono Nerd Font Mono" ];
        serif = [ "UbuntuMono Nerd Font Mono" ];
      };
    };
  }

  (mkIf config.fonts.fontDir.enable {
    systemd.user.services.clean-cache-fontconfig = {
      # NOTE: https://github.com/NixOS/nixpkgs/issues/204181
      documentation = [ "https://github.com/NixOS/nixpkgs/issues/204181" ];
      partOf = [ "basic.target" ];
      before = [ "graphical-session.target" ];
      serviceConfig.Type = "oneshot";
      serviceConfig.RemainAfterExit = "yes";
      serviceConfig.SyslogIdentifier = "rm-cache-fontconfig";
      scriptArgs = "%h";
      script = ''
        rm -rf "''${1}/.cache/fontconfig"
      '';
    };
  })
]
