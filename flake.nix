{
  description = "The Hive - The secretly open NixOS-Society";

  inputs = {
    # std.url = "/home/guangtao/ghq/github.com/divnix/std";
    # /a0f9dd33cff37e2c532e2c236d011e2ecd77286d
    std.url = "github:divnix/std";
    std.inputs.nixpkgs.follows = "nixpkgs";
    std.inputs.arion.follows = "arion";
    std.inputs.microvm.follows = "microvm";
    dmerge.follows = "std/dmerge";

    std-ext.url = "github:gtrunsec/std-ext"; # /e6051e0d520217695797e44f8a37a6ea40299f1b
    # std-ext.inputs.flops.inputs.dmerge.follows = "dmerge";

    std-ext.inputs.std.follows = "std";
    std-data-collection.follows = "std-ext/std-data-collection";

    hive.url = "github:divnix/hive";
  };
  inputs.hive.inputs = {
    nixos-generators.follows = "nixos-generators";
    colmena.follows = "colmena";
    disko.follows = "disko";
  };
  # tools
  inputs = {
    nix-filter.url = "github:numtide/nix-filter";
    nixos-generators.url = "github:nix-community/nixos-generators";
    nixos-hardware.url = "github:nixos/nixos-hardware";
    disko.url = "github:nix-community/disko";
    disko.inputs.nixpkgs.follows = "nixpkgs";

    colmena.url = "github:zhaofengli/colmena";
    colmena.inputs.nixpkgs.follows = "nixpkgs";

    microvm.url = "github:astro/microvm.nix";

    arion.url = "github:hercules-ci/arion";
    arion.inputs.nixpkgs.follows = "nixpkgs";

    nur.url = "github:nix-community/NUR";
  };

  # nixpkgs & home-manager
  inputs = {
    # https://github.com/NixOS/nixpkgs/issues/97379
    # NOTE: PR accepted and merged  nixpkgs-activitywatch.url = "github:NixOS/nixpkgs?ref=pull/202935/head";

    nixpkgs.follows = "nixpkgs-unstable";
    nixpkgs-unstable.url = "github:nixos/nixpkgs/nixpkgs-unstable";
    nixpkgs-master.url = "github:nixos/nixpkgs";

    darwin.url = "github:LnL7/nix-darwin";
    darwin.inputs.nixpkgs.follows = "nixpkgs";

    nixos.follows = "nixos-unstable";
    nixos-unstable.url = "github:nixos/nixpkgs/nixos-unstable-small";

    nixos-unstable-linux_6_2.url = "github:nixos/nixpkgs/63464b8c2837ec56e1d610f5bd2a9b8e1f532c07";

    nixos-22-11.url = "github:nixos/nixpkgs/release-22.11";

    home-22-11.url = "github:nix-community/home-manager/release-22.11";
    home-22-11.inputs.nixpkgs.follows = "nixos-22-11";

    home.url = "github:nix-community/home-manager";
    home.inputs.nixpkgs.follows = "nixos";
  };

  # individual inputs
  inputs = {
    nix-doom-emacs.url = "github:nix-community/nix-doom-emacs";
    nix-doom-emacs.inputs.nixpkgs.follows = "nixos";

    emacs-overlay.url = "github:nix-community/emacs-overlay";
    emacs-overlay.inputs.nixpkgs.follows = "nixos";
  };

  outputs =
    { self
    , std
    , nixpkgs
    , hive
    , ...
    } @ inputs:
    std.growOn
      {
        inherit inputs;
        cellsFrom = ./nix;
        systems = [ "aarch64-linux" "x86_64-linux" ];

        cellBlocks = with std.blockTypes;
          with hive.blockTypes; [
            # modules implement
            (functions "nixosModules")
            (functions "homeModules")
            (functions "devshellModules")

            # profiles activate
            (functions "nixosProfiles")
            (functions "hardwareProfiles")
            (functions "homeProfiles")
            (functions "devshellProfiles")
            (functions "userProfiles")
            (functions "secretProfiles")
            (functions "arionProfiles")
            (functions "microvmProfiles")

            # suites aggregate profiles
            (functions "nixosSuites")
            (functions "homeSuites")

            # configurations can be deployed
            colmenaConfigurations
            homeConfigurations
            nixosConfigurations
            diskoConfigurations

            (arion "arionConfigurations")
            (microvms "microvms")

            # devshells can be entered
            (devshells "devshells")

            # jobs can be run
            (runnables "entrypoints")
            (functions "apps")

            # lib holds shared knowledge made code
            (functions "lib")
            (functions "config")
            (installables "packages" { ci.build = true; })
            (functions "overlays")

            # nixago part
            (nixago "nixago")

            # containers collection
            (containers "containers" { ci.publish = true; })
          ];
      }
      {
        devShells = std.harvest inputs.self [
          [ "automation" "devshells" ]
          [ "emacs" "devshells" ]
        ];
        lib =
          (std.harvest inputs.self [ "_QUEEN" "lib" ]).x86_64-linux
          // { inherit (hive) collect; };
        overlays = {
          vod = (std.harvest inputs.self [ "vod" "overlays" ]).x86_64-linux;
        };
        packages = std.harvest inputs.self [ [ "vod" "packages" ] ];
        # apps = std.harvest inputs.self [["emacs" "apps"]];
      }
      # soil - the first (and only) layer implements adapters for tooling
      {
        # tools
        colmenaHive = hive.collect self "colmenaConfigurations";
        nixosConfigurations = hive.collect self "nixosConfigurations";
        homeConfigurations = hive.collect self "homeConfigurations";
        diskoConfigurations = hive.collect self "diskoConfigurations";
      };
  # --- Flake Local Nix Configuration ----------------------------
  nixConfig = {
    extra-substituters = [
      "https://hyprland.cachix.org"
      "https://colmena.cachix.org"
      "https://nixpkgs-wayland.cachix.org"
      "https://cachix.org/api/v1/cache/emacs"
      "https://microvm.cachix.org"
    ];
    extra-trusted-public-keys = [
      "nixpkgs-wayland.cachix.org-1:3lwxaILxMRkVhehr5StQprHdEo4IrE8sRho9R9HOLYA="
      "hyprland.cachix.org-1:a7pgxzMz7+chwVL3/pzj6jIBMioiJM7ypFP8PwtkuGc="
      "colmena.cachix.org-1:7BzpDnjjH8ki2CT3f6GdOk7QAzPOl+1t3LvTLXqYcSg="
      "microvm.cachix.org-1:oXnBc6hRE3eX5rSYdRyMYXnfzcCxC7yKPTbZXALsqys="
    ];
  };
}
