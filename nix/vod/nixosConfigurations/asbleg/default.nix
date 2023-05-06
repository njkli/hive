{ inputs, cell, ... }:
let
  inherit (builtins) toString baseNameOf;
in

rec {
  bee.system = "x86_64-linux";
  bee.home = inputs.home;
  bee.pkgs = import inputs.nixos {
    inherit (inputs.nixpkgs) system;
    config.allowUnfree = true;
    overlays = cell.overlays.desktop;
  };

  imports =
    inputs.cells.bootstrap.nixosSuites.physical-access-system ++
    cell.nixosSuites.networking ++
    [
      bee.home.nixosModules.home-manager
      cell.hardwareProfiles.${baseNameOf ./.}
      cell.nixosProfiles.zfs
      inputs.cells.virtualization.nixosProfiles.docker
      (cell.nixosProfiles.default { boot = "grub-zfs"; })
      ({ lib, ... }: {
        boot.kernelParams = lib.mkAfter [
          "zfs.zfs_arc_max=${toString (4 * 1024 * 1024 * 1024)}"
        ];
      })
      {
        deploy.enable = true;
        deploy.params.hidpi.enable = true;
        deploy.params.lan.mac = "16:07:77:ff:ba:ff";
        deploy.params.lan.ipv4 = "10.11.1.122/24";
        deploy.params.lan.dhcpClient = false;

        systemd.network.networks.lan = {
          addresses = [{ addressConfig.Address = "10.11.1.122/24"; }];
          networkConfig.Gateway = "10.11.1.1";
          dns = [ "8.8.8.8" ];
        };

        networking.hostName = baseNameOf ./.;
        networking.hostId = "23d7e1ff";

        # services.redshift.brightness.night = "0.85";
        # services.redshift.brightness.day = "0.85";
      }
    ];
}
