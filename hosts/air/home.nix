{pkgs, ...}: {
  imports = [
    ../../home-manager/cli
    ../../home-manager/nixvim.nix
  ];

  home.username = "catou";
  home.homeDirectory = "/home/catou";
  home.stateVersion = "23.11";

  home.packages = [
    (pkgs.nerdfonts.override {fonts = ["JetBrainsMono"];})
  ];

  home.sessionVariables = {
    EDITOR = "nvim";
  };

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
}
