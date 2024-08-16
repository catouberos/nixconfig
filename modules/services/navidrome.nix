{config, ...}: {
  services.navidrome = {
    enable = true;
    openFirewall = true;
    settings = {
      MusicFolder = "${config.users.users.catou.home}/Music";
      Address = "0.0.0.0";
    };
  };
}
