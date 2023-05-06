{ lib, pkgs, config, ... }:
with lib;
mkMerge [
  {
    # openjdk11
    home.packages = with pkgs; [
      maven
      openjdk11
    ];
  }

  (mkIf config.programs.vscode.enable {
    programs.vscode.extensions = with pkgs.vscode-extensions; [ ballerina ];
  })
]
