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
        whitelist = {
          "treetw" = "118f1463-2fff-41d8-9c79-ebc21878ae7f";
        };
      };
    };
  };
}
