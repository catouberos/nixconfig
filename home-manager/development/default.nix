{pkgs, ...}: {
  imports = [
    ./vscode.nix
  ];

  home.packages = with pkgs; [
    zed-editor
  ];

  programs = {
    java = {
      enable = true;
      package = pkgs.jdk22;
    };
  };
}
