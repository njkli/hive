{ inputs, cell }:
let
  inherit (inputs.nixpkgs.lib) mapAttrsRecursive;
  inherit (inputs.std-ext.common.lib) callFlake;
  inherit (inputs.std-ext.lib.digga) rakeLeaves;

  lib = (with inputs; nixpkgs.lib // std-ext.lib.digga);
  commonLib = mapAttrsRecursive
    (_: v: import v { inherit lib callFlake inputs; })
    (rakeLeaves ./lib);
in
inputs.std-ext.lib.digga // commonLib
