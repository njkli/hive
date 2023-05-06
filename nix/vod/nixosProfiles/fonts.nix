{ inputs, cell, ... }:

{ pkgs, lib, ... }:

{
  fonts.fonts = with pkgs;
    [
      material-icons
      weather-icons
      all-the-icons
      material-symbols
      windows-fonts
    ];

  fonts.fontconfig = {
    enable = lib.mkDefault true;
    antialias = true;
    hinting.enable = true;
    hinting.autohint = true;
    defaultFonts = {
      monospace = [ "UbuntuMono Nerd Font Mono" ];
      sansSerif = [ "UbuntuMono Nerd Font Mono" ];
      serif = [ "UbuntuMono Nerd Font Mono" ];
    };
  };
}
