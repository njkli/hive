{ inputs, cell, ... }:
{
  # The sauce
  # bootstrap = import ./nixosConfigurations/bootstrap { inherit inputs cell; };

  # maintenance = import ./nixosConfigurations/maintenance { inherit inputs cell; };

  # in-hand machine
  asbleg = import ./nixosConfigurations/asbleg { inherit inputs cell; };

  # remote-displays
  folfanga = import ./nixosConfigurations/folfanga { inherit inputs cell; };
  folfanga-1 = import ./nixosConfigurations/folfanga-1 { inherit inputs cell; };
  folfanga-2 = import ./nixosConfigurations/folfanga-2 { inherit inputs cell; };

  # libvirtd machines
  libvirtd = import ./nixosConfigurations/libvirtd { inherit inputs cell; };

}
