{
  config,
  pkgs,
  ...
}: {
  home.packages = with pkgs; [
    ripgrep
    fd
  ];

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
            nil-ls.enable = true;
            clangd.enable = true;
            gopls.enable = true;
            volar.enable = true;
            eslint.enable = true;
            tailwindcss.enable = true;
            html.enable = true;
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
            javascript = ["prettier"];
            typescript = ["prettier"];
            vue = ["prettier"];
            html = ["prettier"];
            css = ["prettier"];
            go = ["gofmt"];
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
          settings = {
            auto_install = true;
            highlight = {
              additional_vim_regex_highlighting = true;
              custom_captures = {};
              enable = true;
            };
            incremental_selection = {
              enable = true;
              keymaps = {
                init_selection = "gnn";
                node_decremental = "grm";
                node_incremental = "grn";
                scope_incremental = "grc";
              };
            };
            indent = {
              enable = true;
            };
            parser_install_dir = "${config.home.homeDirectory}/nvim";
          };
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
              }
              {
                name = "path";
              }
              {
                name = "luasnip";
              }
            ];
            mapping = {
              "<CR>" = "cmp.mapping.confirm({ select = true })";
              "<Down>" = "cmp.mapping.select_next_item()";
              "<Up>" = "cmp.mapping.select_prev_item()";
              "<Tab>" = "cmp.mapping.select_next_item()";
              "<S-Tab>" = "cmp.mapping.select_prev_item()";
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
