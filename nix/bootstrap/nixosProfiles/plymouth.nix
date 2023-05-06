{ config, pkgs, ... }:

{
  boot.plymouth.enable = true;
  boot.plymouth.font =
    let
      nerdFonts = head (filter (e: e ? pname && e.pname == "nerdfonts") config.fonts.fonts);
      dumbDrv = pkgs.runCommandNoCC "dumb-nerdfonts-pkg-plymouth" { buildInputs = [ nerdFonts ]; } ''
        mkdir -p $out
        cp '${nerdFonts}/share/fonts/truetype/NerdFonts/Ubuntu Medium Nerd Font Complete Mono.ttf' $out/nerd_font_ubuntu_mono.ttf
      '';
    in
    "${dumbDrv}/nerd_font_ubuntu_mono.ttf";
  boot.plymouth.extraConfig = ''
    DeviceScale=2
  '';

}
