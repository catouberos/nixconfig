{
  programs.aerospace = {
    enable = true;
    launchd.enable = true;

    settings = {
      after-startup-command = ["layout tiles"];

      gaps = {
        outer.left = 0;
        outer.bottom = 0;
        outer.top = 0;
        outer.right = 0;
      };

      workspace-to-monitor-force-assignment = {
        "11" = "secondary";
        "12" = "secondary";
        "13" = "secondary";
        "14" = "secondary";
        "15" = "secondary";
        "16" = "secondary";
        "17" = "secondary";
        "18" = "secondary";
        "19" = "secondary";
        "20" = "secondary";
      };

      mode.main.binding = {
        alt-1 = "workspace 1";
        alt-2 = "workspace 2";
        alt-3 = "workspace 3";
        alt-4 = "workspace 4";
        alt-5 = "workspace 5";
        alt-6 = "workspace 6";
        alt-7 = "workspace 7";
        alt-8 = "workspace 8";
        alt-9 = "workspace 9";
        alt-0 = "workspace 10";

        alt-shift-1 = "move-node-to-workspace 1";
        alt-shift-2 = "move-node-to-workspace 2";
        alt-shift-3 = "move-node-to-workspace 3";
        alt-shift-4 = "move-node-to-workspace 4";
        alt-shift-5 = "move-node-to-workspace 5";
        alt-shift-6 = "move-node-to-workspace 6";
        alt-shift-7 = "move-node-to-workspace 7";
        alt-shift-8 = "move-node-to-workspace 8";
        alt-shift-9 = "move-node-to-workspace 9";
        alt-shift-0 = "move-node-to-workspace 10";

        alt-q = "workspace 11";
        alt-w = "workspace 12";
        alt-e = "workspace 13";
        alt-r = "workspace 14";
        alt-t = "workspace 15";
        alt-y = "workspace 16";
        alt-u = "workspace 17";
        alt-i = "workspace 18";
        alt-o = "workspace 19";
        alt-p = "workspace 20";

        alt-shift-q = "move-node-to-workspace 11";
        alt-shift-w = "move-node-to-workspace 12";
        alt-shift-e = "move-node-to-workspace 13";
        alt-shift-r = "move-node-to-workspace 14";
        alt-shift-t = "move-node-to-workspace 15";
        alt-shift-y = "move-node-to-workspace 16";
        alt-shift-u = "move-node-to-workspace 17";
        alt-shift-i = "move-node-to-workspace 18";
        alt-shift-o = "move-node-to-workspace 19";
        alt-shift-p = "move-node-to-workspace 20";

        alt-shift-tab = "move-workspace-to-monitor --wrap-around next";

        alt-h = "focus left";
        alt-j = "focus down";
        alt-k = "focus up";
        alt-l = "focus right";
      };

      on-window-detected = [
        {
          "if" = {
            app-id = "com.github.wez.wezterm";
          };
          run = [
            "move-node-to-workspace 2"
          ];
        }
        {
          "if" = {
            window-title-regex-substring = "spotify_player-wrapped";
          };
          run = [
            "move-node-to-workspace 10"
          ];
        }
      ];
    };
  };
}
