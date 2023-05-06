# { inputs, cell, ... }:
inputs.cells.common.lib.rakeLeaves ./homeProfiles
# let
#   inherit (cell) homeProfiles homeModules;
# in
# {
#   default = with homeProfiles; [

#   ];

#   inputs.cells.terminal.homeSuites.default
#   ++ [ inputs.cells.bootstrap.homeProfiles.vod ];

# terminal = with homeProfiles;
#   inputs.cells.terminal.homeSuites.guangtao
#   ++ [ ];

# emacs = with homeProfiles; [
#   inputs.cells.emacs.homeProfiles.guangtao
#   homeModules.programs.chemacs
# ];

# applications = with homeProfiles; [
#   inputs.cells.display.homeProfiles.browser.guangtao
#   inputs.cells.utils.homeProfiles.guangtao
# ];
# }
#   //
