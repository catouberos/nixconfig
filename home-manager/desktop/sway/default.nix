{
  pkgs,
  config,
  ...
}: {
  imports = [
    ./theme.nix
    ./waybar.nix
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
    wofi.enable = true;
  };

  services = {
    cliphist.enable = true;
    mako.enable = true;
    gnome-keyring = {
      enable = true;
      components = ["secrets"];
    };
  };

  wayland.windowManager.sway = {
    enable = true;
    catppuccin = {
      enable = true;
      flavour = "macchiato";
    };
    systemd.xdgAutostart = true;
    checkConfig = false;

    config = rec {
      modifier = "Mod4";
      terminal = "alacritty";
      defaultWorkspace = "workspace number 1";
      startup = [
        {command = "${pkgs.wl-clipboard}/bin/wl-paste --watch ${pkgs.cliphist}/bin/cliphist store";}
        {command = "${pkgs.polkit_gnome}/libexec/polkit-gnome-authentication-agent-1";}
      ];
      menu = "wofi --show drun";

      bars = [{command = "${pkgs.waybar}/bin/waybar";}];

      input = {
        "1133:45111:MX_Anywhere_3S_Mouse" = {
          accel_profile = "flat";
          pointer_accel = "0.5";
        };
        "1133:50503:Logitech_USB_Receiver" = {
          accel_profile = "flat";
          pointer_accel = "-0.1";
        };
      };

      output = {
        "*" = {
          bg = "${config.home.homeDirectory}/Pictures/wallpaper.png fill";
        };
        "DP-2" = {
          mode = "1920x1080@144Hz";
          pos = "0 0";
          adaptive_sync = "on";
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

      fonts = {
        names = ["JetBrains Mono" "IBM Plex Mono"];
        size = 11.0;
      };

      colors = {
        focused = {
          background = "$base";
          border = "$lavender";
          childBorder = "$lavender";
          indicator = "$rosewater";
          text = "$text";
        };
        focusedInactive = {
          background = "$base";
          border = "$overlay0";
          childBorder = "$overlay0";
          indicator = "$rosewater";
          text = "$text";
        };
        unfocused = {
          background = "$base";
          border = "$overlay0";
          childBorder = "$overlay0";
          indicator = "$rosewater";
          text = "$text";
        };
        urgent = {
          background = "$base";
          border = "$peach";
          childBorder = "$peach";
          indicator = "$overlay0";
          text = "$peach";
        };
        placeholder = {
          background = "$base";
          border = "$overlay0";
          childBorder = "$overlay0";
          indicator = "$overlay0";
          text = "$text";
        };
        background = "$base";
      };

      keybindings = {
        "${modifier}+space" = "exec wofi --show drun";
        "Ctrl+Shift+Space" = "exec 1password --quick-access";

        # screenshot
        "print" = "exec ${pkgs.grim}/bin/grim - | ${pkgs.wl-clipboard}/bin/wl-copy";
        "Shift+print" = "exec ${pkgs.grim}/bin/grim -g \"$(${pkgs.slurp}/bin/slurp -w 0)\" - | ${pkgs.wl-clipboard}/bin/wl-copy";
        "Ctrl+print" = "exec ${pkgs.grim}/bin/grim $(xdg-user-dir PICTURES)/Screenshots/$(date +'%s_grim.png')";
        "Ctrl+Shift+print" = "exec ${pkgs.grim}/bin/grim -g \"$(${pkgs.slurp}/bin/slurp -w 0)\" $(xdg-user-dir PICTURES)/Screenshots/$(date +'%s_grim.png')";

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
