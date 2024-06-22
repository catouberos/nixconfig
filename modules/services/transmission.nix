{pkgs, ...}: {
  services.transmission = {
    enable = true;
    webHome = pkgs.flood-for-transmission;
    openRPCPort = true;
    openPeerPorts = true;
    settings = {
      # files
      download-dir = "/mnt/wdpurple/Torrents";
      preallocation = 2;
      # misc
      cache-size-mb = 1024;
      # queuing
      queue-stalled-enabled = false;
      # rpc
      rpc-bind-address = "0.0.0.0";
      rpc-whitelist = "127.0.0.1, 192.168.*.*";
    };
  };
}
