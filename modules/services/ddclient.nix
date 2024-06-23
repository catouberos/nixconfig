{
  services.ddclient = {
    enable = true;
    domains = ["shinobu.catou.id.vn"];
    protocol = "cloudflare";
    zone = "catou.id.vn";
    passwordFile = "/home/catou/cloudflare.env";
    username = "khoanguyen.do@outlook.com";
    use = "web, web='https://cloudflare.com/cdn-cgi/trace', web-skip='ip='";
  };
}
