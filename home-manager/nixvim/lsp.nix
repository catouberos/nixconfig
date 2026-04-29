{
  lib,
  config,
  ...
}: {
  programs.nixvim = {
    plugins = {
      lsp.enable = true;
    };

    lsp = {
      servers = {
        # grammar
        harper_ls.enable = true;

        # web
        ts_ls = {
          enable = true;
          settings = {
            filetypes = ["javascript" "typescript" "vue"];
            init_options.plugins = [
              {
                name = "@vue/typescript-plugin";
                location = "${lib.getBin config.programs.nixvim.lsp.servers.vue_ls.package}/lib/language-tools/packages/language-server";
                languages = ["vue"];
              }
            ];
          };
        };
        vue_ls = {
          enable = true;
          packageFallback = true;
        };

        astro.enable = true;
        svelte.enable = true;
        eslint.enable = true;
        tailwindcss.enable = true;
        html.enable = true;
        jsonls.enable = true;

        # nix
        nixd = {
          enable = true;
          config = {
            filetypes = ["nix"];
            root_markers = ["flake.nix" "git"];
          };
        };

        # c/c++
        clangd = {
          enable = true;
          config = {
            filetypes = ["c" "cpp"];
          };
        };

        # go
        gopls.enable = true;

        # php
        phpactor.enable = true;
        phan.enable = true;

        # rust
        rust_analyzer.enable = true;

        # python
        pyright.enable = true;
        ruff.enable = true;

        # typst
        tinymist = {
          enable = true;
        };
        protols.enable = true;
      };
    };
  };
}
