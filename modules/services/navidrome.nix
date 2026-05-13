{pkgs, ...}: {
  services.navidrome = {
    enable = true;
    openFirewall = true;
    plugins = with pkgs.navidromePlugins; [
      apple-music
      discord-rich-presence
    ];
    settings = {
      DefaultTheme = "Nord";
      EnableGravatar = true;
      EnableSharing = true;
    };
  };
}
