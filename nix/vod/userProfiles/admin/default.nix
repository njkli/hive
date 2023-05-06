{ inputs, cell, ... }:

{ config, lib, ... }:
let
  inherit (lib) mkMerge mkIf hasAttrByPath;
  isDocker = config.virtualisation.docker.enable;
  isPodman = config.virtualisation.podman.enable;
  isLibvirtd = config.virtualisation.libvirtd.enable;
in
lib.mkMerge [
  { users.users.admin.extraGroups = [ "wheel" ]; }
  {
    users.users.admin = {
      hashedPassword = "$6$hMM0iey5Ypc0Mpow$ZU64D7qWfnU/Z088CSSgYzPur.Ele8U6XcxRssNCvfHvWhCtarrTe5dd432sCwl3wooj.PcwAEkiAZyKh0I1X0";
      description = "Administrator";
      isNormalUser = true;
      uid = 10000;
      inherit (cell.userProfiles) extraGroups;
      inherit (cell.secretProfiles.vod) openssh;
    };
  }
  (mkIf isDocker { users.users.admin.extraGroups = [ "docker" ]; })
  (mkIf isPodman { users.users.admin.extraGroups = [ "podman" ]; })
  (mkIf isLibvirtd {
    users.users.admin.extraGroups = [ "libvirtd" ];
    home-manager.users.admin.imports = [
      inputs.cells.virtualization.homeProfiles.libvirtd
    ];
  })
]
