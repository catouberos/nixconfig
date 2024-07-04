{pkgs, ...}: {
  home.packages = with pkgs; [
    gnutar
    unzip
    unrar
    p7zip
  ];
}
