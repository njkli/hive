{ inputs, cell, ... }:
let inherit (inputs.cells.common.lib) __inputs__; in
{
  desktop = [
    cell.overlays.default
    cell.overlays.python
    cell.overlays.overrides
    inputs.nur.overlay

    # inputs.cells.utils.overlays.default

    cell.overlays.stumpwm

    __inputs__.rust-overlay.overlays.default
    __inputs__.nixpkgs-wayland.overlays.default
    __inputs__.poetry2nix.overlay

    inputs.cells.emacs.overlays.emacs-overlay

    inputs.cells.utils.overlays.vscode
    inputs.cells.utils.overlays.vscode-extensions
    __inputs__.julia2nix.overlays.default
  ];

  libvirtd = [ ];

  vultr = [
    cell.overlays.default
    __inputs__.nixpkgs-hardenedlinux.pkgs.overlays.default
    __inputs__.nixpkgs-hardenedlinux.go.overlays.default
    __inputs__.nixpkgs-hardenedlinux.common.lib.__inputs__.nix-npm-buildpackage.overlays.default
    __inputs__.nixpkgs-hardenedlinux.common.lib.__inputs__.gomod2nix.overlays.default
    __inputs__.nixpkgs-hardenedlinux.common.lib.__inputs__.pnpm2nix.overlays.default
  ];
}
  // inputs.cells.common.lib.importRakeLeaves ./overlays { inherit inputs cell; }
