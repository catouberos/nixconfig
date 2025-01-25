{config, ...}: {
  virtualisation.oci-containers.containers = {
    lms = {
      image = "epoupon/lms";
      autoStart = true;
      ports = ["5082:5082"];
      volumes = [
        "/mnt/samsung860/Music:/music:ro"
        "${config.users.users.catou.home}/.lms:/var/lms:rw"
      ];
    };
  };
}
