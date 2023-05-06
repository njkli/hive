{ inputs, cell, ... }:
{
  nvidia = {
    imports = [
      cell.nixosProfiles.podman
      cell.nixosProfiles.nvidia-container
      ({ config, lib, ... }:
        let inherit (lib) mkIf hasAttrByPath; in
        mkIf (hasAttrByPath [ "home-manager" ] config) {
          home-manager.sharedModules = [ cell.homeProfiles.nvidia-container ];
        })
    ];
    virtualisation.podman.enableNvidia = true;
    virtualisation.docker.enableNvidia = true;
  };

  vod = {
    imports = [
      cell.nixosProfiles.libvirtd
      cell.nixosProfiles.docker
      # cell.nixosProfiles.nvidia
      ({ config, lib, ... }:
        let inherit (lib) mkIf hasAttrByPath; in
        mkIf (hasAttrByPath [ "home-manager" ] config) {
          home-manager.sharedModules = [ cell.homeProfiles.libvirtd ];
        })

      ({ config, lib, ... }:
        let inherit (lib) optionals; in
        {
          users.users."vod" = {
            extraGroups = with config.virtualisation;
              optionals docker.enable [ "docker" ]
              ++ optionals podman.enable [ "podman" ]
              ++ optionals libvirtd.enable [ "libvirtd" ];
          };
        })
    ];
  };

} // inputs.cells.common.lib.rakeLeaves ./nixosProfiles
