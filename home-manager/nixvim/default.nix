{pkgs, ...}: {
  imports = [
    ./lsp.nix
    ./conform.nix
    ./keymaps.nix
  ];

  home.packages = with pkgs; [
    ripgrep
    fd
  ];

  programs = {
    nixvim = {
      enable = true;
      defaultEditor = true;

      opts = {
        number = true;
        relativenumber = true;
        shiftwidth = 2;
        softtabstop = 2;
        expandtab = true;
        smartindent = true;
      };

      files = {
        "ftplugin/go.lua" = {
          opts = {
            expandtab = false;
            shiftwidth = 8;
            tabstop = 8;
          };
        };
      };

      colorschemes.catppuccin = {
        enable = true;
        settings = {
          flavour = "macchiato";
        };
      };

      extraPlugins = [
        #        (pkgs.vimUtils.buildVimPlugin {
        #          name = "nvim-platformio";
        #          src = pkgs.fetchFromGitHub {
        #            owner = "anurag3301";
        #            repo = "nvim-platformio.lua";
        #            rev = "f83d290bff9588cad890dbfb96a6ae8a0413ee95";
        #            hash = "sha256-H+uOFXBqw7K3wIboG+I4D6AAIFnte36D+wfcrv4QnXg=";
        #          };
        #        })
        #        pkgs.vimPlugins.plenary-nvim
      ];

      plugins = {
        toggleterm.enable = true;
        web-devicons.enable = true;
        ts-autotag.enable = true;

        # navigation
        telescope = {
          enable = true;
          keymaps = {
            "<leader><leader>" = "buffers";
            "<leader>ff" = "find_files";
            "<leader>fg" = "live_grep";
            "<leader>git" = {
              action = "git_files";
              options = {
                desc = "Telescope Git Files";
              };
            };
          };
          extensions = {
            ui-select = {
              enable = true;
            };
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
