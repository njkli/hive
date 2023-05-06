{ inputs, cell, ... }:
let
  l = inputs.nixpkgs.lib // builtins;
  pkgsWithNur = inputs.nixpkgs.appendOverlays [ inputs.nur.overlay ];

  nvfetcher-sources = l.foldr (a: b: a // b) { } (map
    (x:
      let
        x' =
          if x == "default"
          then "_sources"
          else "_sources_${x}";
      in
      {
        "nvfetcher-${x}" = {
          content = ''
            nix develop github:GTrunSec/std-ext#update --refresh --command nvfetcher-update nix/vod/packages/${x'}/sources.toml
          '';
          description = "update ${x} toolchain with nvfetcher";
        };
      }) [ "default" "emacs" ]);
in
{
  fmt = {
    description = "Formats all changed source files";
    content = ''
      treefmt $(git diff --name-only --cached)
    '';
  };

  nvfetcher = {
    description = "update sources with nvfetcher";
    args = [ "path" ];
    content = ''
      nix develop github:GTrunSec/std-ext#update --refresh --command nvfetcher-update {{path}}/sources.toml
    '';
  };

  age = {
    args = [ "cell" "file" ];
    description = "edit the key age with ragenix";
    content = ''
      ragenix --edit ./nix/{{cell}}/secretProfiles/{{file}} --rules ./nix/{{cell}}/secretProfiles/secrets.nix
    '';
  };

  age-rekey = {
    args = [ "cell" ];
    description = "re-age key with ragenix";
    content = ''
      ragenix --rules ./nix/{{cell}}/secretProfiles/secrets.nix --rekey
    '';
  };

  nvfetcher-firefox-addons = {
    description = "update packages via nvfetcher";
    content = ''
      nvfetcher-firefox-addons
    '';
  };

  nvfetcher-update = {
    args = [ "cell" ];
    description = "update packages via nvfetcher";
    content = ''
      nix develop github:GTrunSec/std-ext#devShells.x86_64-linux.update --refresh --command nvfetcher-update nix/{{cell}}/packages/sources.toml
    '';
  };

  generate = {
    args = [ "format-path" "name" ];
    description = "nixos-generators with custom format";
    content = ''
      nixos-generate --format-path ''${PRJ_ROOT}/profiles/nixos-generators/{{format-path}}.nix --system x86_64-linux --flake .#{{name}}
    '';
  };

  machine = {
    args = [ "action" "name" ];
    description = "Colmena [action] [name] Machine";
    content = ''
      colmena {{action}} --on {{name}}
    '';
  };
} // nvfetcher-sources
