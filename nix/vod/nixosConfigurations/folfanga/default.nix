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
    cell.nixosSuites.remote-display ++
    [
      bee.home.nixosModules.home-manager
      cell.hardwareProfiles.${baseNameOf ./.}
      cell.nixosProfiles.zfs
      inputs.cells.bootstrap.nixosProfiles.core.kernel.physical-access-system
      (cell.nixosProfiles.default { boot = "grub-zfs"; })
      ({ lib, ... }: {
        boot.kernelParams = lib.mkAfter [
          "zfs.zfs_arc_max=${toString (4 * 1024 * 1024 * 1024)}"
          "fbcon=rotate:0"
        ];
      })
      {
        deploy.enable = true;
        deploy.params.hidpi.enable = true;
        deploy.params.lan.mac = "16:07:77:05:aa:ff";
        deploy.params.lan.ipv4 = "10.11.1.40/24";
        deploy.params.lan.dhcpClient = false;

        systemd.network.networks.lan = {
          addresses = [{ addressConfig.Address = "10.11.1.40/24"; }];
          networkConfig.Gateway = "10.11.1.1";
          dns = [ "8.8.8.8" ];
        };

        networking.hostName = baseNameOf ./.;
        networking.hostId = "25d6e1fb";

        services.redshift.brightness.night = "0.85";
        services.redshift.brightness.day = "0.85";
      }
      {
        services.xserver.remote-display.client.enable = true;
        services.xserver.remote-display.client.brightness = 15;
        services.xserver.remote-display.client.screens = [
          {
            id.vnc = "FOLFANGADOWN";
            id.xrandr = "eDP1";
            port = 65511;
            size.x = 2560;
            size.y = 1600;
            pos.x = 0;
            pos.y = 0;
            xrandrExtraOpts = "--primary";
          }
        ];

      }
    ];
}
