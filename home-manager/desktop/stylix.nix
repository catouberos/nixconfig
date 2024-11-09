{pkgs, ...}: {
  stylix = {
    polarity = "dark";

    cursor = {
      package = pkgs.vanilla-dmz;

      name = "Vanilla-DMZ";
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
      nixvim.enable = false;
      btop.enable = false;
      waybar = {
        enable = true;
        enableCenterBackColors = true;
        enableLeftBackColors = true;
        enableRightBackColors = true;
      };
    };
  };
}
