{ inputs, cell, ... }:
{
  vod = [
    ({ lib, ... }: { services.getty.autologinUser = lib.mkDefault "vod"; })
    cell.nixosModules.dbus
    cell.nixosModules.dconf
  ];
}
