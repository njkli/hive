{ lib, pkgs, config, ... }:
with lib;
let
  setMac = config.deploy.params.lan.mac != null;
  dhcpClient = config.deploy.params.lan.dhcpClient;
in
mkMerge [
  {
    systemd.services.nscd.serviceConfig.StandardOutput = "null";
    systemd.services.nscd.serviceConfig.StandardError = "null";
  }

  { networking.firewall.allowPing = true; }

  # TODO: Port 5355/udp/tcp - LLMNR - do something about it!
  # TODO: services.fireqos.enable
  {
    ### NOTE: Fuck ipv6!
    # After decades, proper vpns still aren't supported!
    # :lol:
    # sudo sysctl -w net.ipv6.conf.all.autoconf=0
    # sudo sysctl -w net.ipv6.conf.all.accept_ra=0

    boot.kernel.sysctl."net.ipv6.conf.all.disable_ipv6" = "1";
    boot.kernel.sysctl."net.ipv6.conf.default.disable_ipv6" = "1";
    boot.kernel.sysctl."net.ipv6.conf.all.autoconf" = "0";
    boot.kernel.sysctl."net.ipv6.conf.all.accept_ra" = "0";
    boot.kernel.sysctl."net.ipv4.conf.all.force_igmp_version" = "3";
    networking.tempAddresses = "disabled";

    networking.useDHCP = mkDefault false;
    networking.dhcpcd.enable = false;
    networking.useNetworkd = true;
    networking.useHostResolvConf = false;
    networking.usePredictableInterfaceNames = mkDefault true;
    networking.resolvconf.dnsSingleRequest = true;

    # services.resolved.dnssec = "false"; # FIXME: properly handle dnssec

    systemd.network = {
      enable = true;
      wait-online.anyInterface = config.networking.useNetworkd;

      networks.local-eth = {
        macvlan = [ "lan" ];
        matchConfig.Name = mkDefault "mv* eth* en*";
        linkConfig.ARP = false;
        networkConfig.IPv6AcceptRA = "no";
        networkConfig.LinkLocalAddressing = "no";
      };

      netdevs.lan.enable = mkDefault true;
      netdevs.lan.netdevConfig.Kind = "macvlan";
      netdevs.lan.netdevConfig.Name = "lan";
      netdevs.lan.macvlanConfig.Mode = mkDefault "bridge";

      networks.lan.networkConfig.DNSSEC = mkDefault false;
      networks.lan.matchConfig.Name = mkDefault "lan";
      networks.lan.linkConfig.ARP = true;
      networks.lan.linkConfig.RequiredForOnline = mkDefault "yes";
      networks.lan.networkConfig.IPv6AcceptRA = "no";
      networks.lan.networkConfig.LinkLocalAddressing = "no";

      networks.unmanaged.DHCP = "no";
      networks.unmanaged.networkConfig.DHCP = "no";
      networks.unmanaged.linkConfig.Unmanaged = "yes";
      networks.unmanaged.networkConfig.IPv6AcceptRA = "no";
      networks.unmanaged.networkConfig.LinkLocalAddressing = "no";

      networks.unmanaged.matchConfig.Name = mkDefault (concatStringsSep " " [
        # "zt*" NOTE: custom zerotier module is managing networkd for zt
        "macvtap*"
        "cni*"
        "virbr*"
        "docker*"
        "br-*"
        "veth*"
      ]);
    };
  }

  (mkIf setMac {
    systemd.network.networks.lan.linkConfig.MACAddress =
      getAttrFromPath
        [ "lan" "mac" ]
        config.deploy.params;
  })

  (mkIf dhcpClient {
    systemd.network.networks.lan.DHCP = "yes";
    systemd.network.networks.lan.networkConfig.DHCP = "yes";
    systemd.network.networks.lan.dhcpV4Config = {
      ClientIdentifier = mkDefault "mac";
      UseDNS = mkDefault true;
      UseNTP = mkDefault true;
      UseSIP = mkDefault true;
      UseMTU = mkDefault true;
      UseHostname = mkDefault false;
      UseRoutes = mkDefault true;
      # UseGateway = true; # NOTE: not found in nixpkgs implementation
      UseTimezone = mkDefault true;
      Anonymize = mkDefault false;
      SendHostname = mkDefault true;
      # SendDecline = true; # NOTE: too many dhcp packets
      SendRelease = true;
      # SendOption = "252:uint8:1";
      # RequestOptions = "4 5 252"; # Request proxy configuration url
    };
  })

  (mkIf config.services.adguardhome.enable {
    networking.resolvconf.dnsExtensionMechanism = false;

    services.resolved.dnssec = "false";
    services.resolved.llmnr = "false";
    services.resolved.fallbackDns = [ "8.8.8.8" ];
    networking.nameservers = with config.services.adguardhome; [ "${host}:${builtins.toString settings.dns.port}" ];
    services.resolved.extraConfig = ''
      MulticastDNS=false
    '';
  })

  (mkIf config.networking.networkmanager.enable {
    # systemd.network.wait-online.anyInterface = true;
    systemd.network.wait-online.enable = false;
    # systemd.network.wait-online.timeout = 5;
    # systemd.network.wait-online.ignoredInterfaces = (splitString " "
    #   config.systemd.network.networks.local-eth.matchConfig.Name)
    # ++ [ config.systemd.network.netdevs.lan.netdevConfig.Name ];

    ### NOTE: stopping rebuilds depending on the linkDown interface
    systemd.network.networks.lan.linkConfig.RequiredForOnline = "no";

    networking.networkmanager.unmanaged =
      let
        systemd_interfaces =
          map (e: "interface-name:" + e)
            (splitString " " config.systemd.network.networks.local-eth.matchConfig.Name);
      in
      systemd_interfaces ++
      [ "interface-name:${config.systemd.network.netdevs.lan.netdevConfig.Name}" ];
  })

  (mkIf config.networking.firewall.enable {
    networking.firewall.trustedInterfaces = [ config.systemd.network.netdevs.lan.netdevConfig.Name ];
    # NOTE: https://github.com/NixOS/nixpkgs/issues/45944
    networking.firewall.checkReversePath = false;
    networking.firewall.logReversePathDrops = true;
  })

  (mkIf config.networking.wireless.enable {
    services.udev.packages = with pkgs; [ crda ];
    # FIXME: networks.lan.

    systemd.network.networks.wifi-generic = {
      dhcpV4Config.UseDNS = false;
      dhcpV4Config.UseRoutes = true;
      dhcpV4Config.SendHostname = true;
      dhcpV4Config.Anonymize = false;
      matchConfig.Name = mkDefault "wlp*";
      networkConfig.DHCP = "yes";
      networkConfig.IPv6AcceptRA = "no";
      networkConfig.LinkLocalAddressing = "no";

      DHCP = "yes";
      linkConfig.RequiredForOnline = "yes";
    };

    networking.wireless.userControlled.enable = true;
    networking.wireless.environmentFile = "/run/secrets/wifi_eadrax.env";
    # FIXME: re-create groups networking.wireless.userControlled.group = "network";
    networking.wireless.networks = {
      # "EadraxHB".psk = "@PSK_EADRAX@";
      # "EadraxHB".priority = 9;
      # "EadraxHB".authProtocols = [
      #   "WPA-PSK"
      #   # "WPA-EAP"
      #   # "IEEE8021X"
      #   # "NONE"
      #   # "WPA-NONE"
      #   "FT-PSK"
      #   # "FT-EAP"
      #   # "FT-EAP-SHA384"
      #   "WPA-PSK-SHA256"
      #   "WPA-EAP-SHA256"
      #   # "SAE"
      #   # "FT-SAE"
      #   # "WPA-EAP-SUITE-B"
      #   # "WPA-EAP-SUITE-B-192"
      #   # "OSEN"
      #   # "FILS-SHA256"
      #   # "FILS-SHA384"
      #   # "FT-FILS-SHA256"
      #   # "FT-FILS-SHA384"
      #   # "OWE"
      #   # "DPP"
      # ];
    };
  })
]
