{ inputs, cell, ... }:
rec {
  base = [ ];

  # desktop = with cell.nixosProfiles;
  #   [
  #     (default { boot = "initrd"; })
  #     graphical.default
  #     graphical.nvidia
  #     graphical.hidpi
  #     networking
  #     virtualization
  #     coding.desktop
  #   ]
  #   ++ [
  #     desktop
  #     (cell.lib.mkHome "vod" "desktop" "zsh" "22.11")
  #     cell.userProfiles.root
  #   ]
  #   ++ inputs.cells.secrets.nixosSuites.full;

  networking = [
    inputs.cells.networking.nixosProfiles.networkd
    inputs.cells.networking.nixosProfiles.firewall
    inputs.cells.networking.nixosProfiles.openssh
    {
      networking.hosts = {
        "192.168.192.220" = [ "eadrax" ];
        "192.168.192.221" = [ "asbleg" ];
        "192.168.192.110" = [ "folfanga" ];
        "192.168.192.111" = [ "folfanga-1" ];
        "192.168.192.112" = [ "folfanga-2" ];
      };
      services.zerotierone.enable = true;
      services.zerotierone.joinNetworks = [ "a84ac5c10a162ba4" ];
    }
  ];

  remote-display =
    base ++
    networking ++
    [
      inputs.cells.secrets.nixosProfiles.age
      inputs.cells.virtualization.nixosProfiles.docker
      cell.nixosModules.services.x11.remote-display
      cell.nixosProfiles.desktop.remote-display-client
    ];
}
