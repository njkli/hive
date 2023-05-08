{ inputs, cell, ... }:
final: prev:

let
  inherit (prev) callPackage;
  inherit (prev.nur.repos.rycee.firefox-addons) buildFirefoxXpiAddon;
  inherit (inputs.cells.common.lib) __inputs__ rakeLeaves flattenTree;
  inherit (final.lib) filterAttrs last splitString mapAttrs' mapAttrs nameValuePair listToAttrs;
  inherit (builtins) elem;

  sources =
    (callPackage ../packages/_sources/_sources/generated.nix { }) //
    (callPackage ../packages/_sources_emacs/_sources/generated.nix { }) //
    { vscode-extensions = callPackage ../../utils/overlays/vscode/_sources/generated.nix { }; };

  vscode-extensions =
    let
      pkgsWithVscodeExtensions = inputs.nixpkgs.appendOverlays [ __inputs__.devos-ext-lib.overlays.vscode-extensions ];
    in
    prev.vscode-extensions //
    (pkgsWithVscodeExtensions.lib.vscode-utils.builders.default
      { srcs = (filterAttrs (k: v: v ? publisher) final.sources.vscode-extensions); });

  # listToAttrs ( attrValues (filterAttrs (k: v: k != "override" && k != "overrideDerivation") firefox-addons))

  firefox-addons =
    (mapAttrs
      (_: v:
        nameValuePair _ (final.fetchFirefoxAddon { inherit (v) url sha256; name = v.pname; }))
      (callPackage ../packages/_sources_firefox-addons/generated.nix { }));

  filtered = [
    "_sources"
    "_sources_emacs"
    "_sources_firefox-addons"
  ];

  ourPkgs = mapAttrs'
    (k: v:
      nameValuePair (last (splitString "." k)) (final.callPackage v { }))
    (flattenTree (filterAttrs (k: v: !(elem k filtered)) (rakeLeaves ../packages)));

  mkWaylandApp = t: e: f:
    prev.stdenv.mkDerivation {
      pname = t.pname or t.name + "-mkWaylandApp";
      inherit (t) version;
      unpackPhase = "true";
      doBuild = false;
      nativeBuildInputs = [ prev.buildPackages.makeWrapper ];
      installPhase = ''
        mkdir -p $out/bin
        ln -s "${prev.lib.getBin t}/bin/${e}" "$out/bin"
        ln -s "${prev.lib.getBin t}/share" "$out/share"
      '';
      postFixup = ''
        for e in $out/bin/*; do
          wrapProgram $e --add-flags ${prev.lib.escapeShellArg f}
        done
      '';
    };

  lib = prev.lib.extend (lself: lsuper:
    { age.file = file: lsuper.path.append ../secretProfiles file; });

in

{
  inherit
    sources
    vscode-extensions
    buildFirefoxXpiAddon
    firefox-addons
    mkWaylandApp
    lib;

  inherit (__inputs__.nickel.packages) nickel;
  inherit (__inputs__.nil.packages) nil;
  inherit (__inputs__.nixpkgs-hardenedlinux.packages) gptcommit;

  inherit (ourPkgs)
    # git-get
    shflags
    shellspec
    getoptions
    rainbowsh
    # git-remote-ipfs
    # git-pr-mirror
    okteto
    pbkdf2-sha512
    paper-store
    # age-plugin-yubikey
    all-the-icons
    uhk-agent
    kea-ma
    zeronsd
    # FIXME: gitea-tea
    windows-fonts
    make-desktopitem
    xxhash2mac
    # huginn
    # activitywatch
    dbus-listen
    gpg-hd;

  ipxe-git = ourPkgs.ipxe;
}
