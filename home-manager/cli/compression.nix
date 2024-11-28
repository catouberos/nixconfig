{pkgs, ...}: {
  home.packages = with pkgs; [
    gnutar
    zip
    unzip
    unrar
    p7zip
  ];
}
