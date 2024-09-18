{
  config,
  lib,
  pkgs,
  ...
}: {
  programs.nixvim.plugins = {
    lsp = {
      enable = true;
      servers = {
        ts-ls = {
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
        nil-ls.enable = true;
        clangd.enable = true;
        gopls.enable = true;
        eslint.enable = true;
        tailwindcss.enable = true;
        html.enable = true;
        jsonls.enable = true;
        phpactor.enable = true;
      };
    };
    nvim-jdtls = {
      enable = true;
      configuration = "${config.home.homeDirectory}/.cache/jdtls/config";
      data = "${config.home.homeDirectory}/.cache/jdtls/workspace";
    };
  };
}
