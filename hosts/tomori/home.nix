{
  pkgs,
  lib,
  ...
}: {
  imports = [
    ../../home-manager/desktop
    ../../home-manager/cli
    ../../home-manager/cli/terminal
    ../../home-manager/cli/utility
    ../../home-manager/nixvim
    ../../home-manager/development
    ../../home-manager/1password.nix
  ];

  home.username = "catou";
  home.homeDirectory = "/home/catou";
  home.stateVersion = "23.11";

  home.packages = with pkgs; [
    anki
  ];

  home.sessionVariables = {
    EDITOR = "nvim";
  };

  services = {
    udiskie.enable = true;
  };

  programs.waybar = {
    settings.main = {
      modules-left = ["sway/workspaces" "mpris"];
      modules-right = ["tray" "wireplumber" "battery" "clock"];

      position = "top";
      height = 64;
      spacing = 0;

      tray.spacing = 12;
    };

    style = lib.mkAfter ''
      #workspaces button {
          padding: 0 12px;
          border-radius: 0;
      }

      #mode, #clock, #battery {
          padding: 0 12px;
      }
    '';
  };

  wayland.windowManager.river.xwayland.enable = false;

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
}
