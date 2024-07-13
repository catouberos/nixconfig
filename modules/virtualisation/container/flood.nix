{config, ...}: {
  virtualisation.oci-containers.containers = {
    flood = {
      image = "jesec/flood";
      autoStart = true;
      extraOptions = ["--network=host"];
      cmd = [
        "--rundir=/config"
        "--trurl=http://localhost:9091/transmission/rpc"
      ];
      volumes = [
        "${config.users.users.catou.home}/.config/flood:/config"
        "/mnt/wdpurple:/mnt/wdpurple:ro"
      ];
    };
  };
}
