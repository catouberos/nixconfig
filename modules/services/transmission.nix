{
  pkgs,
  config,
  ...
}: {
  services.transmission = {
    enable = true;
    package = pkgs.transmission_4;
    webHome = pkgs.flood-for-transmission;
    openRPCPort = true;
    openPeerPorts = true;
    performanceNetParameters = true;
    settings = {
      # files
      incomplete-dir = "${config.services.transmission.settings.download-dir}/.incomplete";
      preallocation = 2;
      # misc
      cache-size-mb = 1024;
      # performance
      peer-limit-global = 500;
      # queuing
      download-queue-enabled = false;
      queue-stalled-enabled = false;
      # rpc
      rpc-bind-address = "0.0.0.0";
      rpc-whitelist = "127.0.0.1, 192.168.*.*";
    };
  };
}
