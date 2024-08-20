{pkgs, ...}: {
  imports = [./steam.nix ./gamemode.nix];

  environment.systemPackages = with pkgs; [
    prismlauncher
    r2modman
    osu-lazer-bin
  ];
}
