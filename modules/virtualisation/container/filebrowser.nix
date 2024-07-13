{config, ...}: {
  virtualisation.oci-containers.containers = {
    flood = {
      image = "filebrowser/filebrowser";
      autoStart = true;
      ports = ["8080:80"];
      user = "${config.users.users.catou.uid}:${config.users.users.catou.group}";
      volumes = [
        "/mnt/wdpurple:/srv:ro"
        "/mnt/wdpurple/database.db:/database.db"
        "/mnt/wdpurple/.filebrowser.json:/.filebrowser.json"
      ];
    };
  };
}
