{pkgs, ...}: {
  imports = [
    ./stylix.nix
    ./fonts.nix
    ./multimedia
    ./sway
    ./fcitx5.nix
    ./thunderbird.nix
    ./firefox.nix
    ./chromium.nix
    ./librewolf.nix
  ];

  home.packages = with pkgs; [
    ffsubsync
  ];
}
