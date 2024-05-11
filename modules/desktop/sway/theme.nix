{pkgs, ...}: {
  qt = {
    enable = true;
    platformTheme.name = "gtk3";
    style.name = "adwaita-dark";
  };

  gtk = {
    enable = true;
    cursorTheme = {
      name = "macOS-Monterey";
      package = pkgs.apple-cursor;
      size = 24;
    };
    iconTheme = {
      name = "Papirus Dark";
      package = pkgs.papirus-icon-theme;
    };
    theme = {
      name = "Arc-Dark";
      package = pkgs.arc-theme;
    };
  };

  home.pointerCursor = {
    name = "macOS-Monterey";
    package = pkgs.apple-cursor;
    size = 24;
    x11.enable = true;
  };
}
