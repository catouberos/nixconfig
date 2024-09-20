{
  services.caddy = {
    enable = true;
    globalConfig = ''
      servers {
        metrics
      }
    '';
  };
}
