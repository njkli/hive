{ lib, ... }:
let
  fetch = import ./fetch.nix;
  flake-compat = import (fetch "flake-compat");
  flake = flake-compat { src = fetchGit ../../../../.; };
in
flake
