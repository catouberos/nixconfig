{pkgs, ...}: {
  imports = [
    ./vscode.nix
  ];

  home.packages = with pkgs; [
    zed-editor
    jetbrains.idea-ultimate
    android-studio
    postman
  ];

  programs = {
    java = {
      enable = true;
    };
  };
}
