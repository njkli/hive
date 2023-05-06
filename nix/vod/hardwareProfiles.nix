{ inputs, cell, ... }:
{

  libvirtd = { config, pkgs, lib, ... }:
    let
      diskoScripts = builtins.map
        (name: pkgs.writeScriptBin name config.system.build.${name})
        [ "disko" "formatScript" "mountScript" ];
    in
    {
      imports = [
        { environment.systemPackages = diskoScripts; }
        cell.nixosProfiles.zfs
        inputs.disko.nixosModules.disko
        {
          disko.devices = cell.diskoConfigurations.libvirtd { inherit lib; };
          disko.enableConfig = false;
        }
      ];
    };

  # desktop = { lib, ... }:
  #   {
  #     imports =
  #       [
  #         cell.nixosProfiles.zfs
  #         inputs.cells.filesystems.nixosProfiles.impermanence.vod
  #         inputs.cells.hardware.nixosProfiles.intel
  #         inputs.cells.hardware.nixosProfiles.default
  #         inputs.disko.nixosModules.disko
  #         { disko.devices = cell.diskoConfigurations.desktop { }; }
  #       ];
  #   };

  eadrax = { lib, ... }:
    {
      boot.initrd.availableKernelModules = [ "nvme" "nvme_core" ];
      disko.devices = cell.diskoConfigurations.eadrax { };
      imports =
        [
          cell.nixosProfiles.zfs
          inputs.cells.filesystems.nixosProfiles.impermanence.vod
          inputs.cells.hardware.nixosProfiles.intel
          inputs.cells.hardware.nixosProfiles.default
          inputs.disko.nixosModules.disko
        ];
    };

  asbleg = { lib, pkgs, ... }:
    {
      boot.consoleLogLevel = 0;
      disko.devices = cell.diskoConfigurations.asbleg { inherit lib; };
      imports =
        [
          inputs.cells.filesystems.nixosProfiles.impermanence.default
          inputs.cells.hardware.nixosProfiles.intel
          inputs.cells.hardware.nixosProfiles.default
          inputs.disko.nixosModules.disko
        ];

      boot.kernelParams = lib.mkAfter [
        # "i915.enable_dpcd_backlight=1"
        # "acpi_osi=!"
        # "acpi_osi=\"android\""
        # "i915.modeset=0"
        # "i915.modeset=1"
        # "i915.enable_dpcd_backlight=1"
        # "intel_idle.max_cstate=1"
      ];

      # enable_gvt=true reset=1
      boot.extraModprobeConfig = ''
        options i915 enable_guc=-1 enable_dpcd_backlight=1
      '';

      boot.kernelModules = [ "i915" "intel_pmc_mux" ];

      # boot.initrd.availableKernelModules = [
      #   # FIXME: remove unneeded ones later on
      #   "tls"
      #   "ccm"
      #   "rfcomm"
      #   "cmac"
      #   "algif_hash"
      #   "algif_skcipher"
      #   "af_alg"
      #   "bnep"
      #   "binfmt_misc"
      #   "nls_iso8859_1"
      #   "snd_sof_pci_intel_apl"
      #   "snd_sof_intel_hda_common"
      #   "soundwire_intel"
      #   "soundwire_generic_allocation"
      #   "soundwire_cadence"
      #   "snd_sof_intel_hda"
      #   "snd_sof_pci"
      #   "snd_sof_xtensa_dsp"
      #   "snd_sof"
      #   "soundwire_bus"
      #   "mei_hdcp"
      #   "snd_soc_skl"
      #   "snd_soc_hdac_hda"
      #   "intel_rapl_msr"
      #   "snd_hda_ext_core"
      #   "snd_soc_sst_ipc"
      #   "snd_soc_sst_dsp"
      #   "snd_hda_codec_hdmi"
      #   "snd_hda_codec_realtek"
      #   "snd_soc_acpi_intel_match"
      #   "snd_soc_acpi"
      #   "intel_pmc_bxt"
      #   "snd_hda_codec_generic"
      #   "snd_soc_core"
      #   "ledtrig_audio"
      #   "snd_compress"
      #   "intel_telemetry_pltdrv"
      #   "ac97_bus"
      #   "intel_punit_ipc"
      #   "intel_telemetry_core"
      #   "snd_pcm_dmaengine"
      #   "x86_pkg_temp_thermal"
      #   "intel_powerclamp"
      #   "snd_hda_intel"
      #   "coretemp"
      #   "snd_intel_dspcfg"
      #   "kvm_intel"
      #   "snd_intel_sdw_acpi"
      #   "snd_hda_codec"
      #   "kvm"
      #   "snd_hda_core"
      #   "rapl"
      #   "snd_hwdep"
      #   "intel_cstate"
      #   "snd_pcm"
      #   "serio_raw"
      #   "snd_seq_midi"
      #   "snd_seq_midi_event"
      #   "iwlmvm"
      #   "mac80211"
      #   "8250_dw"
      #   "btusb"
      #   "input_leds"
      #   "libarc4"
      #   "snd_rawmidi"
      #   "btrtl"
      #   "btbcm"
      #   "btintel"
      #   "snd_seq"
      #   "processor_thermal_device_pci_legacy"
      #   "bluetooth"
      #   "processor_thermal_device"
      #   "snd_seq_device"
      #   "processor_thermal_rfim"
      #   "ecdh_generic"
      #   "ecc"
      #   "processor_thermal_mbox"
      #   "iwlwifi"
      #   "snd_timer"
      #   "processor_thermal_rapl"
      #   "mei_me"
      #   "intel_rapl_common"
      #   "cfg80211"
      #   "snd"
      #   "intel_soc_dts_iosf"
      #   "mei"
      #   "soundcore"
      #   "mac_hid"
      #   "soc_button_array"
      #   "ucsi_acpi"
      #   "intel_hid"
      #   "int3403_thermal"
      #   "typec_ucsi"
      #   "int3400_thermal"
      #   "typec"
      #   "sparse_keymap"
      #   "int340x_thermal_zone"
      #   "acpi_thermal_rel"
      #   "sch_fq_codel"
      #   "msr"
      #   "parport_pc"
      #   "ppdev"
      #   "lp"
      #   "parport"
      #   "ramoops"
      #   "reed_solomon"
      #   "pstore_blk"
      #   "pstore_zone"
      #   "efi_pstore"
      #   "ip_tables"
      #   "x_tables"
      #   "autofs4"
      #   "dm_crypt"
      #   "hid_generic"
      #   "usbhid"
      #   "hid"
      #   "uas"
      #   "usb_storage"
      #   "spi_pxa2xx_platform"
      #   "dw_dmac"
      #   "dw_dmac_core"
      #   "crct10dif_pclmul"
      #   "crc32_pclmul"
      #   "ghash_clmulni_intel"
      #   "aesni_intel"
      #   "i2c_algo_bit"
      #   "ttm"
      #   "crypto_simd"
      #   "drm_kms_helper"
      #   "cryptd"
      #   "syscopyarea"
      #   "sysfillrect"
      #   "sysimgblt"
      #   "i2c_i801"
      #   "sdhci_pci"
      #   "ahci"
      #   "fb_sys_fops"
      #   "cqhci"
      #   "i2c_smbus"
      #   "sdhci"
      #   "cec"
      #   "rc_core"
      #   "intel_lpss_pci"
      #   "libahci"
      #   "intel_lpss"
      #   "r8169"
      #   "idma64"
      #   "xhci_pci"
      #   "drm"
      #   "xhci_pci_renesas"
      #   "realtek"
      #   "pinctrl_geminilake"
      # ];
    };

  folfanga = { lib, ... }:
    {
      boot.consoleLogLevel = 0;
      disko.devices = cell.diskoConfigurations.folfanga { inherit lib; };
      imports =
        [
          inputs.cells.filesystems.nixosProfiles.impermanence.default
          inputs.cells.hardware.nixosProfiles.intel
          inputs.cells.hardware.nixosProfiles.default
          inputs.cells.hardware.nixosProfiles.chuwi-tablet
          inputs.disko.nixosModules.disko
        ];
    };

  folfanga-1 = { lib, ... }:
    {
      boot.consoleLogLevel = 0;
      disko.devices = cell.diskoConfigurations.folfanga-1 { inherit lib; };
      imports =
        [
          inputs.cells.hardware.nixosProfiles.intel
          inputs.cells.hardware.nixosProfiles.default
          inputs.cells.hardware.nixosProfiles.chuwi-tablet
          inputs.disko.nixosModules.disko
        ];
    };

  folfanga-2 = { lib, ... }:
    {
      boot.consoleLogLevel = 0;
      disko.devices = cell.diskoConfigurations.folfanga-2 { inherit lib; };
      imports =
        [
          inputs.cells.hardware.nixosProfiles.intel
          inputs.cells.hardware.nixosProfiles.default
          inputs.cells.hardware.nixosProfiles.chuwi-tablet
          inputs.disko.nixosModules.disko
        ];
    };

}
