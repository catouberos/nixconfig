{pkgs, ...}: {
  home.packages = with pkgs; [
    ibm-plex
    inter
    jetbrains-mono
    corefonts
    noto-fonts
    noto-fonts-cjk
    noto-fonts-emoji
    (nerdfonts.override {fonts = ["JetBrainsMono"];})
  ];

  fonts.fontconfig = {
    enable = true;
    defaultFonts = {
      serif = ["IBM Plex Serif" "IBM Plex Sans JP"];
      sansSerif = ["IBM Plex Sans" "IBM Plex Sans JP"];
      monospace = ["JetBrains Mono" "IBM Plex Mono"];
      emoji = [];
    };
  };
}
