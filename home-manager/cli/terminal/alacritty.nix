{
  pkgs,
  lib,
  ...
}: {
  programs.alacritty = {
    enable = true;
    settings = {
      font = {
        normal = {
          family = "JetBrainsMono Nerd Font";
        };
        size = lib.mkMerge [
          (lib.mkIf pkgs.stdenv.isLinux 11)
          (lib.mkIf pkgs.stdenv.isDarwin 14)
        ];
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
