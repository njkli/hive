{ inputs, cell, }:
{
  imports = with cell.homeProfiles; [ default git ];

  # xsession.profileExtra = ''
  #   export SSH_AUTH_SOCK=$XDG_RUNTIME_DIR/ssh-agent.socket;
  # '';
}
