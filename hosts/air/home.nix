{pkgs, ...}: {
  imports = [
    ../../home-manager/cli
    ../../home-manager/cli/terminal/wezterm.nix
    ../../home-manager/nixvim
    ../../home-manager/1password.nix
    ../../home-manager/desktop/multimedia/mpv.nix
    ../../home-manager/desktop/firefox.nix
    ../../home-manager/development/direnv.nix
  ];

  home.username = "catou";
  home.stateVersion = "23.11";

  home.packages = with pkgs; [
    nerd-fonts.jetbrains-mono
    jetbrains-mono

    # nixvim
    ripgrep
    fd
    alejandra
    ffmpeg
    xld

    container

    zotero
  ];

  home.sessionVariables = {
    EDITOR = "nvim";
  };

  nixpkgs = {
    config.allowUnfree = true;
  };

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
}
