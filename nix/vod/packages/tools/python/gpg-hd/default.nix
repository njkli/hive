{ monkeysphere, python3Packages, gnupg, gnused, sources }:

python3Packages.buildPythonPackage {
  inherit (sources.gpg-hd) pname version src;
  format = "other";
  doCheck = false;
  propagatedBuildInputs = with python3Packages; [
    pexpect
    pycrypto
    gnupg
    monkeysphere
  ];

  buildPhase = ''
    echo DUMMY-BUILD-PHASE
  '';

  installPhase = ''
    mkdir -p $out/bin
    cat $src/gpg-hd | sed 's|/usr/bin/env python3|${python3Packages.python}/bin/python|g' > $out/bin/gpg-hd
    ln -s $src/hmac_drbg.py $out/bin/hmac_drbg.py
    chmod 0755 $out/bin/gpg-hd
  '';
}
