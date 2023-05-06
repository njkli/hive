{ lib, pkgs, config, ... }:
let dotDir = ".config/zsh"; in
lib.mkIf config.programs.zsh.enable
{
  home.file."${dotDir}/lib".source = ./libzsh;
  # NOTE: skim is a rust replacement for perl programs.fzf.enable = true;

  # TODO: maybe replace it with https://github.com/cantino/mcfly
  programs.skim = {
    enable = true;
    defaultCommand = "fd --type f";
    defaultOptions = [ "--ansi" "--height 30%" "--prompt ⟫" ];
    fileWidgetCommand = "fd --type f";
    fileWidgetOptions = [ "--preview 'head {}'" ];
    changeDirWidgetCommand = "fd --type d";
    changeDirWidgetOptions = [ "--preview 'tree -C {} | head -200'" ];
    historyWidgetOptions = [ "--tiebreak score,index,-begin" "--exact" ];
  };

  programs.man.enable = true;
  programs.man.generateCaches = true;

  programs.readline.enable = true;
  programs.readline.bindings = {
    "\\C-h" = "backward-kill-word";
  };

  programs.zsh.dotDir = dotDir;
  programs.zsh.initExtra = ''
    autoload -Uz +X bashcompinit && bashcompinit
    ${lib.optionalString (lib.elem pkgs.navi config.home.packages) "source <(navi widget zsh)"}
    for config_file ($ZDOTDIR/lib/*.zsh); do
      source $config_file
    done
  '';

  programs.zsh.autocd = true;

  programs.zsh.defaultKeymap = "emacs";
  programs.zsh.history.path = "$HOME/Logs/zsh_history";
  programs.zsh.history.size = 1000000;
  programs.zsh.history.ignoreDups = true;
  programs.zsh.history.extended = true;
  programs.zsh.history.share = true;

  programs.zsh.dirHashes.docs = "$HOME/Documents";
  programs.zsh.dirHashes.vids = "$HOME/Videos";
  programs.zsh.dirHashes.bins = "$HOME/bin";

  programs.zsh.shellAliases = {
    sr = "surfraw";
    _ = "sudo";
    cp = "rsync -avh --progress";
    md = "mkdir -p";
    df =
      let
        fsTypes = [
          "f2fs"
          "vfat"
          "hfsplus"
          "fuseblk"
          "cifs"
          "exfat"
          "ext4"
          "ext3"
          "ext2"
          "fuse"
          "fuse.encfs"
          "fuse.sshfs"
          "fuse.cryfs"
          "fuse.gocryptfs"
          "fuse.mergerfs"
          "ntfs"
          "zfs"
          "xtreemfs"
          "xfs"
          "nfs"
          "nfs4"
          "iso9660"
        ];
        dfAliases = lib.concatMapStringsSep " " (x: "--type=${x}") fsTypes;
      in
      "df -haT ${dfAliases}";
    docker-ps = "docker ps --format \"table {{.Names}}\t{{.RunningFor}}\t{{.Image}}\"";
    docker-stats = "docker ps --format \"{{ .Names }}\" | xargs docker stats";
    du = "du -sh";
    free = "free -h";
    ec = "emacsclient -c";
    gzip = "pigz";
    history = "fc -El 1";
    ls = "ls -gh --group-directories-first -p -X --color";
    grep = "rg";
    myip = "dig +short myip.opendns.com @resolver1.opendns.com";
    top = "${pkgs.btop}/bin/btop";
  };

  programs.zsh.localVariables = {
    WORDCHARS = "*?_-.[]~=&;!#$%^(){}<>";
    MOTION_WORDCHARS = "*?_-.[]~=&;!#$%^(){}<>/";
    ZSH_DISABLE_COMPFIX = true; # NOTE: required when plugin dirs are in /nix/store
    ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE = "fg=#839496,bold,underline";
    TIPZ_TEXT = "💡 ";
    # ZSH_COLORIZE_TOOL = "pygmentize";
    ZLE_RPROMPT_INDENT = 0;
  };

  programs.zsh.plugins =
    let
      omz_plugins =
        map
          (name: {
            inherit name;
            file = "plugins/${name}/${name}.plugin.zsh";
            src = pkgs.sources.zsh-plugin_oh-my-zsh.src;
          }) [
          "urltools"
          "transfer"
          "systemd"
          "docker"
          "docker-compose"
          "rsync"
          "repo"
          "httpie"
          "github"
          "git-extras"
          "git"
          # "emacs"
          "encode64"
          "colorize"
          "colored-man-pages"
        ];
    in
    omz_plugins ++ [
      {
        name = "zsh-history-substring-search";
        file = "zsh-history-substring-search.plugin.zsh";
        src = pkgs.sources.zsh-plugin_zsh-history-substring-search.src;
      }

      {
        name = "zsh-completions";
        file = "zsh-completions.plugin.zsh";
        src = pkgs.sources.zsh-plugin_zsh-completions.src;
      }

      {
        name = "autoenv";
        file = "autoenv.plugin.zsh";
        src = pkgs.sources.zsh-plugin_zsh-autoenv.src;
      }

      {
        name = "clipboard";
        file = "clipboard.plugin.zsh";
        src = pkgs.sources.zsh-plugin_clipboard.src;
      }

      {
        name = "k";
        file = "k.plugin.zsh";
        src = pkgs.sources.zsh-plugin_k.src;
      }

      {
        name = "zsh-syntax-highlighting";
        file = "zsh-syntax-highlighting.plugin.zsh";
        src = pkgs.sources.zsh-plugin_zsh-syntax-highlighting.src;
      }

      {
        name = "tipz";
        file = "tipz.zsh";
        src = pkgs.sources.zsh-plugin_tipz.src;
      }

      {
        name = "zsh-autopair";
        file = "zsh-autopair.plugin.zsh";
        src = pkgs.sources.zsh-plugin_zsh-autopair.src;
      }

      {
        name = "zsh-256color";
        file = "zsh-256color.plugin.zsh";
        src = pkgs.sources.zsh-plugin_zsh-256color.src;
      }

    ];
}
