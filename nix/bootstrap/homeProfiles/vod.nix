{ inputs, cell, }:
{
  imports = with cell.homeProfiles; [ default git ];

  programs.git.userName = "Voob of Doom";
  programs.git.userEmail = "vod@njk.li";
  programs.git.signing.key = "E3C4C12EDF24CA20F167CC7EE203A151BB3FD1AE";
  programs.git.extraConfig.github.user = "voobscout";

  # xsession.profileExtra = ''
  #   export SSH_AUTH_SOCK=$XDG_RUNTIME_DIR/ssh-agent.socket;
  # '';
}
