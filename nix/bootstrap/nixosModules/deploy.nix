{ config, lib, ... }:

let
  inherit (lib) mkOption mkEnableOption types;
  cfgDeploy = config.deploy;
  lanOptions = {
    options = with types; {
      mac = mkOption { type = nullOr str; default = null; };
      ipv4 = mkOption { type = nullOr str; default = null; };
      ipxe = mkEnableOption "use ipxe";
      dhcpClient = mkEnableOption "use dhcp" // { default = true; };
      server = mkOption { type = attrs; };
    };
  };

in
{
  options.deploy = with types; {
    enable = mkEnableOption "Enable deploy config"; # // { default = true; };
    params = {
      hidpi.enable = mkEnableOption "hiDpi";
      lan = mkOption { type = submodule [ lanOptions ]; default = { }; };
    };
  };
  # config = mkMerge [ (mkIf cfgDeploy.enable { }) ];
}
