{
  pkgs,
  config,
  ...
}: {
  services.transmission = {
    enable = true;
    package = pkgs.transmission;
    webHome = pkgs.flood-for-transmission;
    openRPCPort = true;
    openPeerPorts = true;
    settings = {
      # files
      download-dir = "/mnt/wdpurple/Torrents";
      incomplete-dir = "${config.services.transmission.settings.download-dir}/.incomplete";
      preallocation = 2;
      # misc
      cache-size-mb = 1024;
      # performance
      peer-limit-global = 2000;
      performanceNetParameters = true;
      # queuing
      download-queue-enabled = false;
      queue-stalled-enabled = false;
      # rpc
      rpc-bind-address = "0.0.0.0";
      rpc-whitelist = "127.0.0.1, 192.168.*.*";
    };
  };
}
