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
      # performance
      peer-limit-global = 2000;
      performanceNetParameters = true;
      # queuing
      download-queue-enabled = false;
      queue-stalled-enabled = false;
      # speed
      alt-speed-up = 2000;
      alt-speed-down = 10000;
      alt-speed-enabled = true;
      # 1 hour from midnight (1AM)
      alt-speed-time-begin = 60;
      # 8 hour from midnight (8AM)
      alt-speed-time-end = 480;
      # all days
      alt-speed-time-day = 127;
      alt-speed-time-enabled = true;
      # rpc
      rpc-bind-address = "0.0.0.0";
      rpc-whitelist = "127.0.0.1, 192.168.*.*";
    };
  };
}
