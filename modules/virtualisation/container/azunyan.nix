{
  virtualisation.oci-containers.containers = {
    rui = {
      image = "ghcr.io/tanamoe/azunyan:latest";
      autoStart = true;
      extraOptions = ["--network=host"];
      volumes = ["/home/catou/rui.env:/app/.env"];
    };
    rurino = {
      image = "ghcr.io/tanamoe/azunyan:latest";
      autoStart = true;
      extraOptions = ["--network=host"];
      volumes = ["/home/catou/rurino.env:/app/.env"];
    };
  };
}
