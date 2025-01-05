{pkgs, ...}: {
  programs.ghostty = {
    enable = true;
    enableFishIntegration = true;
    settings = {
      theme = "catppuccin-macchiato";
      font-size = 14;
      background-opacity = 0.5;
      command = "${pkgs.fish}/bin/fish --login";
    };
  };
}
