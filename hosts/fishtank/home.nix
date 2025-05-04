{pkgs, ...}: {
  imports = [
    ../../home-manager/desktop
    ../../home-manager/cli
    ../../home-manager/cli/terminal
    ../../home-manager/cli/utility
    ../../home-manager/nixvim
    ../../home-manager/development
    ../../home-manager/1password.nix
  ];

  home.username = "catou";
  home.homeDirectory = "/home/catou";
  home.stateVersion = "23.11";

  home.packages = with pkgs; [
    anki

    discord-canary
    vesktop

    xdg-utils
    nethogs

    obs-studio

    # music
    shntool
    flac
    beets

    # misc
    gimp3
    pinta

    zotero
    libreoffice

    jmtpfs
    qgis
  ];

  home.sessionVariables = {
    EDITOR = "nvim";
  };

  nixpkgs = {
    config.allowUnfree = true;
  };

  services = {
    udiskie.enable = true;
  };

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
}
