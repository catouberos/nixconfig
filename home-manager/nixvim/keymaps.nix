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
        key = "<leader>di";
      }
      {
        action = "<cmd>lua vim.lsp.buf.definition()<CR>";
        key = "<leader>gd";
      }
      {
        action = ":ls<CR>:sb<Space>";
        key = "<leader>j";
      }
      {
        action = ":bn<CR>";
        key = "L";
      }
      {
        action = ":bp<CR>";
        key = "H";
      }
      {
        action = ":bd<CR>";
        key = "X";
      }
    ];
  };
}
