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

  home.packages = with pkgs; [
    anki
    transmission_4-gtk

    discord
    discord-screenaudio

    xdg-utils

    # nixvim
    ripgrep
    fd
  ];

  home.sessionVariables = {
    EDITOR = "nvim";
  };

  services = {
    udiskie.enable = true;
  };

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
}
