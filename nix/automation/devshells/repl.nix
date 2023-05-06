# Adapted on 3rd of July 2021 from
# https://github.com/gytis-ivaskevicius/flake-utils-plus/blob/438316a7b7d798bff326c97da8e2b15a56c7657e/lib/repl.nix
{ flakePath }:
let
  Flake =
    if builtins.pathExists flakePath
    then
      (import
        (fetchTarball {
          url = "https://github.com/edolstra/flake-compat/archive/009399224d5e398d03b22badca40a37ac85412a1.tar.gz";
          sha256 = "0xcr9fibnapa12ywzcnlf54wrmbqqb96fmmv8043zhsycws7bpqy";
        })
        { src = toString flakePath; }).defaultNix
    else { };
  lib = Flake.inputs.nixpkgs-master.lib;
  Channels = lib.genAttrs [
    "nixos"
    "nixos-22-11"
    "nixos-unstable"
    "nixpkgs"
    "nixpkgs-master"
  ]
    (x: Flake.inputs.${x} // { pkgs = Flake.inputs.${x}.legacyPackages.${builtins.currentSystem}; });
  LoadFlake = path: builtins.getFlake (toString path);

  Lib =
    with lib;
    let
      inputsWithLibs = filterAttrs (n: v: v ? lib && !elem n (attrNames Channels)) Flake.inputs;
      cellsWithLibs = mapAttrs (_: v: v.lib) (filterAttrs (n: v: v ? lib && v.lib != { }) Flake.${builtins.currentSystem});
    in
    (mapAttrs (_: v: v.lib) (Channels // inputsWithLibs)) // { cells = cellsWithLibs; };
  stdLib = builtins // Lib.nixpkgs-master;
  Legacy = with stdLib; let path = toPath ((getEnv "PRJ_ROOT") + "/../legacy/systems"); in
  if pathExists path then getFlake path else null;
  Cells = Flake.__std.actions.${builtins.currentSystem};
  # TODO: Me = with stdLib; let hostName = readFile /etc/hostname; in hostName;
in
{
  inherit
    Cells
    Channels
    Flake
    LoadFlake
    Lib
    stdLib
    Legacy;
} // builtins

/*
  { flakePath, host }:
  let
  Flake =
  if builtins.pathExists flakePath
  then builtins.getFlake (toString flakePath)
  else { };

  Me = Flake.nixosConfigurations.${host} or { };
  NixOS = Flake.nixosConfigurations.NixOS;
  Channels = Flake.pkgs.${builtins.currentSystem} or { };
  Machines = Flake.nixosConfigurations;
  LoadFlake = path: builtins.getFlake (toString path);
  Lib =
  with Channels.nixos.lib;
  let
      inputsWithLibs = filterAttrs (n: v: v ? lib && !elem n (attrNames Channels)) Flake.inputs;
  in
  mapAttrs (_: v: v.lib) (Channels // inputsWithLibs);
  Module = fName:
  let
      channelPath = "${Flake.inputs.nixos}";
      modulesPath = channelPath + "/nixos/modules/";
      modEval = import (modulesPath + fName) { inherit (NixOS) config options pkgs; inherit (NixOS.pkgs) lib; };
  in
  modEval;
  stdLib = Lib.nixos // Flake.lib // { diggaFlake = Lib.digga; };
  Legacy = with builtins; let path = toPath ((getEnv "PRJ_ROOT") + "/../legacy/systems"); in
  if pathExists path then getFlake path else null;
  dumpConfig = { flake, machine }:
  with stdLib;
  with builtins;
  let
      filters = [
        "passthru"
        "fileSystems"
      ];
      cfg = filterAttrs (n: v: !elem n filters) (getFlake (toPath flake)).nixosConfigurations.${machine}.config;
  in
  cfg;

  in
  {
  inherit
  # TODO: dumpConfig
  Legacy
  Channels
  Machines
  Lib
  stdLib
  Flake
  LoadFlake
  Me
  NixOS
  Module;
  inherit (Lib.nixos.modules) evalModules;
  inherit (NixOS.pkgs) writeText;
  } // builtins


*/
