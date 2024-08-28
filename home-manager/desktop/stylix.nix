{pkgs, ...}: {
  stylix = {
    polarity = "dark";

    cursor = {
      package = pkgs.apple-cursor;

      name = "macOS-Monterey";
      size = 24;
    };

    fonts = {
      monospace = {
        name = "JetBrainsMono Nerd Font";
        package = pkgs.nerdfonts.override {fonts = ["JetBrainsMono"];};
      };

      sansSerif = {
        name = "Inter";
        package = pkgs.inter;
      };

      serif = {
        name = "IBM Plex Serif";
        package = pkgs.ibm-plex;
      };
    };

    targets = {
      fish.enable = false;
      wezterm.enable = false;
      waybar = {
        enable = true;
        enableCenterBackColors = true;
        enableLeftBackColors = true;
        enableRightBackColors = true;
      };
    };
  };
}
