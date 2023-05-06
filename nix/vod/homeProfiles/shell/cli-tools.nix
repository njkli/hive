{ pkgs, ... }:
{
  home.packages = with pkgs; [
    tmate #TODO: make a home-manager module - https://tmate.io/ Instant terminal sharing

    nmap
    curl
    wget
    gping

    # Process management
    psmisc
    procs
    tree

    ##
    mc
    ncdu
    rsync
    lsyncd
    broot # An interactive tree view, a fuzzy search, a balanced BFS descent and customizable commands

    ###
    hyperfine # Command-line benchmarking tool

    iotop
    iftop
    nload
    iptraf-ng
    nethogs
    vnstat
    bwm_ng
    iperf

    sipcalc # Advanced console ip subnet calculator

    fd # A simple, fast and user-friendly alternative to find

    manix # A Fast Documentation Searcher for Nix
    nix-index # A files database for nixpkgs

    # bottom # A cross-platform graphical process/system monitor with a customizable interface
    btop # top alternative

    jq # command-line JSON processor
    oq # A performant, and portable jq wrapper
    pup # jq for html
    sd # Intuitive find & replace CLI (sed alternative)
    choose # A human-friendly and fast alternative to cut and (sometimes) awk

    python3Packages.pygments # A generic syntax highlighter

    ix # cli pastebin
    ripgrep # A utility that combines the usability of The Silver Searcher with the raw speed of grep
    skim # Command-line fuzzy finder written in Rust
    tealdeer # A very fast implementation of tldr in Rust
    ack # needed by hhighlighter
    exa # ls replacement
    duf # A better df alternative
    loop # proper loop
    nnn # File manager
    navi # cheatsheet manager
    xsv # CSV processing for CLIs
    fselect # Find files with SQL-like queries

    xh # Friendly and fast tool for sending HTTP requests
    httpie # A command line HTTP client whose goal is to make CLI human-friendl
    curlie # Frontend to curl that adds the ease of use of httpie
    http-prompt # n interactive command-line HTTP client featuring autocomplete and syntax highlighting
    httplab # Interactive WebServer
    dogdns # Command-line DNS client


    gnutls
    surfraw
    w3m

    # python3Packages.pygments # Required by colorize
    # python3Packages.percol # unsupported for python3 Interractive '|' filter
    perl # fzf-history-widget() needs perl to sort input
    nnn # File manager

  ];
}
