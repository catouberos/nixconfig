{pkgs, ...}: {
  home.packages = with pkgs; [
    nodePackages.prettier
    yamlfmt
    stylua
  ];

  programs.nixvim.plugins = {
    conform-nvim = {
      enable = true;
      formatOnSave = {
        timeoutMs = 2000;
      };
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
