{ inputs, cell, ... }:

{ pkgs, ... }:
{
  services.xserver.windowManager.stumpwm.enable = true;
  services.xserver.windowManager.stumpwm.package = pkgs.stumpwm;
  services.xserver.displayManager.autoLogin.user = "nixos";
  services.xserver.displayManager.autoLogin.enable = true;
  services.xserver.displayManager.lightdm.autoLogin.timeout = 0;
  services.xserver.displayManager.defaultSession = "stumpwm";
}
