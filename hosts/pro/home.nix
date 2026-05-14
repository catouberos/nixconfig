{
  pkgs,
  outputs,
  ...
}: {
  imports = [
    ../../home-manager/cli
    ../../home-manager/cli/terminal/wezterm.nix
    ../../home-manager/nixvim
    ../../home-manager/bitwarden.nix
    ../../home-manager/desktop/multimedia/mpv.nix
    ../../home-manager/desktop/firefox.nix
    ../../home-manager/desktop/fonts.nix
    ../../home-manager/development/direnv.nix
    ../../home-manager/desktop/aerospace
  ];

  home.username = "catou";
  home.stateVersion = "23.11";

  home.packages = with pkgs; [
    # nixvim
    ripgrep
    fd
    alejandra
    ffmpeg-full
    xld

    colima
    docker
    docker-buildx
    docker-compose

    gemini-cli
    wireshark

    anki
    supersonic

    mangadex-downloader
  ];

  home.sessionVariables = {
    EDITOR = "nvim";
  };

  nixpkgs = {
    config.allowUnfree = true;
    overlays = [
      outputs.overlays.modifications
    ];
  };

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
}
