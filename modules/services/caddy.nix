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
    };
  };
}
