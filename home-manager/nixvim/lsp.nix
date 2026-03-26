{...}: {
  programs.nixvim = {
    plugins = {
      lsp.enable = true;
      typescript-tools = {
        enable = true;
        settings = {
          filetypes = [
            "javascript"
            "typescript"
            "vue"
          ];

          jsx_close_tag = {
            enable = true;
          };

          settings = {
            tsserver_plugins = [
              "@vue/language-server"
              "@vue/typescript-plugin"
            ];
          };
        };
      };
    };

    lsp = {
      servers = {
        # grammar
        harper_ls.enable = true;

        # web
        tsgo = {
          enable = false;
          config = {
            filetypes = [
              "typescript"
              "javascript"
              "javascriptreact"
              "typescriptreact"
              "vue"
            ];
          };
        };
        astro.enable = true;
        svelte.enable = true;
        vue_ls.enable = false;
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
