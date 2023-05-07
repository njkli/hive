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
    cell.nixosSuites.networking ++
    [
      bee.home.nixosModules.home-manager
      # cell.hardwareProfiles.${baseNameOf ./.}
      inputs.cells.hardware.nixosProfiles.intel
      inputs.cells.hardware.nixosProfiles.default

      cell.nixosProfiles.zfs
      inputs.cells.virtualization.nixosProfiles.docker
      inputs.cells.bootstrap.nixosProfiles.core.kernel.physical-access-system
      (cell.nixosProfiles.default { boot = "grub-zfs"; })
      ({ lib, ... }: {
        boot.kernelParams = lib.mkAfter [
          "nomodeset"
        ];
      })
      {
        deploy.enable = true;
        deploy.params.hidpi.enable = true;
        deploy.params.lan.mac = "16:07:77:ff:b4:ff";
        deploy.params.lan.ipv4 = "10.11.1.123/24";
        deploy.params.lan.dhcpClient = false;

        systemd.network.networks.lan = {
          addresses = [{ addressConfig.Address = "10.11.1.123/24"; }];
          networkConfig.Gateway = "10.11.1.1";
          dns = [ "8.8.8.8" ];
        };

        networking.hostName = baseNameOf ./.;
        networking.hostId = "21d5e1ff";
      }
    ];
}
