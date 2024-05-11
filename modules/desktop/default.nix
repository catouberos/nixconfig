{
  imports = [
    ./multimedia
    ./sway
    ./fcitx5.nix
    ./fonts.nix
  ];

  programs = {
    firefox.enable = true;
    imv = {
      enable = true;
      catppuccin.enable = true;
    };
  };
}
