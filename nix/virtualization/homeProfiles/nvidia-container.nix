{ config, lib, pkgs, osConfig, ... }:
let
  inherit (lib) optionalAttrs mkIf;
  podmanEnabled = osConfig.virtualisation.podman.enable;
  podmanNvidiaEnabled = podmanEnabled && osConfig.virtualisation.podman.enableNvidia;
  dockerNvidiaEnabled = osConfig.virtualisation.docker.enableNvidia;
  cfgFname = "nvidia-container-runtime/config.toml";
in
mkIf (podmanNvidiaEnabled || dockerNvidiaEnabled)
{ xdg.configFile.${cfgFname}.source = "${pkgs.nvidia-podman}/etc/${cfgFname}"; }
