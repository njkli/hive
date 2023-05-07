{ inputs, cell, ... }:

{ config, lib, pkgs, ... }:
let
  extraGroups = cell.userProfiles.extraGroups ++ [ "wheel" ];
in
{
  imports =
    [
      {
        disabledModules = [
          "services/security/opensnitch.nix"
          "services/security/pass-secret-service"
        ];
      }
      cell.nixosModules.services.security.opensnitch
      cell.nixosModules.services.security.pass-secret-service
      cell.nixosModules.services.x11.window-managers.stumpwm-new
    ] ++
    (with cell.nixosProfiles;[
      desktop.xdmcp
      desktop.common
      desktop.stumpwm
      desktop.chromium-browser
      desktop.firefox-browser
      hardware.crypto
    ]) ++
    [
      inputs.cells.common.lib.__inputs__.agenix.nixosModules.age
      inputs.cells.bootstrap.nixosProfiles.core.age-secrets
    ];

  services.pass-secret-service.enable = true;

  home-manager.users.vod.imports =
    cell.homeSuites.developer.default ++
    [ ./home ];

  users.users.vod = {
    hashedPassword = "$6$VsWUQCau32Oa$tNiMK5LftcuYDRPeACeP/BLikr7tYps/MHDeF3GT0bNRvyEW3PgIXXMzBY5x.FvGO6NprwhDldeFeKBzVQuhI1";
    description = "Никто кроме нас";
    isNormalUser = true;
    uid = 1000;
    inherit extraGroups;
    inherit (cell.secretProfiles.vod) openssh;
  };
}
