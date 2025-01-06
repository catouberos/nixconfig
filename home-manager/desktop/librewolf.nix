{
  programs = {
    librewolf = {
      enable = true;
      settings = {
        "privacy.clearOnShutdown.history" = false;
        "privacy.clearOnShutdown.downloads" = false;
        "privacy.clearOnShutdown.cookies" = false;
        "privacy.clearOnShutdown_v2.cookiesAndStorage" = false;
        "middlemouse.paste" = false;
        "general.autoScroll" = true;
      };
    };
  };
}
