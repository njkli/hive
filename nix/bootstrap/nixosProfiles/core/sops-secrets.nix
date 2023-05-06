{ self, pkgs, lib, config, ... }:
{
  sops.defaultSopsFile = builtins.toPath "${self}/secrets/users_and_services.yaml";
  sops.age.sshKeyPaths = [
    # "/etc/ssh/ssh_host_ed25519_key"
    "/persist/etc/ssh/ssh_host_ed25519_key"
  ];

  sops.gnupg.sshKeyPaths = [ ];

  # sops.gnupg.sshKeyPaths = [
  #   "/etc/ssh/ssh_host_rsa_key"
  #   # "/etc/ssh/ssh_host_ed25519_key"
  # ];

  # sops.secrets.example-key = { };
  # sops.secrets."myservice/my_subdir/my_secret" = { };

  # sops.secrets.example_key = {
  #   mode = "0440";
  #   # owner = config.users.nobody.name;
  #   # group = config.users.nobody.group;
  # };

  # sops.secrets."users/${user}".neededForUsers = true;

  # sops.secrets."credentials/token_magithub" = {
  #   owner = builtins.baseNameOf ./.;
  #   group = "users";
  #   mode = "0400";
  #   path = "${config.users.users.vod.home}/.authinfo";
  # };

}
