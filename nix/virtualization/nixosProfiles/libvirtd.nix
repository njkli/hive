{ pkgs, lib, config, ... }:
let
  inherit (lib) mkMerge mkIf hasAttrByPath;
in
mkMerge [
  {
    boot.kernelModules = lib.mkDefault [ "kvm-intel" ];

    security.polkit.enable = true;

    # NOTE: https://github.com/NixOS/nixpkgs/issues/37540
    environment.systemPackages = with pkgs; [ libguestfs-with-appliance inetutils ];

    virtualisation.libvirtd.enable = true;
    virtualisation.libvirtd.allowedBridges = [ "all" ];
    virtualisation.libvirtd.qemu.ovmf.enable = true;
    virtualisation.libvirtd.qemu.package = pkgs.qemu_kvm;
    virtualisation.libvirtd.qemu.runAsRoot = false;

    virtualisation.spiceUSBRedirection.enable = true;
  }

  (mkIf config.services.xserver.enable {
    environment.systemPackages = with pkgs; [ virt-manager spice-gtk ];
  })
]
