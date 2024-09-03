{pkgs, ...}: {
  imports = [
    ./vscode.nix
  ];

  home.packages = with pkgs; [
    zed-editor
    jetbrains.idea-ultimate
    postman
  ];

  programs = {
    java = {
      enable = true;
    };
  };
}
