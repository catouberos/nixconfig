{
  lib,
  pkgs,
  ...
}: {
  programs.nixvim.plugins = {
    lsp = {
      enable = true;
      servers = {
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
        nil_ls.enable = true;
        clangd.enable = true;
        gopls.enable = true;
        eslint.enable = true;
        tailwindcss.enable = true;
        html.enable = true;
        jsonls.enable = true;
        phpactor.enable = true;
        graphql.enable = true;
        rust_analyzer.enable = true;
      };
    };
  };
}
