{config, ...}: {
  sops.secrets = {
    "cloudflare-tunnel" = {
      format = "binary";
      sopsFile = ../../secrets/cloudflare-tunnel;
    };
  };

  services.cloudflared = {
    enable = true;
    tunnels = {
      "7c362f95-5271-4eee-9ac5-d46251716019" = {
        credentialsFile = config.sops.secrets."cloudflare-tunnel".path;
        ingress = {
          "music.catou.id.vn" = "http://localhost:4533";
          "media.catou.id.vn" = "http://localhost:8096";
          "wallabag.catou.id.vn" = "http://localhost:8002";
        };
        default = "http_status:404";
      };
    };
  };
}
