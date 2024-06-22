{
  services.cloudflare-dyndns = {
    enable = true;
    domains = ["shinobu.catou.id.vn"];
    apiTokenFile = "/home/catou/cloudflare.env";
    ipv4 = true;
    ipv6 = true;
  };
}
