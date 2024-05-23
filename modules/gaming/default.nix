{pkgs, ...}: {
  imports = [./steam.nix ./gamemode.nix];

  environment.systemPackages = with pkgs; [
    prismlauncher
  ];
}
