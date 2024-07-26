{config, ...}: {
  programs.nixvim.plugins = {
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
    nvim-jdtls = {
      enable = true;
      configuration = "${config.home.homeDirectory}/.cache/jdtls/config";
      data = "${config.home.homeDirectory}/.cache/jdtls/workspace";
    };
  };
}
