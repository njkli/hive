{ inputs, cell, ... }:
let
  nixpkgs-unstable-latest = import inputs.nixpkgs-unstable-latest {
    inherit (inputs.nixpkgs) system;
    config.allowUnfree = true;
  };

  nixpkgs-unstable = import inputs.nixpkgs-unstable {
    inherit (inputs.nixpkgs) system;
    config.allowUnfree = true;
  };

  nixos-unstable-linux_6_2 = import inputs.nixos-unstable-linux_6_2 {
    inherit (inputs.nixpkgs) system;
    config.allowUnfree = true;
  };

  nixos-unstable-linux_6_5 = import inputs.nixos-unstable-linux_6_5 {
    inherit (inputs.nixpkgs) system;
    config.allowUnfree = true;
  };

  nixpkgs-master = import inputs.nixpkgs-master {
    inherit (inputs.nixpkgs) system;
    config.allowUnfree = true;
  };

  nixpkgs-22-11 = import inputs.nixos-22-11 {
    inherit (inputs.nixpkgs) system;
    config.allowUnfree = true;
  };

in
final: prev: {
  inherit (nixos-unstable-linux_6_2) linuxPackages_6_2;
  inherit (nixos-unstable-linux_6_5) linuxPackages_6_5;
  inherit (nixpkgs-unstable-latest)
    activitywatch
    nyxt
    keybase
    keybase-gui
    kbfs
    ;
  # inherit (nixpkgs-22-11) nyxt;

  inherit (nixpkgs-master.nodePackages)
    bash-language-server
    dockerfile-language-server-nodejs
    vscode-json-languageserver-bin
    vscode-css-languageserver-bin
    graphql-language-service-cli
    vscode-html-languageserver-bin;

  inherit (nixpkgs-unstable)
    tilix
    #
    dhall
    discord
    element-desktop
    signal-desktop
    qtox
    utox
    #
    rage
    age
    ssh-to-age
    step-ca step-cli
    #
    starship
    xml2
    xmlformat
    oq
    arcan
    stumpwm
    ipfs-cluster
    #
    cachix
    #
    any-nix-shell
    zsh-nix-shell
    # cached-nix-shell

    niv
    dconf2nix

    # nix-top
    # nix-du
    # nix-tree
    # nix-bundle
    # nix-diff
    # nix-index
    # nix-prefetch-scripts
    # nix-info
    # nix-update
    # nix-update-source
    # nix-plugins
    # nix-universal-prefetch
    # nix-prefetch-github
    # nix-prefetch-docker
    # nixpkgs-review
    # nix-linter
    # nix-template
    # nix-template-rpm
    # nixos-shell
    nix-script
    nixpkgs-fmt
    nixbang
    # nixfmt # NOTE: This is a dubious haskell pkgs, maybe just remove this comment and the ref to pkg?
    rnix-lsp
    #
    dpkg
    # printer stuff
    cups-kyocera-ecosys-m552x-p502x
    ### TERMINAL MUX
    abduco
    dvtm
    ### cli-tools
    nnn
    ix
    # Networking stuff
    nebula

    # NOTE: https://github.com/NixOS/nixpkgs/issues/148538#issuecomment-1009887524
    # pcsclite
    # pcsctools
    # gnupg
    # gpgme

    # kdeconnect

    udisks
    volume_key
    gvfs

    # Kubernetes
    k3s
    k9s
    kubectl
    kubernetes-helm
    kubernetes-helmPlugins;

  inherit (nixpkgs-master)
    # Broken? ventoy-bin
    ventoy-bin-full
    #
    opensnitch
    opensnitch-ui
    #
    yaml-language-server
    texlab
    #
    cloud-hypervisor
    #
    droidcam
    #
    bisq-desktop# decentralized bitcoin exchange
    #
    pass-secret-service
    passff-host
    #
    ledger-live-desktop
    trezor_agent
    trezorctl
    # bibata-cursors
    # brave
    firefox
    firefox-esr
    #
    lorri
    manix
    nix-zsh-completions
    nix-tree
    #
    crystal;

  python3Override = nixpkgs-master.python3;
  makeDesktopItem = final.make-desktopitem;
  xorg_cvt = nixpkgs-22-11.xorg.xorgserver;
  # rustPlatform = prev.makeRustPlatform {
  #   # inherit (final.rust-bin.stable.latest) cargo rustc;
  #   cargo = final.rust-bin.stable.latest.cargo;
  #   rustc = final.rust-bin.stable.latest.rustc // { meta.platforms = [ final.rust-bin.stable.latest.rustc.platform ]; };
  # };
}
