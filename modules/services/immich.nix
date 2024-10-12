{
  users.users.immich.extraGroups = ["video" "render"];
  services.immich = {
    enable = true;
    openFirewall = true;
    host = "::";
    environment.IMMICH_MACHINE_LEARNING_URL = "http://localhost:3003";
  };
}
