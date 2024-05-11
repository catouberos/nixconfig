{pkgs, ...}: {
  programs.alacritty = {
    enable = true;
    catppuccin.enable = true;
    settings = {
      font = {
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
