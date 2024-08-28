{pkgs, ...}: {
  home.packages = with pkgs; [
    playerctl
  ];

  programs.waybar = {
    enable = true;

    settings = {
      main = {
        layer = "top";
        position = "bottom";
        height = 24;
        modules-left = ["sway/workspaces" "mpris"];
        modules-right = ["tray" "clock"];
        spacing = 6;

        "sway/workspaces" = {
          disable-scroll = true;
        };

        mpris = {
          format = "{player_icon} {dynamic}";
          format-paused = "{status_icon} {dynamic}";
          player-icons = {
            default = "";
            mpv = "";
            Supersonic = "🎵";
          };
          status-icons = {
            paused = "";
          };
          dynamic-len = 80;
          ignored-players = ["firefox"];
        };

        tray = {
          spacing = 6;
        };

        clock = {
          format = "{:%A, %B %d, %Y (%R)}";
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

    style = ''
      * {
          border: none;
          border-radius: 0;
          font-size: 12px;
          min-height: 0;
      }

      #workspaces button {
          padding: 0 5px;
      }

      #mode, #clock, #battery {
          padding: 0 6px;
      }
    '';
  };
}
