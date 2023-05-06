{ inputs, cell, ... }:

{ pkgs, ... }:

{
  services = {
    greetd = {
      enable = true;
      settings = rec {
        initial_session = {
          command = "${pkgs.greetd.tuigreet}/bin/tuigreet --time --cmd Hyprland";
          user = "vod";
        };
        default_session = initial_session;
      };
    };
  };
}
