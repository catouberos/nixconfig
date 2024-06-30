{pkgs, ...}: {
  imports = [
    ./mpv.nix
    ./jellyfin-mpv-shim.nix
  ];

  home.packages = with pkgs; [
    strawberry-qt6
  ];
}
