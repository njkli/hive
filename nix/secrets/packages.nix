{ inputs, cell, ... }:
let
  nixpkgs = inputs.nixpkgs.appendOverlays [
    # inputs.cells.common.lib.__inputs__.ragenix.overlays.default
    inputs.cells.common.lib.__inputs__.agenix.overlays.default
  ];
in
{
  # https://github.com/yaxitech/ragenix
  # inherit (nixpkgs) ragenix;
  inherit (nixpkgs) agenix;
}
