{pkgs, ...}: {
  imports = [
    ./vscode.nix
    ./direnv.nix
  ];

  home.packages = with pkgs; [
    zed-editor
    jetbrains.idea-ultimate
    android-studio
    postman
  ];
}
