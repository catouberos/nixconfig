{pkgs, ...}: {
  imports = [
    ./stylix.nix
    ./fonts.nix
    ./multimedia
    ./sway
    ./fcitx5.nix
  ];

  home.packages = with pkgs; [
    kdePackages.dolphin
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
  };
}
