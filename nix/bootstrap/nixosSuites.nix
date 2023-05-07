{ inputs, cell, ... }:

rec {
  default = with cell.nixosProfiles;
    [
      base
      sudo
      nix
      earlyoom
      # NOTE: not enough memory! tmp
      core.tlp
      core.fwupd
      core.locale
      core.console-solarized
      core.boot-config
      core.packages
      core.shell-defaults
    ]
    ++ [ cell.nixosModules.deploy ]
    ++ [{ _module.args = { inherit (inputs) self; }; }];

  cloud = [
    {
      boot.cleanTmpDir = true;
      zramSwap.enable = true;
      documentation.enable = false;
    }
    inputs.cells.networking.nixosProfiles.openssh
    cell.nixosProfiles.nix
  ];
}
