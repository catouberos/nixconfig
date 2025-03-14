{pkgs, ...}: {
  stylix = {
    polarity = "dark";

    cursor = {
      package = pkgs.vanilla-dmz;

      name = "Vanilla-DMZ";
      size = 32;
    };

    fonts = {
      monospace = {
        name = "JetBrainsMono Nerd Font";
        package = pkgs.nerd-fonts.jetbrains-mono;
      };

      sansSerif = {
        name = "Inter";
        package = pkgs.inter;
      };

      serif = {
        name = "IBM Plex Serif";
        package = pkgs.ibm-plex;
      };

      sizes = {
        applications = 16;
        desktop = 16;
        popups = 16;
        terminal = 16;
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
      bemenu = {
        fontSize = 16;
      };
      mpv.enable = false;
    };
  };
}
