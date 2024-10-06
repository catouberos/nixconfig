{
  virtualisation.oci-containers.containers = {
    shokoserver = {
      image = "shokoanime/server:latest";
      autoStart = true;
      ports = ["8111:8111"];
      cmd = [
        "--shm-size 256m"
      ];
      volumes = [
        "/mnt/wdpurple:/mnt/wdpurple:ro"
      ];
    };
  };
}
