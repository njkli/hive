{
  boot.kernelParams =
    [
      "zswap.enabled=1"
      "zswap.zpool=z3fold"
      "zswap.compressor=zstd"
      "zswap.max_pool_percent=25"
    ];
  boot.initrd.availableKernelModules =
    [
      "zstd"
      "zstd_compress"
      "lz4"
      "lz4_compress"
      "z3fold"
    ];
  boot.postBootCommands = ''
    echo z3fold > /sys/module/zswap/parameters/zpool
    echo zstd > /sys/module/zswap/parameters/compressor
  '';
}
