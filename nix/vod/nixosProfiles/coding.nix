{ inputs, cell, ... }:
rec {
  desktop = {
    imports = [
      cell.nixosProfiles.julia
      cell.nixosProfiles.python
      cell.nixosProfiles.rust
      inputs.cells.utils.nixosProfiles.vscode.guangtao
      languageServers
      ({ pkgs, ... }: {
        environment.systemPackages = with pkgs; [
          nickel
          gptcommit
        ];
      })
    ];
  };
  languageServers = { pkgs, ... }: {
    environment.systemPackages = with pkgs; [
      nodePackages.bash-language-server
      nodePackages.typescript-language-server
      shellcheck
      yaml-language-server
    ];
  };
}
