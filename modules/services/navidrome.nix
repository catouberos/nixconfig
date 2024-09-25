{config, ...}: {
  services.navidrome = {
    enable = true;
    openFirewall = true;
    settings = {
      MusicFolder = "/mnt/samsung860/Music";
      Address = "0.0.0.0";
      DefaultTheme = "Nord";
      EnableGravatar = true;
      EnableSharing = true;
    };
  };
}
