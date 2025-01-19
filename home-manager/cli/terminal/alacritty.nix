{pkgs, ...}: {
  programs.alacritty = {
    enable = true;
    settings = {
      terminal = {
        shell = {
          program = "${pkgs.fish}/bin/fish";
          args = [
            "--login"
          ];
        };
      };
    };
  };
}
