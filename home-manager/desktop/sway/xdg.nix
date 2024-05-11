{
  config,
  pkgs,
  ...
}: let
  browser = ["firefox.desktop"];
  associations = {
    "text/html" = browser;
    "x-scheme-handler/http" = browser;
    "x-scheme-handler/https" = browser;
    "x-scheme-handler/ftp" = browser;
    "x-scheme-handler/chrome" = browser;
    "x-scheme-handler/about" = browser;
    "x-scheme-handler/unknown" = browser;
    "application/x-extension-htm" = browser;
    "application/x-extension-html" = browser;
    "application/x-extension-shtml" = browser;
    "application/xhtml+xml" = browser;
    "application/x-extension-xhtml" = browser;
    "application/x-extension-xht" = browser;

    #"text/*" = [ "neovim.desktop" ];
    "audio/*" = ["mpv.desktop"];
    "video/*" = ["mpv.dekstop"];
    "image/*" = ["imv-dir.desktop"];
    "text/calendar" = ["thunderbird.desktop"]; # ".ics"  iCalendar format
    "application/json" = browser; # ".json"  JSON format
    "application/pdf" = browser; # ".pdf"  Adobe Portable Document Format (PDF)
  };
in {
  xdg = {
    enable = true;
    portal = {
      enable = true;
      extraPortals = with pkgs; [xdg-desktop-portal-wlr xdg-desktop-portal-gtk];
      # https://github.com/emersion/xdg-desktop-portal-wlr?tab=readme-ov-file#running
      config = {sway.default = ["wlr" "gtk"];};
    };
    userDirs = {
      enable = true;
      createDirectories = true;
      extraConfig = {
        XDG_CODE_DIR = "${config.home.homeDirectory}/Codes";
      };
    };
    mimeApps = {
      enable = true;
      associations.added = associations;
      defaultApplications = associations;
    };
  };
}
