{ inputs, cell, ... }:
let
  init = { modulesPath, ... }:
    { imports = [ (modulesPath + "/profiles/qemu-guest.nix") ]; };
in
rec {
  bee.system = "x86_64-linux";
  bee.home = inputs.home;
  bee.pkgs = import inputs.nixos {
    inherit (inputs.nixpkgs) system;
    config.allowUnfree = true;
    config.permittedInsecurePackages = [ "python-2.7.18.6" ];
    overlays = cell.overlays.desktop;
  };
  imports =
    [
      init
      bee.home.nixosModules.home-manager
      cell.hardwareProfiles.libvirtd
      (cell.nixosProfiles.default { boot = "boot"; })
      inputs.cells.secrets.nixosProfiles.age
      {
        networking.hostName = "libvirtd";
        networking.hostId = "1f4f02f0";
      }
    ] ++
    cell.nixosSuites.base ++
    cell.nixosSuites.networking;
}
