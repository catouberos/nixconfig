{
  services.flood = {
    enable = true;
    openFirewall = true;
    host = "::";
  };

  systemd.services.flood = {
    serviceConfig = {
      SupplementaryGroups = ["rtorrent"];
    };
  };
}
