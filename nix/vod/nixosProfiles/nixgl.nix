{ inputs, cell, ... }:
{ hardware, config, pkgs, ... }:

let
  inherit (inputs.std-ext.writers.lib) writeShellApplication;
  inherit (inputs.nixpkgs.lib)
    concatStrings
    imap0
    toUpper
    stringToCharacters
    optionalString;

  capitalize = string:
    concatStrings (imap0
      (i: s: if i == 0 then (toUpper s) else s)
      (stringToCharacters string));

  hwName = capitalize hardware;
  isNvidia = hardware == "nvidia";

  nixgl = writeShellApplication
    {
      name = "nixgl";
      runtimeEnv = { NIXPKGS_ALLOW_UNFREE = 1; };
      # https://download.nvidia.com/XFree86/Linux-x86_64/
      text = ''
        if [ ! -f "$HOME/.nix-profile/bin/nixGLNvidia-${config.hardware.${hardware}.package.version}" ]
        then
           nix profile install github:guibou/nixGL#nixGL${hwName} --impure \
           --override-input nixpkgs github:nixos/nixpkgs/${inputs.nixos.sourceInfo.rev}
        fi
        exec "$HOME"/.nix-profile/bin/nixGL${hwName}${optionalString isNvidia ("-" + config.hardware.${hardware}.package.version)} "$@"
      '';
    };

in

{ environment.systemPackages = [ nixgl ]; }
