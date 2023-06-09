{ config, lib, pkgs, ... }:
let
  lsp-bridge =
    let
      src = pkgs.sources.lsp-bridge.src;
    in
    pkgs.runCommand "lsp-bridge" { } ''
      cp -r ${src} $out && chmod -R +rw $out/*
      sed -i 's|\["rnix-lsp"\]|\["nil"\]|' $out/langserver/rnix-lsp.json
      cp ${./nls.json} $out/langserver/nls.json
      cp ${./julia.json} $out/langserver/julia.json
    '';
  jinx =
    let
      src = pkgs.sources.jinx.src;
    in
    pkgs.runCommand "jinx"
      {
        buildInputs = with pkgs; [
          (config.programs.emacs.package or pkgs.emacs)
          enchant2
          gcc
        ];
      } ''
      mkdir -p $out
      cp -r ${src}/* .
      ${lib.optionalString pkgs.stdenv.isLinux ''
        cc -I. -O2 -Wall -Wextra -fPIC -shared \
        -I${pkgs.enchant2.dev}/include/enchant-2 -lenchant-2 \
        -o jinx-mod.so jinx-mod.c
      ''}
      cp -r * $out
    '';
in
{
  config = with lib;
    mkMerge [
      {
        home.file.".config/sources/lsp-bridge".source = lsp-bridge;
        home.file.".config/sources/jinx".source = jinx;
        home.file.".config/sources/acm-terminal".source = pkgs.sources.acm-terminal.src;
        home.file.".config/sources/plantuml".source = pkgs.plantuml;
      }
      (mkIf pkgs.stdenv.isLinux {
        home.packages = with pkgs; [ enchant2 ];
      })
      {
        home.packages = with pkgs; [
          nodejs_latest
          sqlite
          zeromq
          xclip
          # for copilot
          (
            pkgs.writeShellScriptBin "node16" ''
              ${lib.getExe pkgs.nodejs-16_x} "$@"
            ''
          )
        ];
      }
    ];
}
