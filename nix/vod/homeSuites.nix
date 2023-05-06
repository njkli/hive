{ inputs, cell, ... }:
rec {
  default = base;

  base = with cell.homeProfiles; [
    shell.zsh
    shell.screen
    shell.cli-tools
    look-and-feel.starship-prompt
  ];

  desktop = with cell.homeProfiles; [
    emacs
    terminals.tilix
    terminals.kitty
    conky
    xdg
    qt
  ];

  office = with cell.homeProfiles.office; [
    pdf
    viewers
    printing
    graphics
    libreoffice
    nyxt-browser
  ];

  # hostSpecific.libvirtd = default;
  # userSpecific.admin = default;

  # desktop = with homeProfiles;
  #   default;
  # ++ terminal
  # ++ emacs
  # ++ applications
  # ++ inputs.cells.display.homeSuites.guangtao
  # ++ inputs.cells.secrets.homeSuites.full;
}