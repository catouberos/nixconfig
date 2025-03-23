{config, ...}: {
  services.cloudflared = {
    enable = true;
    tunnels = {
      "7c362f95-5271-4eee-9ac5-d46251716019" = {
        credentialsFile = "${config.sops.secrets."shinobu.json".path}";
        ingress = {
          "music.catou.id.vn" = "http://localhost:4533";
          "media.catou.id.vn" = "http://localhost:8096";
        };
        default = "http_status:404";
      };
    };
  };
}
