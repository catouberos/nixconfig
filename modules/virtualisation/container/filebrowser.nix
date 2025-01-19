{config, ...}: {
  virtualisation.oci-containers.containers = {
    filebrowser = {
      image = "filebrowser/filebrowser";
      autoStart = true;
      ports = ["8080:80"];
      volumes = [
        "/mnt/samsung860:/srv/samsung860:ro"
        "/mnt/wdpurple:/srv/wdpurple:ro"
        "${config.users.users.catou.home}/filebrowser/database.db:/database.db"
      ];
    };
  };
}
