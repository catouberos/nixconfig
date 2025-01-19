{pkgs, ...}: {
  programs.wezterm = {
    enable = true;
    extraConfig = ''
      -- Pull in the wezterm API
      local wezterm = require("wezterm")

      -- This table will hold the configuration.
      local config = {}

      -- In newer versions of wezterm, use the config_builder which will
      -- help provide clearer error messages
      if wezterm.config_builder then
              config = wezterm.config_builder()
      end

      -- This is where you actually apply your config choices

      config.font = wezterm.font("JetBrainsMono Nerd Font")
      config.font_size = 16
      config.color_scheme = "catppuccin-macchiato"

      config.window_background_opacity = 0.9
      config.front_end = "OpenGL"

      config.default_prog = { '${pkgs.fish}/bin/fish', '--login' }

      -- and finally, return the configuration to wezterm
      return config
    '';
  };
}
