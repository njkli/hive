{ inputs, cell, }:
let
  inherit (inputs.nixpkgs.lib) mkDefault;
in
{
  programs.gh.enable = true;
  programs.gh.settings.git_protocol = "ssh";

  programs.git.enable = true;
  programs.git.lfs.enable = true;
  programs.git.delta.enable = true;
  programs.git.delta.options = mkDefault {
    plus-style = "syntax #012800";
    minus-style = "syntax #340001";
    syntax-theme = "Monokai Extended"; # TODO: change theme!
    navigate = true;
  };

  programs.git.signing.signByDefault = true;
  programs.git.extraConfig = {
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
    core.autocrlf = "input";
    rebase.autosquash = true;
    rerere.enabled = true;
  };
  programs.git.ignores = [
    "*~"
    "*.swp"
    "target"
    "result"
    ".projectile"
    ".indium.json"
    ".ccls-cache"
    ".Rhistory"
    ".notdeft*"
    "eaf"
    ".cache"
    ".org-src-babel"
    ".auctex-auto"
    "vast.db"
    ".ipynb_checkpoints"
    "__pycache__"
    "*.org.organice-bak"
    ".direnv"
    ".direnv/"
    ".direnv.d"
    ".secrets"
    ".cargo"
  ];
}
