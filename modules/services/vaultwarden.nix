{config, ...}: {
  sops.secrets = {
    "vaultwarden" = {
      format = "binary";
      sopsFile = ../../secrets/vaultwarden;
    };
  };

  services.vaultwarden = {
    enable = true;
    backupDir = "/var/local/vaultwarden/backup";
    environmentFile = config.sops.secrets."vaultwarden".path;
    config = {
      # Refer to https://github.com/dani-garcia/vaultwarden/blob/main/.env.template
      DOMAIN = "https://bitwarden.example.com";
      SIGNUPS_ALLOWED = false;
    };
  };
}
