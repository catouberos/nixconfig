{pkgs, ...}: {
  imports = [
    ./stylix.nix
    ./fonts.nix
    ./multimedia
    ./sway
    ./fcitx5.nix
    ./thunderbird.nix
  ];

  home.packages = with pkgs; [
    mullvad-browser
    brave
    keepassxc
  ];

  qt = {
    enable = true;
    platformTheme.name = "gtk3";
    style.name = "adwaita-dark";
  };

  programs = {
    firefox = {
      enable = true;
      package = pkgs.firefox-bin;
    };
    chromium = {
      enable = true;
      commandLineArgs = [
        "--ozone-platform-hint=auto"
        "--enable-features=VaapiVideoDecodeLinuxGL"
        "--gtk-version=4"
      ];
    };
  };
}
