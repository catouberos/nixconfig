{pkgs, ...}: {
  imports = [
    ./stylix.nix
    ./fonts.nix
    ./multimedia
    ./sway
    ./fcitx5.nix
  ];

  home.packages = with pkgs; [
    mullvad-browser
  ];

  qt = {
    enable = true;
    platformTheme = "gtk3";
    style.name = "adwaita-dark";
  };

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
  };
}
