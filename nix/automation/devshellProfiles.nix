{ inputs, cell, ... }:
let
  inherit (inputs) nixpkgs;
  inherit (inputs.std-ext.common.lib) __inputs__;

  terraform-providers-bin = __inputs__.terraform-providers.legacyPackages.providers;

  terraform-with-plugins =
    nixpkgs.terraform.withPlugins
      (p: nixpkgs.lib.attrValues (providers p));

  providers = p: {
    inherit (terraform-providers-bin.hashicorp) nomad aws template;
    inherit (terraform-providers-bin.dmacvicar) libvirt;
    inherit (terraform-providers-bin.carlpett) sops;
    inherit (terraform-providers-bin.cloudflare) cloudflare;
  };
in
{
  terraform = {
    commands = [
      { package = terraform-with-plugins // { meta.name = "terraform"; }; }
    ];
  };
}
