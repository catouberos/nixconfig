{pkgs, ...}: {
  fonts.fontconfig.enable = true;
  home.packages = with pkgs; [
    inter
    corefonts
    noto-fonts
    noto-fonts-cjk-sans
    noto-fonts-cjk-serif
    jetbrains-mono
  ];
}
