{ config, lib, ... }:
let
  inherit (lib) mkMerge mkIf versionOlder;
  oldRelease = versionOlder config.system.stateVersion "22.11";
in
mkMerge [
  (mkIf oldRelease {
    boot.tmpOnTmpfs = true;
    boot.tmpOnTmpfsSize = "5%";
  })

  (mkIf (!oldRelease) {
    boot.tmp.useTmpfs = true;
    boot.tmp.tmpfsSize = "5%";
  })
]
