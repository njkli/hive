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

  oglaroon = { lib, pkgs, ... }:
    {
      boot.kernelPackages = lib.mkForce pkgs.linuxPackages_6_5;
      services.xserver.videoDrivers = [ "amdgpu" ];
      hardware.opengl.extraPackages = [ pkgs.rocm-opencl-icd ];

      # boot.kernelPackages = pkgs.linuxKernel.packagesFor
      # (pkgs.linuxKernel.kernels.linux_5_10.override {
      #   structuredExtraConfig = {
      #     DEVICE_PRIVATE = kernel.yes;
      #     KALLSYMS_ALL = kernel.yes;
      #   };
      # });

      boot.initrd.availableKernelModules = [ "nvme" "nvme_core" ];
      disko.devices = cell.diskoConfigurations.oglaroon { inherit lib; };
      imports =
        [
          cell.nixosProfiles.zfs
          inputs.cells.filesystems.nixosProfiles.impermanence.vod
          inputs.cells.hardware.nixosProfiles.amd
          inputs.cells.hardware.nixosProfiles.default
          inputs.disko.nixosModules.disko
        ];
    };

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
      boot.kernelPackages = pkgs.linuxPackages_6_2;
      # boot.kernelPackages = pkgs.linuxPackages_latest;
      services.xserver.videoDrivers = [ "intel" ];

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
        # "nomodeset" # GPD MicroPC hardware quirk

        # "i915.enable_dpcd_backlight=3" # force intel
        # "i915.enable_guc=2"
        # "i915.modeset=1"
        # "i915.reset=1"
        # "i915.fastboot=0"
      ];

      boot.blacklistedKernelModules = [ "nouveau" ];
      # i915/glk_dmc_ver1_04.bin

      # https://wiki.archlinux.org/title/intel_graphics
      # i915
      # enable_gvt=1 reset=1
      # options i915 enable_guc=-1 enable_dpcd_backlight=1

      # boot.extraModprobeConfig = ''
      # '';

      # https://bbs.archlinux.org/viewtopic.php?id=261225
      # options snd_hda_codec_hdmi enable_silent_stream=0

      # boot.kernelModules = [ "intel_pmc_mux" ];

      boot.initrd.kernelModules = [ "drm" "intel_agp" "i915" ]; # Always load Intel graphics driver!

      # boot.initrd.availableKernelModules = [ ];
    };


  asbleg_test = { lib, pkgs, ... }:
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
        # "nomodeset" # GPD MicroPC hardware quirk
        # "acpi_osi=!"
        # "acpi_osi=\"android\""

        # "i915.enable_dpcd_backlight=3" # force intel
        # "i915.enable_guc=2"
        # "i915.modeset=1"
        # "i915.reset=1"
        # "i915.fastboot=0"
      ];

      boot.blacklistedKernelModules = [ "nouveau" ];
      # i915/glk_dmc_ver1_04.bin
      #

      # https://wiki.archlinux.org/title/intel_graphics
      # i915
      # enable_gvt=1 reset=1
      # options i915 enable_guc=-1 enable_dpcd_backlight=1
      boot.extraModprobeConfig = ''
        # alsa-base.conf
        options bt87x index=-2
        options cx88_alsa index=-2
        options saa7134-alsa index=-2
        options snd-atiixp-modem index=-2
        options snd-intel8x0m index=-2
        options snd-via82xx-modem index=-2
        options snd-usb-audio index=-2
        options snd-usb-caiaq index=-2
        options snd-usb-ua101 index=-2
        options snd-usb-us122l index=-2
        options snd-usb-usx2y index=-2
        # Ubuntu #62691, enable MPU for snd-cmipci
        options snd-cmipci mpu_port=0x330 fm_port=0x388
        # Keep snd-pcsp from being loaded as first soundcard
        options snd-pcsp index=-2
        # Keep snd-usb-audio from beeing loaded as first soundcard
        options snd-usb-audio index=-2

        # amd64-microcode-blacklist.conf
        blacklist microcode

        blacklist ath_pci
        blacklist ohci1394
        blacklist sbp2
        blacklist dv1394
        blacklist raw1394
        blacklist video1394

        blacklist aty128fb
        blacklist atyfb
        blacklist radeonfb
        blacklist cirrusfb
        blacklist cyber2000fb
        blacklist cyblafb
        blacklist gx1fb
        blacklist hgafb
        blacklist i810fb
        blacklist intelfb
        blacklist kyrofb
        blacklist lxfb
        blacklist matroxfb_base
        blacklist neofb
        blacklist nvidiafb
        blacklist pm2fb
        blacklist rivafb
        blacklist s1d13xxxfb
        blacklist savagefb
        blacklist sisfb
        blacklist sstfb
        blacklist tdfxfb
        blacklist tridentfb
        blacklist vfb
        blacklist viafb
        blacklist vt8623fb
        blacklist udlfb

        blacklist ac97
        blacklist ac97_codec
        blacklist ac97_plugin_ad1980
        blacklist ad1848
        blacklist ad1889
        blacklist adlib_card
        blacklist aedsp16
        blacklist ali5455
        blacklist btaudio
        blacklist cmpci
        blacklist cs4232
        blacklist cs4281
        blacklist cs461x
        blacklist cs46xx
        blacklist emu10k1
        blacklist es1370
        blacklist es1371
        blacklist esssolo1
        blacklist forte
        blacklist gus
        blacklist i810_audio
        blacklist kahlua
        blacklist mad16
        blacklist maestro
        blacklist maestro3
        blacklist maui
        blacklist mpu401
        blacklist nm256_audio
        blacklist opl3
        blacklist opl3sa
        blacklist opl3sa2
        blacklist pas2
        blacklist pss
        blacklist rme96xx
        blacklist sb
        blacklist sb_lib
        blacklist sgalaxy
        blacklist sonicvibes
        blacklist sound
        blacklist sscape
        blacklist trident
        blacklist trix
        blacklist uart401
        blacklist uart6850
        blacklist via82cxxx_audio
        blacklist v_midi
        blacklist wavefront
        blacklist ymfpci
        blacklist ac97_plugin_wm97xx
        blacklist ad1816
        blacklist audio
        blacklist awe_wave
        blacklist dmasound_core
        blacklist dmasound_pmac
        blacklist harmony
        blacklist sequencer
        blacklist soundcard
        blacklist usb-midi

        # ax25
        alias net-pf-3 off
        # netrom
        alias net-pf-6 off
        # x25
        alias net-pf-9 off
        # rose
        alias net-pf-11 off
        # decnet
        alias net-pf-12 off
        # econet
        alias net-pf-19 off
        # rds
        alias net-pf-21 off
        # af_802154
        alias net-pf-36 off

        # evbug is a debug tool that should be loaded explicitly
        blacklist evbug

        # these drivers are very simple, the HID drivers are usually preferred
        blacklist usbmouse
        blacklist usbkbd

        # replaced by e100
        blacklist eepro100

        # replaced by tulip
        blacklist de4x5

        # causes no end of confusion by creating unexpected network interfaces
        blacklist eth1394

        # snd_intel8x0m can interfere with snd_intel8x0, doesn't seem to support much
        # hardware on its own (Ubuntu bug #2011, #6810)
        blacklist snd_intel8x0m

        # Conflicts with dvb driver (which is better for handling this device)
        blacklist snd_aw2

        # replaced by p54pci
        blacklist prism54

        # replaced by b43 and ssb.
        blacklist bcm43xx

        # most apps now use garmin usb driver directly (Ubuntu: #114565)
        blacklist garmin_gps

        # replaced by asus-laptop (Ubuntu: #184721)
        blacklist asus_acpi

        # low-quality, just noise when being used for sound playback, causes
        # hangs at desktop session start (Ubuntu: #246969)
        blacklist snd_pcsp

        # ugly and loud noise, getting on everyone's nerves; this should be done by a
        # nice pulseaudio bing (Ubuntu: #77010)
        blacklist pcspkr

        # EDAC driver for amd76x clashes with the agp driver preventing the aperture
        # from being initialised (Ubuntu: #297750). Blacklist so that the driver
        # continues to build and is installable for the few cases where its
        # really needed.
        blacklist amd76x_edac
      '';

      # https://bbs.archlinux.org/viewtopic.php?id=261225
      # options snd_hda_codec_hdmi enable_silent_stream=0

      # boot.kernelModules = [ "intel_pmc_mux" ];

      boot.initrd.kernelModules = [ "drm" "intel_agp" "i915" ]; # Always load Intel graphics driver!

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

  folfanga = { lib, pkgs, ... }:
    {
      boot.kernelPackages = pkgs.linuxPackages_6_2;
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

  folfanga-1 = { lib, pkgs, ... }:
    {
      boot.kernelPackages = pkgs.linuxPackages_6_2;
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

  folfanga-2 = { lib, pkgs, ... }:
    {
      boot.kernelPackages = pkgs.linuxPackages_6_2;
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
