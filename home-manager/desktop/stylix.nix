{pkgs, ...}: {
  stylix = {
    polarity = "dark";

    cursor = {
      package = pkgs.apple-cursor;
      name = "macOS";
      size = 32;
    };

    iconTheme = {
      enable = true;
      package = pkgs.adwaita-icon-theme;
      light = "Adwaita";
      dark = "Adwaita";
    };

    fonts = {
      monospace = {
        name = "UDEV Gothic NF";
        package = pkgs.udev-gothic-nf;
      };

      sansSerif = {
        name = "IBM Plex Sans JP";
        package = pkgs.ibm-plex;
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
      };
      bemenu = {
        fontSize = 16;
      };
      mpv.enable = false;
      firefox.profileNames = ["default"];
      librewolf.profileNames = ["default"];
    };
  };
}
