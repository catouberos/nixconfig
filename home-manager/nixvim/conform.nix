{pkgs, ...}: {
  home.packages = with pkgs; [
    nodePackages.prettier
    yamlfmt
    stylua
  ];

  programs.nixvim.plugins = {
    conform-nvim = {
      enable = true;
      formatOnSave = ''
        function(bufnr)
          -- Disable autoformat on certain filetypes
          local ignore_filetypes = { "sql" }
          if vim.tbl_contains(ignore_filetypes, vim.bo[bufnr].filetype) then
            return
          end
          -- Disable with a global or buffer-local variable
          if vim.g.disable_autoformat or vim.b[bufnr].disable_autoformat then
            return
          end
          -- Disable autoformat for files in a certain path
          local bufname = vim.api.nvim_buf_get_name(bufnr)
          if bufname:match("/node_modules/") then
            return
          end
          -- ...additional logic...
          return { timeout_ms = 500, lsp_fallback = true }
        end
      '';
      formattersByFt = {
        lua = ["stylua"];
        nix = ["alejandra"];
        # Conform will run multiple formatters sequentially
        python = ["isort" "black"];
        # Use a sub-list to run only the first available formatter
        javascript = ["prettier"];
        typescript = ["prettier"];
        vue = ["prettier"];
        html = ["prettier"];
        css = ["prettier"];
        go = ["gofmt"];
        php = ["prettier"];
        yaml = ["yamlfmt"];
        swift = ["swift_format"];
        javascriptreact = ["prettier"];
        typescriptreact = ["prettier"];
      };
    };
  };
}
