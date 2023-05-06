{ inputs, cell, ... }:
let
  inherit (inputs.nixpkgs.lib // builtins) getExe;
in
{
  jinx-compile = {
    program = l.getExe cell.entrypoints.jinx-compile;
    type = "app";
  };
}
