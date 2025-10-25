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
        key = "<C-k>";
      }
      {
        action = "<cmd>lua vim.lsp.buf.definition()<CR>";
        key = "<leader>gd";
      }
      {
        action = "<cmd>lua require('persistence').load()<CR>";
        key = "<leader>qs";
      }
      {
        action = "<cmd>lua require('persistence').select()<CR>";
        key = "<leader>qS";
      }
      {
        action = "<cmd>lua require('persistence').load({ last = true })<CR>";
        key = "<leader>ql";
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
