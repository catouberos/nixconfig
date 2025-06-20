{pkgs, ...}: {
  home.packages = with pkgs; [
    nodePackages.prettier
    yamlfmt
    stylua
  ];

  programs.nixvim.plugins = {
    conform-nvim = {
      enable = true;
      settings = {
        format_on_save = {
          timeoutMs = 2000;
        };
        formatters_by_ft = {
          lua = ["stylua"];
          nix = ["alejandra"];

          # Conform will run multiple formatters sequentially
          python = ["ruff_fix" "ruff_format" "ruff_organize_imports"];

          # Use a sub-list to run only the first available formatter
          javascript = ["prettier"];
          typescript = ["prettier"];
          astro = ["prettier"];
          vue = ["prettier"];
          svelte = ["prettier"];
          html = ["prettier"];
          css = ["prettier"];

          sql = ["sleek"];

          go = ["gofmt"];
          php = ["prettier"];
          json = ["prettier"];
          yaml = ["yamlfmt"];
          swift = ["swift_format"];
          javascriptreact = ["prettier"];
          typescriptreact = ["prettier"];
          c = ["clang-format"];
          cpp = ["clang-format"];
          rust = ["rustfmt"];
          proto = ["buf"];
        };
      };
    };
  };
}
