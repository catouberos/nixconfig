{pkgs, ...}: {
  imports = [
    ../../home-manager/desktop
    ../../home-manager/cli
    ../../home-manager/nixvim.nix
    ../../home-manager/1password.nix
  ];

  home.username = "catou";
  home.homeDirectory = "/home/catou";
  home.stateVersion = "23.11";

  home.packages = [
    pkgs.anki-bin

    pkgs.discord
    pkgs.discord-screenaudio
    pkgs.ciscoPacketTracer8

    pkgs.xdg-utils

    (pkgs.nerdfonts.override {fonts = ["JetBrainsMono"];})

    # nixvim
    pkgs.ripgrep
    pkgs.fd
  ];

  home.sessionVariables = {
    EDITOR = "nvim";
    GTK_IM_MODULE = "fcitx";
  };

  services = {
    udiskie.enable = true;
  };

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
}
