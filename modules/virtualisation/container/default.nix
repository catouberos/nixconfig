{
  virtualisation.oci-containers = {
    backend = "podman";
    containers = {
      rui = {
        image = "ghcr.io/tanamoe/azunyan:latest";
        autoStart = true;
        extraOptions = ["--network=host"];
        volumes = ["/home/catou/rui.env:/app/.env"];
      };
      rurino = {
        image = "ghcr.io/tanamoe/azunyan:latest";
        autoStart = true;
        extraOptions = ["--network=host"];
        volumes = ["/home/catou/rurino.env:/app/.env"];
      };
      minecraft = {
        image = "ghcr.io/itzg/minecraft-server:latest";
        autoStart = true;
        ports = ["25565:25565"];
        volumes = ["/home/catou/minecraft:/data"];
        environment = {
          TYPE = "PAPER";
          EULA = "true";
          ENABLE_WHITELIST = "true";
          ONLINE_MODE = "true";
          WHITELIST = ''
            Catouberos
            u149_p
            KaraKen4
            maitaiphu
          '';
          OPS = ''
            Catouberos
            u149_p
          '';
          DIFFICULTY = "hard";
          VERSION = "1.21";
          PAPER_CHANNEL = "experimental";
        };
      };
    };
  };
}
