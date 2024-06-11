{pkgs, ...}: {
  imports = [
    ../../home-manager/desktop
    ../../home-manager/cli
    ../../home-manager/nixvim.nix
    ../../home-manager/1password.nix
  ];

  home.username = "catou";
  home.homeDirectory = "/home/catou";
  home.stateVersion = "23.11";

  home.packages = with pkgs; [
    anki
    transmission_4-gtk

    discord
    discord-screenaudio

    (vscode-with-extensions.override {
      vscodeExtensions = with vscode-extensions;
        [
          vue.volar
        ]
        ++ pkgs.vscode-utils.extensionsFromVscodeMarketplace [
          {
            name = "laravel-blade";
            publisher = "onecentlin";
            version = "1.36.1";
            sha256 = "sha256-zOjUrdoBBtSz59/b/n63QByGyQRcOJFe+TMfosktEss=";
          }
        ];
    })

    xdg-utils
    nethogs

    # nixvim
    ripgrep
    fd

    # misc
    gimp
  ];

  home.sessionVariables = {
    EDITOR = "nvim";
  };

  services = {
    udiskie.enable = true;
  };

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
}
