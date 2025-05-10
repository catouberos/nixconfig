{...}: {
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
        };
        svelte.enable = true;
        volar.enable = true;
        eslint.enable = true;
        tailwindcss.enable = true;
        html.enable = true;
        jsonls.enable = true;
        # nix
        nixd = {
          enable = true;
          filetypes = ["nix"];
          rootMarkers = ["flake.nix" "git"];
        };
        # c/c++
        clangd.enable = true;
        # go
        gopls.enable = true;
        # php
        phpactor.enable = true;
        phan.enable = true;
        # rust
        rust_analyzer = {
          enable = true;
          installRustc = true;
          installCargo = true;
        };
        # python
        pyright.enable = true;
        ruff.enable = true;
        # typst
        tinymist = {
          enable = true;
        };
      };
    };
  };
}
