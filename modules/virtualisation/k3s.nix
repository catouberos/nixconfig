{pkgs, ...}: {
  services.k3s.enable = true;
  environment.systemPackages = [pkgs.kubernetes-helm];
}
