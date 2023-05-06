{ lib, pkgs, config, ... }:
let
  inherit (lib) mkEnableOption mkDefault mkIf mdDoc;
  cfg = config.hardware.video.hidpi;
in
{
  # FIXME: (mkRemovedOptionModule [ "hardware" "video" "hidpi" "enable" ] fontconfigNote)
  options.hardware.video.hidpi.enable =
    mkEnableOption (mdDoc "Font/DPI configuration optimized for HiDPI displays");

  config = mkIf cfg.enable {
    disabledModules = [ ];

    console.font = mkDefault "${pkgs.terminus_font}/share/consolefonts/ter-v32n.psf.gz";

    # Needed when typing in passwords for full disk encryption
    console.earlySetup = mkDefault true;
    boot.loader.systemd-boot.consoleMode = mkDefault "1";

    # Grayscale anti-aliasing for fonts
    fonts.fontconfig.antialias = mkDefault true;
    fonts.fontconfig.subpixel = {
      rgba = mkDefault "none";
      lcdfilter = mkDefault "none";
    };
  };
}
