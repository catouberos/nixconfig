{
  chibisafe = {
    image = "chibisafe/chibisafe:latest";
    autoStart = true;
    ports = ["8001:8001"];
    environment = {
      BASE_API_URL = "http://chibisafe_server:8000";
    };
  };
  chibisafe_server = {
    hostname = "chibisafe_server";
    image = "chibisafe/chibisafe-server:latest";
    autoStart = true;
    ports = ["8000:8000"];
    volumes = [
      "/home/catou/chibisafe/database:/app/database:rw"
      "/home/catou/chibisafe/uploads:/app/uploads:rw"
      "/home/catou/chibisafe/logs:/app/logs:rw"
    ];
  };
}
