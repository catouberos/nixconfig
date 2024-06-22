{
  services.caddy = {
    enable = true;
    virtualHosts = {
      "jellyfin.catou.id.vn" = {
        extraConfig = ''
          encode gzip
          reverse_proxy :8096
        '';
      };
      "music.catou.id.vn" = {
        extraConfig = ''
          encode gzip
          reverse_proxy :4533
        '';
      };
    };
  };
}
