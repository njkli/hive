{ inputs, cell, ... }:
{
  # desktop = {
  #   deployment.allowLocalDeployment = true;
  #   deployment.targetHost = "127.0.0.1";
  #   inherit (cell.nixosConfigurations.desktop) bee imports;
  # };
  oglaroon = {
    # deployment.targetHost = "192.168.192.125";
    deployment.allowLocalDeployment = true;
    deployment.targetHost = "127.0.0.1";
    deployment.targetUser = "admin";
    deployment.tags = [ "laptop" "everything" ];
    inherit (cell.nixosConfigurations.oglaroon) bee imports;
  };

  asbleg = {
    # deployment.targetHost = "10.11.1.122";
    deployment.targetHost = "192.168.192.221";
    deployment.targetUser = "admin";
    deployment.tags = [ "desktop" "everything" ];
    inherit (cell.nixosConfigurations.asbleg) bee imports;
  };

  folfanga = {
    # deployment.targetHost = "10.11.1.40";
    deployment.targetHost = "192.168.192.110";
    deployment.targetUser = "admin";
    deployment.tags = [ "remote-display" "everything" ];
    inherit (cell.nixosConfigurations.folfanga) bee imports;
  };

  folfanga-1 = {
    # deployment.targetHost = "10.11.1.41";
    deployment.targetHost = "192.168.192.111";
    deployment.targetUser = "admin";
    deployment.tags = [ "remote-display" "everything" ];
    inherit (cell.nixosConfigurations.folfanga-1) bee imports;
  };

  folfanga-2 = {
    # deployment.targetHost = "10.11.1.42";
    deployment.targetHost = "192.168.192.112";
    deployment.targetUser = "admin";
    deployment.tags = [ "remote-display" "everything" ];
    inherit (cell.nixosConfigurations.folfanga-2) bee imports;
  };

}
