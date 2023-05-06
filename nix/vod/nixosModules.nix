{ inputs, cell, ... }:
inputs.cells.common.lib.rakeLeaves ./nixosModules
# inputs.cells.common.lib.rakeLeaves (inputs.nix-filter.lib.filter {
#   root = ./nixosModules;
#   exclude = [
#     # ./nixosModules/services
#   ];
# })
