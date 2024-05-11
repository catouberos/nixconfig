{
  programs = {
    nixvim = {
      enable = true;
      defaultEditor = true;
      globals = {
        mapleader = " ";
      };
      opts = {
        number = true;
        relativenumber = true;
        shiftwidth = 2;
        softtabstop = 2;
        expandtab = true;
        smartindent = true;
      };
      colorschemes.catppuccin = {
        enable = true;
        settings = {
          flavour = "macchiato";
        };
      };
      plugins = {
        # lsp
        lsp = {
          enable = true;
          servers = {
            tsserver.enable = true;
            nil_ls.enable = true;
          };
        };
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
            javascript = [["biome" "prettierd" "prettier"]];
            typescript = [["biome" "prettierd" "prettier"]];
            vue = [["biome" "prettierd" "prettier"]];
            css = [["biome" "prettierd" "prettier"]];
          };
        };

        # navigation
        telescope = {
          enable = true;
          keymaps = {
            "<leader>ff" = "find_files";
            "<leader>fg" = "live_grep";
          };
        };
        neo-tree = {
          enable = true;
        };

        # syntax highlighting
        treesitter = {
          enable = true;
        };

        # completion
        cmp = {
          enable = true;
          settings = {
            mappings = {
              "<C-Space>" = "cmp.mapping.complete()";
              "<C-d>" = "cmp.mapping.scroll_docs(-4)";
              "<C-e>" = "cmp.mapping.close()";
              "<C-f>" = "cmp.mapping.scroll_docs(4)";
              "<CR>" = "cmp.mapping.confirm({ select = true })";
              "<S-Tab>" = "cmp.mapping(cmp.mapping.select_prev_item(), {'i', 's'})";
              "<Tab>" = "cmp.mapping(cmp.mapping.select_next_item(), {'i', 's'})";
            };
            snippet.expand = ''
              function(args)
                require('luasnip').lsp_expand(args.body)
              end
            '';
          };
        };
        luasnip.enable = true;
      };
    };
  };
}
