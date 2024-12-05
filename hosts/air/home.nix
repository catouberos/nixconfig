{pkgs, ...}: {
  imports = [
    ../../home-manager/cli
    ../../home-manager/nixvim
    ../../home-manager/1password.nix
    ../../home-manager/desktop/multimedia/mpv.nix
    ../../home-manager/development/direnv.nix
  ];

  home.username = "catou";
  home.stateVersion = "23.11";

  home.packages = with pkgs; [
    (nerdfonts.override {fonts = ["JetBrainsMono"];})
    jetbrains-mono

    # nixvim
    ripgrep
    fd
    alejandra
    ffmpeg
    xld

    # container
    colima
    docker
  ];

  home.sessionVariables = {
    EDITOR = "nvim";
  };

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
}
