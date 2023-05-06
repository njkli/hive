{ pkgs, ... }:
{
  fonts = {
    fontDir.enable = true;
    enableGhostscriptFonts = true;
    fonts = with pkgs; [
      (nerdfonts.override (_: {
        fonts = [
          "InconsolataLGC"
          "Ubuntu"
          "DejaVuSansMono"
          "DroidSansMono"
          "JetBrainsMono"
          "ShareTechMono"
          "UbuntuMono"
          "VictorMono"
        ];
      }))
      dejavu_fonts
      roboto
      freefont_ttf
      tlwg
      corefonts
      terminus_font
    ];
  };
}
