{ config, lib, pkgs, ... }:

{
  home.packages = with pkgs; [
    openshift
    telepresence
    lens
    kubectl
    kubernetes-helm
    k9s
  ] ++ (with kubernetes-helmPlugins; [
    helm-diff
    helm-git
    helm-s3
    helm-secrets
  ]);
}
