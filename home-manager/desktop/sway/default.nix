{pkgs, ...}: {
  imports = [
    ./waybar.nix
    ./bemenu.nix
    ./mako.nix
    ./xdg.nix
  ];

  home.packages = with pkgs; [
    # screenshot
    grim
    slurp
    # clipboard
    wl-clipboard
    # authentication
    polkit_gnome
    # gtk lib
    glib
  ];

  programs = {
    imv.enable = true;
    swaylock = {
      enable = true;
    };
  };

  services = {
    cliphist.enable = true;
    gnome-keyring = {
      enable = true;
      components = ["secrets"];
    };
  };

  wayland.windowManager.sway = {
    enable = true;
    systemd.xdgAutostart = true;

    config = rec {
      modifier = "Mod4";
      terminal = "alacritty";
      defaultWorkspace = "workspace number 1";
      startup = [
        {command = "${pkgs.wl-clipboard}/bin/wl-paste --watch ${pkgs.cliphist}/bin/cliphist store";}
        {command = "${pkgs.polkit_gnome}/libexec/polkit-gnome-authentication-agent-1";}
      ];
      menu = "${pkgs.bemenu}/bin/bemenu-run -l 20 --binding vim -c -p \">\" --vim-esc-exits -B 2 -H 12 -W 0.3";

      bars = [{command = "${pkgs.waybar}/bin/waybar";}];

      input = {
        "1133:50504:Logitech_USB_Receiver_Mouse" = {
          accel_profile = "flat";
          pointer_accel = "0";
        };
        "1133:45111:MX_Anywhere_3S_Mouse" = {
          accel_profile = "flat";
          pointer_accel = "0";
        };
        "1133:50503:Logitech_USB_Receiver" = {
          accel_profile = "flat";
          pointer_accel = "-0.5";
        };
        "1118:2415:Microsoft_Surface_Type_Cover_Mouse" = {
          natural_scroll = "disabled";
        };
      };

      output = {
        "DP-2" = {
          mode = "1920x1080@144Hz";
          pos = "0 0";
        };
        "DP-3" = {
          mode = "1920x1080@60Hz";
          pos = "-1080 -410";
          transform = "270";
        };
      };

      gaps = {
        smartBorders = "on";
        smartGaps = true;
      };

      keybindings = {
        "${modifier}+space" = "exec ${menu}";
        "Ctrl+Shift+Space" = "exec 1password --quick-access";

        # screenshot
        "print" = "exec ${pkgs.grim}/bin/grim - | ${pkgs.wl-clipboard}/bin/wl-copy";
        "Shift+print" = "exec ${pkgs.grim}/bin/grim -g \"$(${pkgs.slurp}/bin/slurp -w 0)\" - | ${pkgs.wl-clipboard}/bin/wl-copy";
        "Ctrl+print" = "exec ${pkgs.grim}/bin/grim $(xdg-user-dir PICTURES)/Screenshots/$(date +'%s_grim.png')";
        "Ctrl+Shift+print" = "exec ${pkgs.grim}/bin/grim -g \"$(${pkgs.slurp}/bin/slurp -w 0)\" $(xdg-user-dir PICTURES)/Screenshots/$(date +'%s_grim.png')";

        "XF86AudioRaiseVolume" = "exec ${pkgs.wireplumber}/bin/wpctl set-volume -l 1.0 @DEFAULT_AUDIO_SINK@ 5%+";
        "XF86AudioLowerVolume" = "exec ${pkgs.wireplumber}/bin/wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-";
        "XF86AudioMute" = "exec ${pkgs.wireplumber}/bin/wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle";
        "XF86AudioMicMute" = "exec ${pkgs.wireplumber}/bin/wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle";

        "XF86AudioPlay" = "exec ${pkgs.playerctl}/bin/playerctl play-pause";
        "XF86AudioPause" = "exec ${pkgs.playerctl}/bin/playerctl pause";
        "XF86AudioNext" = "exec ${pkgs.playerctl}/bin/playerctl next";
        "XF86AudioPrev" = "exec ${pkgs.playerctl}/bin/playerctl previous";

        "${modifier}+r" = "reload";
        "${modifier}+q" = "kill";
        "${modifier}+f" = "fullscreen toggle";
        "${modifier}+s" = "floating toggle";
        "${modifier}+Shift+e" = "exec swaymsg exit";

        # focus
        "${modifier}+bracketleft" = "focus left";
        "${modifier}+bracketright" = "focus right";
        "${modifier}+Left" = "focus left";
        "${modifier}+Right" = "focus right";
        "${modifier}+Up" = "focus up";
        "${modifier}+Down" = "focus down";

        "${modifier}+Shift+Left" = "move left";
        "${modifier}+Shift+Right" = "move right";
        "${modifier}+Shift+Up" = "move up";
        "${modifier}+Shift+Down" = "move down";

        # workspace
        "${modifier}+braceleft" = "workspace prev_on_output";
        "${modifier}+braceright" = "workspace next_on_output";
        "Alt+Left" = "workspace prev_on_output";
        "Alt+Right" = "workspace next_on_output";

        "${modifier}+1" = "workspace number 1";
        "${modifier}+2" = "workspace number 2";
        "${modifier}+3" = "workspace number 3";
        "${modifier}+4" = "workspace number 4";
        "${modifier}+5" = "workspace number 5";
        "${modifier}+6" = "workspace number 6";
        "${modifier}+7" = "workspace number 7";
        "${modifier}+8" = "workspace number 8";
        "${modifier}+9" = "workspace number 9";
        "${modifier}+0" = "workspace number 10";

        "${modifier}+Shift+1" = "move container to workspace number 1";
        "${modifier}+Shift+2" = "move container to workspace number 2";
        "${modifier}+Shift+3" = "move container to workspace number 3";
        "${modifier}+Shift+4" = "move container to workspace number 4";
        "${modifier}+Shift+5" = "move container to workspace number 5";
        "${modifier}+Shift+6" = "move container to workspace number 6";
        "${modifier}+Shift+7" = "move container to workspace number 7";
        "${modifier}+Shift+8" = "move container to workspace number 8";
        "${modifier}+Shift+9" = "move container to workspace number 9";
        "${modifier}+Shift+0" = "move container to workspace number 10";
      };
    };
  };
}
