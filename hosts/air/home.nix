{pkgs, ...}: {
  imports = [
    ../../home-manager/cli
    ../../home-manager/nixvim.nix
    ../../home-manager/1password.nix
  ];

  home.username = "catou";
  home.stateVersion = "23.11";

  home.packages = with pkgs; [
    (nerdfonts.override {fonts = ["JetBrainsMono"];})

    # nixvim
    ripgrep
    fd
    alejandra
  ];

  home.sessionVariables = {
    EDITOR = "nvim";
  };

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
}
