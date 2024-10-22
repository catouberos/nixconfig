{pkgs, ...}: {
  services.minecraft-servers = {
    enable = true;
    eula = true;
    openFirewall = true;

    servers = {
      earth1 = {
        enable = true;
        autoStart = true;
        package = pkgs.fabricServers.fabric;
        serverProperties = {
          difficulty = 3;
          white-list = true;
        };
      };
    };
  };
}
