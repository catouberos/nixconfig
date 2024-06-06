{
  pkgs,
  lib,
  ...
}: {
  programs.nnn = {
    enable = true;
    package = pkgs.nnn.override {withNerdIcons = true;};
    extraPackages = lib.mkMerge [
      (lib.mkIf pkgs.stdenv.isLinux (with pkgs; [ffmpegthumbnailer mediainfo imv]))
    ];

    plugins = {
      src =
        (pkgs.fetchFromGitHub {
          owner = "jarun";
          repo = "nnn";
          rev = "v4.9";
          sha256 = "sha256-Hpc8YaJeAzJoEi7aJ6DntH2VLkoR6ToP6tPYn3llR7k=";
        })
        + "/plugins";
      mappings = {
        c = "fzcd";
        f = "finder";
        v = "imgview";
      };
    };
  };
}
