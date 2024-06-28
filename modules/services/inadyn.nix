{config, ...}: {
  services.inadyn = {
    enable = true;
    settings.provider."cloudflare.com" = {
      username = "catou.id.vn";
      hostname = "shinobu.catou.id.vn";
      include = config.sops.secrets.cloudflare_tokens.path;
    };
  };
}
