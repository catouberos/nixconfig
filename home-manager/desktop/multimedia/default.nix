{pkgs, ...}: {
  imports = [
    ./mpv.nix
    ./jellyfin-mpv-shim.nix
  ];

  home.packages = with pkgs; [
    supersonic-wayland
  ];
}
