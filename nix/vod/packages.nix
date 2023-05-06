{ inputs, cell, ... }:
{
  inherit
    (cell.lib.nixpkgs)
    promnesia
    orgparse
    all-the-icons
    mind-wave;
}
