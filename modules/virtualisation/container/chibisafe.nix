{config, ...}: {
  virtualisation.oci-containers.containers = {
    chibisafe = {
      image = "chibisafe/chibisafe:latest";
      autoStart = true;
      ports = ["8001:8001"];
      environment = {
        BASE_API_URL = "http://127.0.0.1:8000";
      };
    };
    chibisafe_server = {
      hostname = "chibisafe_server";
      image = "chibisafe/chibisafe-server:latest";
      autoStart = true;
      ports = ["8000:8000"];
      volumes = [
        "${config.users.users.catou.home}/chibisafe/database:/app/database:rw"
        "${config.users.users.catou.home}/chibisafe/uploads:/app/uploads:rw"
        "${config.users.users.catou.home}/chibisafe/logs:/app/logs:rw"
      ];
    };
  };
}
