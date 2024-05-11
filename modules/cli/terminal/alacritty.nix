{pkgs, ...}: {
  programs.alacritty = {
    enable = true;
    catppuccin.enable = true;
    settings = {
      font = {
        normal = {
          family = "JetBrainsMono Nerd Font";
        };
        size = 11;
      };
      shell = {
        program = "${pkgs.fish}/bin/fish";
        args = [
          "--login"
        ];
      };
    };
  };
}
