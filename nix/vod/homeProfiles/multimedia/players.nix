{ lib, pkgs, ... }:
with lib;

mkMerge [
  {
    home.packages = with pkgs; [ vlc ];
  }
]
