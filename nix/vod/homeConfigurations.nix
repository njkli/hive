{ inputs, cell, ... }:
{
  desktop = cell.lib.mkHomeConfig "desktop" "vod";
  libvirtd = cell.lib.mkHomeConfig "libvirtd" "vod";
  folfanga = cell.lib.mkHomeConfig "folfanga" "vod";
}
