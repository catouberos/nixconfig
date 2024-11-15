{pkgs, ...}: {
  imports = [
    ./vscode.nix
  ];

  home.packages = with pkgs; [
    zed-editor
    jetbrains.idea-ultimate
    android-studio
    httpie
    postman
  ];

  programs = {
    java = {
      enable = true;
    };
  };
}
