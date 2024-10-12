{
  services.flood = {
    enable = true;
    openFirewall = true;
    host = "::";
  };

  systemd.services.flood = {
    serviceConfig = {
      # Grant Flood access to the rtorrent RPC socket
      SupplementaryGroups = ["rtorrent"];
      # Grant Flood RW access to the download directory
      ReadWritePaths = ["/mnt/storage/downloads"];
    };
  };
}
