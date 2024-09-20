{config, ...}: {
  imports = [./prometheus];

  services.grafana = {
    enable = true;
    settings = {
      server = {
        http_addr = "127.0.0.1";
        http_port = 3001;
        domain = "grafana.catou.id.vn";
      };
    };

    provision = {
      enable = true;

      # declarativePlugins = with pkgs.grafanaPlugins; [ ... ];

      datasources.settings.datasources = [
        # "Built-in" datasources can be provisioned - c.f. https://grafana.com/docs/grafana/latest/administration/provisioning/#data-sources
        {
          name = "Prometheus";
          type = "prometheus";
          url = "http://${config.services.prometheus.listenAddress}:${toString config.services.prometheus.port}";
        }
      ];
    };
  };

  services.caddy.virtualHosts = {
    ":3002" = {
      extraConfig = ''
        encode gzip
        reverse_proxy :${toString config.services.grafana.settings.server.http_port}
      '';
    };
    "${config.services.grafana.settings.server.domain}" = {
      extraConfig = ''
        encode gzip
        reverse_proxy :${toString config.services.grafana.settings.server.http_port}
      '';
    };
  };
}
