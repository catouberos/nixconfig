{
  imports = [
    ./multimedia
    ./sway
    ./fcitx5.nix
    ./fonts.nix
  ];

  programs = {
    firefox.enable = true;
    chromium = {
      enable = true;
      commandLineArgs = [
        "--ozone-platform-hint=auto"
        "--enable-features=VaapiVideoDecodeLinuxGL"
        "--gtk-version=4"
      ];
    };
    imv = {
      enable = true;
      catppuccin.enable = true;
    };
  };
}
