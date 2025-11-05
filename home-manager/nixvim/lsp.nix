{...}: {
  programs.nixvim = {
    plugins.lsp.enable = true;

    lsp = {
      servers = {
        # grammar
        harper_ls.enable = true;

        # web
        tsgo = {
          enable = true;
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
        vtsls = {
          enable = true;
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
        volar.enable = true;
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
