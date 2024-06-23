{
  services.ddclient = {
    enable = true;
    domains = ["shinobu.catou.id.vn"];
    protocol = "cloudflare";
    zone = "catou.id.vn";
    passwordFile = "/home/catou/cloudflare.env";
    username = "khoanguyen.do@outlook.com";
    usev4 = "webv4, webv4=cloudflare.com/cdn-cgi/trace/, webv4-skip='ip='";
  };
}
