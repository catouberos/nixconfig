{pkgs, ...}: {
  home.packages = with pkgs; [
    inter
    corefonts
    noto-fonts
    noto-fonts-cjk
    jetbrains-mono
  ];
}
