{ inputs, cell, ... }:
let
  inherit (inputs) nixpkgs;
in
{
  # emacs-overlay = inputs.cells.common.lib.__inputs__.emacs-overlay.overlays.default;
  emacs-overlay = inputs.emacs-overlay.overlays.default;
}
