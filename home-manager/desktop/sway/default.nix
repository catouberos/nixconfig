{pkgs, ...}: {
  imports = [
    ./waybar.nix
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
    # vnc
    wayvnc
    # misc
    wmenu
    brightnessctl
    hyprpicker
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

    extraConfigEarly = ''
      assign [app_id="firefox"] workspace 1
      assign [app_id="wezterm"] workspace 2
    '';

    config = rec {
      modifier = "Mod4";
      terminal = "wezterm";
      defaultWorkspace = "workspace number 1";
      startup = [
        {command = "exec ${pkgs.wl-clipboard}/bin/wl-paste --watch ${pkgs.cliphist}/bin/cliphist store";}
        {command = "exec ${pkgs.polkit_gnome}/libexec/polkit-gnome-authentication-agent-1";}
        {command = "exec ${pkgs.firefox}/bin/firefox";}
        {command = "exec ${pkgs.wezterm}/bin/wezterm";}
        {command = "exec ${pkgs._1password-gui}/bin/1password";}
      ];

      # applications
      menu = "${pkgs.wmenu}/bin/wmenu-run -b -N 00000000 -f \"UDEV Gothic NF 16\"";
      bars = [{command = "${pkgs.waybar}/bin/waybar";}];

      input = {
        "type:mouse" = {
          accel_profile = "flat";
          pointer_accel = "0.55";
        };
        "type:touchpad" = {
          scroll_factor = "0.25";
        };
      };

      output = {
        eDP-1 = {
          scale = "1.0";
        };
      };

      gaps = {
        smartBorders = "on";
        smartGaps = true;
      };

      keybindings = {
        # applications
        "${modifier}+space" = "exec ${menu}";
        "${modifier}+e" = "exec ${pkgs.wezterm}/bin/wezterm";
        "${modifier}+b" = "exec ${pkgs.firefox}/bin/firefox";
        "Ctrl+Shift+Space" = "exec 1password --quick-access";

        # screenshot
        "print" = "exec ${pkgs.grim}/bin/grim - | ${pkgs.wl-clipboard}/bin/wl-copy";
        "${modifier}+Shift+s" = "exec ${pkgs.grim}/bin/grim - | ${pkgs.wl-clipboard}/bin/wl-copy";
        "Shift+print" = "exec ${pkgs.grim}/bin/grim -g \"$(${pkgs.slurp}/bin/slurp -w 0)\" - | ${pkgs.wl-clipboard}/bin/wl-copy";
        "Ctrl+print" = "exec ${pkgs.grim}/bin/grim $(xdg-user-dir PICTURES)/Screenshots/$(date +'%s_grim.png')";
        "Ctrl+Shift+print" = "exec ${pkgs.grim}/bin/grim -g \"$(${pkgs.slurp}/bin/slurp -w 0)\" $(xdg-user-dir PICTURES)/Screenshots/$(date +'%s_grim.png')";
        "Alt+print" = "exec ${pkgs.hyprpicker}/bin/hyprpicker --format rgb -a";

        "XF86MonBrightnessUp" = "exec ${pkgs.brightnessctl}/bin/brightnessctl set +1%";
        "XF86MonBrightnessDown" = "exec ${pkgs.brightnessctl}/bin/brightnessctl set 1%-";

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
