{ inputs, cell, ... }:
{
  default = { boot ? "boot" }:
    {
      imports =
        [ ({ config, ... }: (cell.lib.mkHome "admin" config.networking.hostName "zsh")) ] ++
        [ cell.userProfiles.root ] ++
        [ inputs.cells.bootstrap.nixosProfiles."systemd-${boot}" ] ++
        inputs.cells.bootstrap.nixosSuites.default ++
        cell.nixosSuites.base;
    };

  # graphical = {
  #   default.imports =
  #     [
  #       inputs.cells.hardware.nixosProfiles.opengl
  #       ({ config, pkgs, ... }: cell.nixosProfiles.nixgl { inherit config pkgs; hardware = "nvidia"; })
  #       # gtk modules
  #       cell.nixosProfiles.dfconf
  #       cell.nixosProfiles.fonts
  #       inputs.cells.bootstrap.nixosProfiles.core.fonts
  #       inputs.cells.bootstrap.nixosProfiles.core.locale
  #       inputs.cells.display.nixosModules.xdg
  #       # audio modules
  #       inputs.cells.hardware.nixosProfiles.bluetooth
  #       inputs.cells.hardware.nixosProfiles.pipewire
  #     ]
  #     ++ inputs.cells.display.nixosSuites.guangtao;

  #   nvidia.imports = [ cell.nixosProfiles.nvidia ];
  #   hidpi.imports = [ inputs.cells.hardware.nixosProfiles.hidpi ];
  # };

  virtualization.imports =
    [ inputs.cells.virtualization.nixosProfiles.vod ];

} // inputs.cells.common.lib.importRakeLeaves ./nixosProfiles { inherit cell inputs; }
