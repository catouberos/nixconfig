{
  lib,
  pkgs,
  ...
}: {
  programs.nixvim.plugins = {
    lsp = {
      enable = true;
      servers = {
        # web
        ts_ls = {
          enable = true;
          filetypes = [
            "typescript"
            "javascript"
            "javascriptreact"
            "typescriptreact"
            "vue"
          ];
          extraOptions = {
            init_options = {
              plugins = [
                {
                  name = "@vue/typescript-plugin";
                  location = "${lib.getBin pkgs.vue-language-server}/lib/node_modules/@vue/language-server";
                  languages = ["vue"];
                }
              ];
            };
          };
        };
        svelte.enable = true;
        volar.enable = true;
        eslint.enable = true;
        tailwindcss.enable = true;
        html.enable = true;
        jsonls.enable = true;
        # nix
        nil_ls.enable = true;
        # c/c++
        clangd.enable = true;
        # go
        gopls.enable = true;
        # php
        phpactor.enable = true;
        # rust
        rust_analyzer = {
          enable = true;
          installRustc = true;
          installCargo = true;
        };
        # python
        pylyzer.enable = true;
        ruff.enable = true;
      };
    };
  };
}
