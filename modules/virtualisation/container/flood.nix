{config, ...}: {
  virtualisation.oci-containers.containers = {
    flood = {
      image = "jesec/flood";
      autoStart = true;
      extraOptions = ["--network=host"];
      cmd = [
        "--rundir=/config"
      ];
      volumes = [
        "${config.users.users.catou.home}/.config/flood:/config"
        "/mnt/wdpurple:/mnt/wdpurple:ro"
        "/mnt/samsung860:/mnt/samsung860:ro"
      ];
    };
  };
}
