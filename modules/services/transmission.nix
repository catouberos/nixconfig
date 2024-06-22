{pkgs, ...}: {
  services.transmission = {
    enable = true;
    webHome = pkgs.flood-for-transmission;
    settings = {
      # bandwidth
      speed-limit-up = "10000";
      speed-limit-up-enabled = true;
      # files
      download-dir = "/mnt/wdpurple/Torrents";
      preallocation = 2;
      # misc
      cache-size-mb = 1024;
      # queuing
      queue-stalled-enabled = false;
    };
  };
}
