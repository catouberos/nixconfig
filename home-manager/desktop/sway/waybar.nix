{
  pkgs,
  lib,
  ...
}: {
  home.packages = with pkgs; [
    playerctl
  ];

  programs.waybar = {
    enable = true;

    settings = {
      main = {
        layer = lib.mkDefault "top";
        position = lib.mkDefault "bottom";
        height = lib.mkDefault 40;
        modules-left = lib.mkDefault ["sway/workspaces" "mpris"];
        modules-right = lib.mkDefault ["tray" "clock"];
        spacing = lib.mkDefault 8;

        "sway/workspaces" = {
          disable-scroll = true;
        };

        wireplumber = {
          format = "{icon} {volume}%";
          format-muted = "🔇";
          on-click = "";
          max-volume = 100;
          format-icons = ["🔈" "🔉" "🔊"];
        };

        battery = {
          format = "{icon} {capacity}%";
          format-icons = ["🪫" "🔋"];
        };

        mpris = {
          format = "{dynamic}";
          format-paused = "{status_icon} {dynamic}";
          status-icons = {
            paused = "";
          };
          dynamic-len = 80;
          ignored-players = ["firefox"];
        };

        tray = {
          spacing = lib.mkDefault 16;
        };

        clock = {
          format = "{:L%x(%a) %R}";
          locale = "ja_JP.UTF-8";
          tooltip-format = "<tt><small>{calendar}</small></tt>";
          calendar = {
            mode = "year";
            mode-mon-col = 3;
            # weeks-pos = "right";
            on-scroll = 1;
            format = {
              months = "<span color='#ffead3'><b>{}</b></span>";
              days = "<span color='#ecc6d9'><b>{}</b></span>";
              weeks = "<span color='#99ffdd'><b>W{}</b></span>";
              weekdays = "<span color='#ffcc66'><b>{}</b></span>";
              today = "<span color='#ff6699'><b><u>{}</u></b></span>";
            };
          };
          actions = {
            on-click-right = "mode";
            on-click-forward = "tz_up";
            on-click-backward = "tz_down";
            on-scroll-up = "shift_up";
            on-scroll-down = "shift_down";
          };
        };
      };
    };

    style = lib.mkAfter ''
      #workspaces button {
          padding: 0 12px;
          border-radius: 0;
      }

      #mode, #clock, #battery, #wireplumber, #mpris, #tray {
          padding: 0 6px;
      }

      tooltip {
          border-width: 2px;
          border-radius: 0;
      }
    '';
  };
}
