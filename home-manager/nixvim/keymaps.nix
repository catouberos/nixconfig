{
  programs.nixvim = {
    globals = {
      mapleader = " ";
    };
    keymaps = [
      {
        action = "<cmd>lua vim.lsp.buf.code_action()<CR>";
        key = "<leader>ca";
      }
      {
        action = "<cmd>lua vim.diagnostic.open_float()<CR>";
        key = "<leader>d";
      }
      {
        action = "<cmd>lua vim.lsp.buf.definition()<CR>";
        key = "<leader>gd";
      }
      {
        action = ":ls<CR>:b<Space>";
        key = "<leader>j";
      }
    ];
  };
}
