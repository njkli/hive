{ inputs, cell, ... }:

{
  boot.zfs.forceImportAll = true;
  boot.zfs.devNodes = "/dev/disk/by-partuuid";
  boot.initrd.supportedFilesystems = [ "zfs" ];
  boot.supportedFilesystems = [ "zfs" ];
  services.zfs.trim.enable = true;
  services.zfs.autoScrub.enable = true;
}
