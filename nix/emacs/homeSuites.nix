{ inputs, cell, ... }:
let
  inherit (inputs) nixpkgs;
  inherit (inputs.nixpkgs.lib // builtins) optionals;
in
{
  overlays = optionals nixpkgs.stdenv.isLinux
    [
      cell.overlays.emacs-overlay
      inputs.cells.vod.overlays.default
    ];
}
