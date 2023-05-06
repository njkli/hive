{
  programs.gh.enable = true;
  programs.gh.settings.git_protocol = "ssh";

  programs.git.lfs.enable = true;
  programs.git.delta.enable = true;
  programs.git.userName = "Voob of Doom";
  programs.git.userEmail = "vod@njk.li";
  programs.git.ignores = [ "*~" "*.swp" "target" "result" ".direnv/" ];
  programs.git.signing.key = "E3C4C12EDF24CA20F167CC7EE203A151BB3FD1AE";
  programs.git.signing.signByDefault = true;
  programs.git.extraConfig = {
    github.user = "voobscout";
    init.defaultBranch = "master";
    branch.autoSetupRebase = "always";
    checkout.defaultRemote = "origin";
    # pull.rebase = true;
    # pull.ff = "only";
    push.default = "current";
    format.signoff = true;
    # rebase.autosquash = true;
    merge.conflictStyle = "diff3";
    credential.helper = "cache";
  };
}
