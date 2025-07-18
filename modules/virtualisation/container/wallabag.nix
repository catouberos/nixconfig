{config, ...}: {
  virtualisation.oci-containers.containers = {
    wallabag = {
      image = "wallabag/wallabag";
      autoStart = true;
      ports = ["8002:80"];
      volumes = [
        "${config.users.users.catou.home}/services/wallabag/data:/var/www/wallabag/data"
        "${config.users.users.catou.home}/services/wallabag/images:/var/www/wallabag/web/assets/images"
      ];
      environment = {
        SYMFONY__ENV__DOMAIN_NAME = "https://wallabag.catou.id.vn";
      };
    };
  };
}
