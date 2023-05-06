input:
let
  inherit (builtins) fetchTarball fromJSON readFile;
  inherit ((fromJSON (readFile ../../../../flake.lock)).nodes."${input}".locked) rev narHash owner repo;
in
fetchTarball {
  url = "https://github.com/${owner}/${repo}/archive/${rev}.tar.gz";
  sha256 = narHash;
}
