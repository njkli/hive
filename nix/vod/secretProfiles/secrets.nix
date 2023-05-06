let
  keys = import ../secretProfiles.nix;
  common = [ keys.vod.openssh-pub.desktop ];
in
{
  "root-user.age".publicKeys = [ ] ++ common;
}
