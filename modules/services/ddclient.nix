{
  services.ddclient = {
    enable = true;
    domains = ["shinobu.catou.id.vn"];
    protocol = "cloudflare";
    zone = "catou.id.vn";
    passwordFile = "/home/catou/cloudflare.env";
  };
}
