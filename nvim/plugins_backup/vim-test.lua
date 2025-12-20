return {
  "vim-test/vim-test",
  keys = {
    { "<leader>T", "<cmd>TestFile -strategy=vtr<cr>", desc = "TestFile" },
    { "<leader>t", "<cmd>TestNearest -strategy=vtr<cr>", desc = "TestNearest" },
    { "<leader>l", "<cmd>TestLast -strategy=vtr<cr>", desc = "TestLast" },
    { "<leader>a", "<cmd>TestSuite -strategy=vtr<cr>", desc = "TestSuite" },
  },
}
