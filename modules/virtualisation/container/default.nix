{
  virtualisation.oci-containers = {
    backend = "podman";
    containers = {
      rui = {
        image = "ghcr.io/tanamoe/azunyan:latest";
        autoStart = true;
        extraOptions = ["--network=host"];
        environmentFiles = /home/catou/rui.env;
      };
      rurino = {
        image = "ghcr.io/tanamoe/azunyan:latest";
        autoStart = true;
        extraOptions = ["--network=host"];
        environmentFiles = /home/catou/rurino.env;
      };
    };
  };
}
