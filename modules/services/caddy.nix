{
  services.caddy = {
    enable = true;
    virtualHosts = {
      # flood
      "shinobu.catou.id.vn" = {
        extraConfig = ''
          encode gzip
          reverse_proxy :3000
        '';
      };
      # jellyfin
      "jellyfin.catou.id.vn" = {
        extraConfig = ''
          encode gzip
          reverse_proxy :8096
        '';
      };
      # navidrome
      "music.catou.id.vn" = {
        extraConfig = ''
          encode gzip
          reverse_proxy :4533
        '';
      };
      # chibisafe
      "a.catou.id.vn" = {
        extraConfig = ''
          encode gzip
          reverse_proxy :24424
        '';
      };
      ":24424" = {
        extraConfig = ''
          route {
              file_server * {
                  root /app/uploads
                  pass_thru
              }

              @api path /api/*
              reverse_proxy @api :8002 {
                  header_up Host {http.reverse_proxy.upstream.hostport}
                  header_up X-Real-IP {http.request.header.X-Real-IP}
              }

              @docs path /docs*
              reverse_proxy @docs :8002 {
                  header_up Host {http.reverse_proxy.upstream.hostport}
                  header_up X-Real-IP {http.request.header.X-Real-IP}
              }

              reverse_proxy :8001 {
                  header_up Host {http.reverse_proxy.upstream.hostport}
                  header_up X-Real-IP {http.request.header.X-Real-IP}
              }
          }
        '';
      };
    };
  };
}
