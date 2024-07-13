{config, ...}: {
  virtualisation.oci-containers.containers = {
    filebrowser = {
      image = "filebrowser/filebrowser";
      autoStart = true;
      ports = ["8080:80"];
      volumes = [
        "/mnt/wdpurple:/srv:ro"
        "${config.users.users.catou.home}/filebrowser/database.db:/database.db"
      ];
    };
  };
}
