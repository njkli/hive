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
      inputs.cells.bootstrap.nixosProfiles.core.kernel.physical-access-system
      (cell.nixosProfiles.default { })
      {
        deploy.enable = true;
        deploy.params.hidpi.enable = true;
        deploy.params.lan.mac = "16:07:77:07:aa:ff";
        deploy.params.lan.ipv4 = "10.11.1.42/24";
        deploy.params.lan.dhcpClient = false;

        systemd.network.networks.lan = {
          addresses = [{ addressConfig.Address = "10.11.1.42/24"; }];
          networkConfig.Gateway = "10.11.1.1";
          dns = [ "8.8.8.8" ];
        };

        networking.hostName = baseNameOf ./.;
        networking.hostId = "90c16bf3";

      }
      {
        services.xserver.remote-display.client.screens = [
          {
            id.vnc = "FOLFANGA2";
            id.xrandr = "DSI1";
            port = "65512";
            size.x = 1920;
            size.y = 1200;
            pos.x = 0;
            pos.y = 0;
            xrandrExtraOpts = "--rotate right --primary";
          }
        ];
      }
    ];
}
