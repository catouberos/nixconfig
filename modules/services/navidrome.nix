{config, ...}: {
  services.navidrome = {
    enable = true;
    openFirewall = true;
    settings = {
      Address = "::";
      DefaultTheme = "Nord";
      EnableGravatar = true;
      EnableSharing = true;
    };
  };
}
