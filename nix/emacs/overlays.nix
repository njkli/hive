{ inputs, cell, ... }:
let
  inherit (inputs) nixpkgs;
in
{
  emacs-overlay = inputs.cells.common.lib.__inputs__.emacs-overlay.overlays.default;
}
