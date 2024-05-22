{ pkgs, ... }:
let
  inherit (builtins) attrNames attrValues;
  pairs = {
    "http://nix-community.cachix.org" = "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs=";
    "https://poetry2nix.cachix.org" = "poetry2nix.cachix.org-1:2EWcWDlH12X9H76hfi5KlVtHgOtLa1Xeb7KjTjaV/R8=";
    "https://ibis.cachix.org" = "ibis.cachix.org-1:tKNWCdKmBXJFK1JE/SnA41z7U7XPFOnB7Nw0vLKXaLA=";
    "https://ibis-substrait.cachix.org" = "ibis-substrait.cachix.org-1:9QMhfByEHEl46s4tqVcRiyiOct2bnmZ23BJk4NTgGGI=";
    "https://njk.cachix.org" = "njk.cachix.org-1:ON4lemYq096ZfK5MtL1NU3afFk9ILAsEnXdy5lDDgKs=";
    "https://nrdxp.cachix.org" = "nrdxp.cachix.org-1:Fc5PSqY2Jm1TrWfm88l6cvGWwz3s93c6IOifQWnhNW4=";
    "https://colmena.cachix.org" = "colmena.cachix.org-1:7BzpDnjjH8ki2CT3f6GdOk7QAzPOl+1t3LvTLXqYcSg=";
    "https://microvm.cachix.org" = "microvm.cachix.org-1:oXnBc6hRE3eX5rSYdRyMYXnfzcCxC7yKPTbZXALsqys=";
    "https://emacs.cachix.org" = "emacs.cachix.org-1:b1SMJNLY/mZF6GxQE+eDBeps7WnkT0Po55TAyzwOxTY=";
  };
in

{
  nix.package = pkgs.nixUnstable;
  nix.optimise.automatic = true;
  nix.nrBuildUsers = 0;
  nix.gc.automatic = true;
  nix.gc.dates = "weekly";
  nix.gc.options = "--delete-older-than 30d";
  nix.settings.nix-path = [ "nixpkgs=${pkgs.path}" ];
  nix.settings.allowed-users = [ "@wheel" ];
  nix.settings.trusted-users = [ "root" "@wheel" ];
  nix.settings.auto-optimise-store = true;
  nix.settings.substituters = attrNames pairs;
  nix.settings.trusted-public-keys = attrValues pairs;
  nix.settings.sandbox = true;
  nix.settings.builders-use-substitutes = true;
  nix.settings.keep-derivations = true;
  nix.settings.auto-allocate-uids = true;
  nix.settings.use-cgroups = true;
  nix.settings.system-features = [
    "nixos-test"
    "benchmark"
    "big-parallel"
    "kvm"
    "recursive-nix"
  ];
  nix.settings.experimental-features = [
    "nix-command"
    "flakes"
    # https://github.com/NixOS/nix/issues/6666
    # https://github.com/NixOS/nixpkgs/issues/177142
    # BUG: "ca-derivations"
    "auto-allocate-uids"
    "cgroups"
    # "recursive-nix"
  ];
  nix.extraOptions = ''
    min-free = 536870912
    accept-flake-config = true
    fallback = true
    keep-outputs = true
    keep-derivations = true
  '';
}
