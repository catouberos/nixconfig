{pkgs, ...}: {
  programs.vscode = {
    enable = true;
    profiles.default.extensions = with pkgs.vscode-extensions;
      [
        vue.volar
        bradlc.vscode-tailwindcss
        dbaeumer.vscode-eslint
        esbenp.prettier-vscode
      ]
      ++ pkgs.vscode-utils.extensionsFromVscodeMarketplace [
        {
          name = "laravel-blade";
          publisher = "onecentlin";
          version = "1.36.1";
          sha256 = "sha256-zOjUrdoBBtSz59/b/n63QByGyQRcOJFe+TMfosktEss=";
        }
      ];
  };
}
