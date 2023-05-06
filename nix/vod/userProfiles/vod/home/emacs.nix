{ pkgs, profiles, ... }:
let
  vodEmacsPkg = pkgs.emacs;
  vodEmacsExtraPkgs =
    let
      emacsPackages = pkgs.emacsPackagesFor vodEmacsPkg;

      customSetts = emacsPackages.trivialBuild rec {
        pname = "custom-setts-vod";
        ename = pname;
        version = "1.0";
        src = pkgs.writeText "custom-setts-vod.el" ''
          (defvar vod-setts-custom-from-nix "${pkgs.nodejs}/bin/node")
          (provide 'custom-setts-vod)
        '';
      };

      # lsp-install-servers = emacsPackages.trivialBuild {
      #   pname = "lsp-install-servers";
      #   version = "1.0";
      #   src = pkgs.writeText "lsp-install-servers.el" ''
      #     (eval-after-load 'lsp-mode
      #       '(progn
      #          (require 'lsp-javascript)
      #          (lsp-dependency 'typescript-language-server `(:system "${pkgs.nodePackages.typescript-language-server}/bin/typescript-language-server"))
      #          (lsp-dependency 'typescript `(:system "${pkgs.nodePackages.typescript}/bin/tsserver"))))
      #   '';
      #   packageRequires = [ emacsPackages.lsp-mode ];
      # };
    in
    with emacsPackages; [
      customSetts

      s
      sqlite
      sqlite3
      # vterm
      # vterm-toggle
      grab-x-link
      sly
      sly-asdf
      sly-macrostep
      sly-named-readtables
      sly-quicklisp
      sly-repl-ansi-color
    ];
in

{
  imports = [ profiles.emacs ];

  # FIXME: programs.promnesia.enable = true;
  # programs.promnesia.configFile = ../dotfiles/promnesia/config.py;

  programs.doom-emacs.enable = true;
  programs.doom-emacs.emacsPackage = vodEmacsPkg;
  programs.doom-emacs.extraPackages = vodEmacsExtraPkgs;
  programs.doom-emacs.doomPrivateDir = pkgs.callPackage ../dotfiles/doom.d.nix { };
  programs.doom-emacs.emacsPackagesOverlay = self: super: {
    org-pretty-table = self.trivialBuild {
      inherit (pkgs.sources.org-pretty-table) pname version src;
      ename = "org-pretty-table";
      packageRequires = with self; [ org ];
    };

    org-protocol-capture-html = self.trivialBuild {
      inherit (pkgs.sources.org-protocol-capture-html) pname version src;
      ename = "org-protocol-capture-html";
      buildInputs = with pkgs; [ pandoc curl ];
      packageRequires = with self; [ org s ];
    };

    activity-watch-mode = self.trivialBuild {
      inherit (pkgs.sources.activity-watch-mode) pname version src;
      ename = "activity-watch-mode";
      packageRequires = with self; [ request cl-lib ];
    };

    copilot = self.trivialBuild {
      inherit (pkgs.sources.copilot-el) pname version src;
      ename = "copilot";
      buildInputs = with pkgs; [ nodejs ];
      packageRequires = with self; [ s dash editorconfig ];
    };

    color-rg = self.trivialBuild rec {
      inherit (pkgs.sources.color-rg) pname version src;
      ename = pname;
      buildInputs = with pkgs; [ ripgrep ];
    };

    # nix-mode = self.trivialBuild {
    #   inherit (pkgs.sources.nix-mode) src pname ename version;
    #   packageRequires = with self; [ emacs magit-section transient mmm-mode company ];
    # };
  };

  home.sessionVariables.EMACS_PATH_COPILOT = "${pkgs.sources.copilot-el.src}";
  # ("voobscout^forge" for "api.github.com")

  home.file.".authinfo.gpg".source = ./authinfo.gpg;

  programs.chemacs.enable = false;

  ### FIXME: doomemacs doesn't recognize installed language servers.
  home.file."bin/json-ls".source = "${pkgs.vscode-json-languageserver-bin}/bin/json-languageserver";
  home.file."bin/html-ls".source = "${pkgs.vscode-html-languageserver-bin}/bin/html-languageserver";
  home.file."bin/css-ls".source = "${pkgs.vscode-css-languageserver-bin}/bin/css-languageserver";

  home.packages = with pkgs; [
    python39Packages.grip
    python39Full # treemacs seems to want that
    gnuplot

    openjdk11 # plantuml preview and friends
    nodejs # copilot seems to need it

    # Language servers
    yaml-language-server
    bash-language-server
    texlab # TeX language-server
    dockerfile-language-server-nodejs
    vscode-json-languageserver-bin
    vscode-css-languageserver-bin
    vscode-html-languageserver-bin
    ocamlPackages.digestif

    nodePackages.js-beautify
    nodePackages.stylelint
    tidyp
    html-tidy

    (texlive.combine {
      inherit (texlive)
        # scheme-basic
        scheme-full
        xcolor
        xcolor-solarized
        koma-script
        koma-script-examples
        koma-script-sfs;
    })
  ];

  # programs.chemacs.enable = true;
  # programs.chemacs.profiles = {
  #   spacemacs.package = pkgs.sources.spacemacs.src;
  #   spacemacs.cfgDir = "${self}/users/${name}/dotfiles/spacemacs.d";
  #   spacemacs.envName = "SPACEMACSDIR";
  #   spacemacs.binInPath = false;

  #   doom-emacs.default = true;
  #   doom-emacs.package = pkgs.sources.doom-emacs.src;
  #   doom-emacs.cfgDir = "${self}/users/${name}/dotfiles/doom.d";
  #   doom-emacs.envName = "DOOMDIR";
  #   # doom-emacs.extraSessionVariables.DOOMDIR = "${config.xdg.configHome}/chemacs/doom-emacs";
  #   doom-emacs.extraSessionVariables.DOOMLOCALDIR = "${config.xdg.dataHome}/chemacs/doom-emacs";
  #   doom-emacs.binInPath = true;
  #   doom-emacs.linkCfg = false; # TODO: Config is writable like this

  #   # doom-emacs.onCfgChangePerFile = '''';
  #   doom-emacs.updateCmd = ''
  #     cfgDir=$XDG_PROJ_DIR/world/users/${name}/dotfiles/doom.d
  #     # "lisp" "etc"
  #     linkables=("modules" "lisp" "snippets" "config.org")

  #     for item in ''${linkables[@]}
  #     do
  #       ln -sfT $cfgDir/$item $DOOMDIR/$item
  #     done

  #     cd $DOOMDIR
  #     emacs -Q -batch -l 'lisp/compile.el'
  #     doom sync
  #   '';

  #   doom-emacs.emacsOpts.package = vodEmacsPkgPgtkNativeComp;
  #   doom-emacs.emacsOpts.extraPackages = vodEmacsExtraPkgs;
  # };
  # home.sessionVariables.DOOMDIR = "${config.xdg.configHome}/chemacs/doom-emacs";

  # systemd.user.services.emacs.Unit.ConditionPathExists = "%h/Projects/world/users/%u/dotfiles/doom.d/config.org";

}
