{ inputs, cell, ... }:

{ config, lib, pkgs, ... }:
let
  extraGroups = cell.userProfiles.extraGroups ++ [ "wheel" ];
in
{
  imports = [
    { disabledModules = [ "services/security/opensnitch.nix" ]; }
    cell.nixosModules.services.security.opensnitch
    cell.homeProfiles.security.password-store
  ];

  home-manager.users.vod.imports = [ ./home ];

  users.users.vod = {
    hashedPassword = "$6$VsWUQCau32Oa$tNiMK5LftcuYDRPeACeP/BLikr7tYps/MHDeF3GT0bNRvyEW3PgIXXMzBY5x.FvGO6NprwhDldeFeKBzVQuhI1";
    description = "Никто кроме нас";
    isNormalUser = true;
    uid = 1000;
    inherit extraGroups;
    inherit (cell.secretProfiles.vod) openssh;
  };
}
