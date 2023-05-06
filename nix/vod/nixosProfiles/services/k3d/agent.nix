{ config, lib, pkgs, ... }:
with lib;
{
  imports = [ ./common.nix ];
  virtualisation.oci-containers.containers.k3s = {
    cmd = mkBefore [ "agent" ];
    environment = {
      K3S_TOKEN = "";
    };
    extraOptions = mkAfter [
      "--ip=${localAddress}"
    ];

  };

}
