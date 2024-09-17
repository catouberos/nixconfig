{
  config,
  pkgs,
  ...
}: {
  imports = [./prometheus.nix];

  services.grafana = {
    enable = true;
    settings = {
      server = {
        http_addr = "127.0.0.1";
        http_port = 3000;
        domain = "grafana.catou.id.vn";
      };
    };

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
}
