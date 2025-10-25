{pkgs, ...}: {
  imports = [
    ../../home-manager/cli
    ../../home-manager/nixvim
    ../../home-manager/development/direnv.nix
  ];

  home.username = "catou";
  home.stateVersion = "23.11";

  home.packages = with pkgs; [
    # nixvim
    ripgrep
    fd
    alejandra
    ffmpeg

    colima
    docker
    docker-buildx
    docker-compose
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
