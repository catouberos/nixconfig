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

      autoCmd = [
        {
          command = "Neotree close";
          event = ["User"];
          pattern = ["PersistenceSavePre"];
        }
        {
          command = "Neotree";
          event = ["User"];
          pattern = ["PersistenceLoadPost"];
        }
      ];

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
        web-devicons.enable = true;
        ts-autotag.enable = true;

        persistence.enable = true;

        # navigation
        telescope = {
          enable = true;
          keymaps = {
            "<leader><leader>" = "resume";
            "<leader>fb" = "buffers";
            "<leader>ff" = "find_files";
            "<leader>fg" = "live_grep";
          };
          extensions = {
            ui-select = {
              enable = true;
            };
          };
          settings = {
            pickers = {
              buffers = {
                mappings = {
                  n = {
                    "<c-d>" = {__raw = "require('telescope.actions').delete_buffer + require('telescope.actions').move_to_top";};
                  };
                  i = {
                    "<c-d>" = {__raw = "require('telescope.actions').delete_buffer + require('telescope.actions').move_to_top";};
                  };
                };
              };
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
        blink-cmp = {
          enable = true;
          settings = {
            completion = {
              documentation = {
                auto_show = true;
              };
            };
          };
        };
      };
    };
  };
}
