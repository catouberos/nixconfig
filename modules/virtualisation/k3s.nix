{pkgs, ...}: {
  services.k3s = {
    enable = true;
    role = "server";
    clusterInit = true;
  };

  environment.systemPackages = [
    pkgs.fluxcd
    pkgs.kubernetes-helm
  ];
}
