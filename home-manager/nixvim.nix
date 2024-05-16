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
            clangd.enable = true;
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
        luasnip.enable = true;
        cmp = {
          enable = true;
          settings = {
            autoEnableSources = true;
            snippet = {expand = "luasnip";};
            sources = [
              {name = "nvim_lsp";}
              {
                name = "buffer"; # text within current buffer
                option.get_bufnrs.__raw = "vim.api.nvim_list_bufs";
                keywordLength = 3;
              }
              {
                name = "path"; # file system paths
                keywordLength = 3;
              }
              {
                name = "luasnip"; # snippets
                keywordLength = 3;
              }
            ];
            mappings = {
              "<Up>" = "cmp.mapping.select_next_item({ behavior = types.cmp.SelectBehavior.Select })";
              "<Down>" = "cmp.mapping.select_prev_item({ behavior = types.cmp.SelectBehavior.Select })";
              "<S-Tab>" = "cmp.mapping(cmp.mapping.select_prev_item(), {'i', 's'})";
              "<Tab>" = "cmp.mapping(cmp.mapping.select_next_item(), {'i', 's'})";

              "<CR>" = "cmp.mapping.confirm({ select = true })";

              "<C-n>" = "cmp.mapping.select_next_item()";
              "<C-p>" = "cmp.mapping.select_prev_item()";
              "<C-j>" = "cmp.mapping.select_next_item()";
              "<C-k>" = "cmp.mapping.select_prev_item()";
              "<C-d>" = "cmp.mapping.scroll_docs(-4)";
              "<C-f>" = "cmp.mapping.scroll_docs(4)";
              "<C-Space>" = "cmp.mapping.complete()";
              "<C-e>" = "cmp.mapping.close()";
            };
          };
        };
        cmp-nvim-lsp = {enable = true;}; # lsp
        cmp-buffer = {enable = true;};
        cmp-path = {enable = true;}; # file system paths
        cmp_luasnip = {enable = true;}; # snippets
        cmp-cmdline = {enable = false;}; # autocomplete for cmdline
      };
    };
  };
}
