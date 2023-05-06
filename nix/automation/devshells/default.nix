{ inputs, cell, ... }:
let
  l = nixpkgs.lib // builtins;
  inherit (inputs) nixpkgs std;
  withCategory = category: attrset: attrset // { inherit category; };
in
l.mapAttrs (_: std.lib.dev.mkShell) {
  default =
    { extraModulesPath, pkgs, ... }:
    let
      pkgsWithNur = pkgs.appendOverlays [ inputs.nur.overlay ];
      nvfetcher-firefox = {
        category = "devos";
        name = "nvfetcher-firefox-addons";
        help = pkgsWithNur.nur.repos.rycee.mozilla-addons-to-nix.meta.description;
        # TODO: nvfetcher-firefox-addons: refactor with nix eval --expr > generated for fetchFirefoxAddon format
        # TODO: nvfetcher-firefox-addons: move into Justfile
        command = ''
          src_dir=$PRJ_ROOT/nix/vod/packages/_sources_firefox-addons
          tmpdir=$(mktemp -d fetcher-ff-addons.XXXXXXXX --tmpdir)
          in_file=$src_dir/sources.toml
          out_file=$tmpdir/sources.json
          pkgs_file=$tmpdir/generated-home-manager.nix
          final_nix=$src_dir/generated.nix

          ${pkgsWithNur.remarshal}/bin/remarshal -i $in_file -o $out_file --unwrap addons
          ${pkgsWithNur.nur.repos.rycee.mozilla-addons-to-nix}/bin/mozilla-addons-to-nix $out_file $pkgs_file
          # cp $pkgs_file $src_dir

          sed -i 's/buildFirefoxXpiAddon /rec /g' $pkgs_file
          sed -i '1d' $pkgs_file
          echo '{ lib, ... }:' > $final_nix
          cat $pkgs_file | nixpkgs-fmt >> $final_nix

          rm -rf $tmpdir
        '';
      };

    in
    {
      name = "Apis Mellifera";
      git.hooks = { enable = true; };
      imports = [
        cell.devshellProfiles.terraform
        std.std.devshellProfiles.default
        # inputs.cells.bootstrap.devshellProfiles.secureboot
        "${extraModulesPath}/git/hooks.nix"
      ];

      nixago = l.attrValues cell.nixago;

      commands =
        [
          nvfetcher-firefox

          (withCategory "repl" {
            package = (
              nixpkgs.writeShellScriptBin "repl-flake" ''
                export PATH=${nixpkgs.coreutils}/bin:${nixpkgs.nixUnstable}/bin:$PATH
                if [ -z "$1" ]; then
                   nix repl --argstr host "$HOST" --argstr flakePath "$PRJ_ROOT" ${./repl.nix}
                 else
                   nix repl --argstr host "$HOST" --argstr flakePath $(readlink -f $1 | sed 's|/flake.nix||') ${./repl.nix}
                 fi
              ''
            );
          })
          (withCategory "hexagon" { package = pkgs.parted; })
          (withCategory "hexagon" { package = cell.packages.colmena; })
          (withCategory "hexagon" { package = inputs.arion.packages.arion; })
          (withCategory "secrets" {
            package = inputs.cells.secrets.packages.agenix;
          })
          (withCategory "hexagon" { package = nixpkgs.sops; })
        ]
        ++ l.optionals nixpkgs.stdenv.isLinux [
          (withCategory "hexagon" {
            package = inputs.nixos-generators.packages.${nixpkgs.system}.nixos-generate;
          })
        ];
      packages = [ ];
    };
}
