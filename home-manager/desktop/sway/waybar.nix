{
  programs.waybar = {
    enable = true;
    catppuccin = {
      enable = true;
    };
    settings = {
      main = {
        layer = "top";
        position = "bottom";
        height = 24;
        modules-left = ["sway/workspaces"];
        modules-right = ["tray" "clock"];
        "sway/workspaces" = {
          disable-scroll = true;
        };
        "clock" = {
          format = "{:%A, %B %d, %Y (%R)}";
          tooltip-format = "<tt><small>{calendar}</small></tt>";
          calendar = {
            mode = "year";
            mode-mon-col = 3;
            weeks-pos = "right";
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
          font-family: JetBrains Mono, monospace;
          font-size: 12px;
          min-height: 0;
      }

      window#waybar {
          background: @surface0;
          border-bottom: 3px solid rgba(100, 114, 125, 0.5);
          color: white;
      }

      tooltip {
        background: rgba(43, 48, 59, 0.5);
        border: 1px solid rgba(100, 114, 125, 0.5);
      }
      tooltip label {
        color: white;
      }

      #workspaces button {
          padding: 0 5px;
          background: transparent;
          color: white;
          border-bottom: 3px solid transparent;
      }

      #workspaces button.focused {
          background: #64727D;
          border-bottom: 3px solid white;
      }

      #mode, #clock, #battery {
          padding: 0 10px;
      }

      #mode {
          background: #64727D;
          border-bottom: 3px solid white;
      }

      #clock {
          background-color: #64727D;
      }

      #battery {
          background-color: #ffffff;
          color: black;
      }

      #battery.charging {
          color: white;
          background-color: #26A65B;
      }

      @keyframes blink {
          to {
              background-color: #ffffff;
              color: black;
          }
      }

      #battery.warning:not(.charging) {
          background: #f53c3c;
          color: white;
          animation-name: blink;
          animation-duration: 0.5s;
          animation-timing-function: steps(12);
          animation-iteration-count: infinite;
          animation-direction: alternate;
      }
    '';
  };
}
