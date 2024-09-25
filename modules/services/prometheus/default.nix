{config, ...}: {
  # https://nixos.org/manual/nixos/stable/#module-services-prometheus-exporters
  services.prometheus = {
    enable = true;
    port = 9000;

    exporters = {
      node = {
        enable = true;
        port = 9001;
        # https://github.com/NixOS/nixpkgs/blob/nixos-24.05/nixos/modules/services/monitoring/prometheus/exporters.nix
        enabledCollectors = ["systemd"];
        # /nix/store/zgsw0yx18v10xa58psanfabmg95nl2bb-node_exporter-1.8.1/bin/node_exporter  --help
        extraFlags = ["--collector.ethtool" "--collector.softirqs" "--collector.tcpstat" "--collector.wifi"];
      };

      blackbox = {
        enable = true;
        port = 9115;
        configFile = ./blackbox.yaml;
      };
    };

    scrapeConfigs = [
      {
        job_name = "node";
        static_configs = [
          {
            targets = ["localhost:${toString config.services.prometheus.exporters.node.port}"];
          }
        ];
      }
      {
        job_name = "blackbox";
        metrics_path = "/probe";
        params = {
          module = ["http_2xx"];
        };
        static_configs = [
          {targets = ["https://tana.moe"];}
        ];
        relabel_configs = [
          {
            source_labels = ["__address__"];
            target_label = "__param_target";
          }
          {
            source_labels = ["__param_target"];
            target_label = "instance";
          }
          {
            target_label = "__address__";
            replacement = "localhost:${toString config.services.prometheus.exporters.blackbox.port}";
          }
        ];
      }
      {
        job_name = "blackbox_exporter";
        static_configs = [
          {targets = ["localhost:${toString config.services.prometheus.exporters.blackbox.port}"];}
        ];
      }
    ];
  };
}
