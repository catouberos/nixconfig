{
  services.qbittorrent = {
    enable = true;
    openFirewall = true;
    group = "torrent";
    torrentingPort = 65432;
  };
}
