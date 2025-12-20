return {
  "christoomey/vim-tmux-runner",
  keys = {
    { "<leader>ra", "<cmd>VtrAttachToPane<cr>", desc = "VtrAttachToPane" },
    { "<leader>rf", "<cmd>VtrFocusRunner<cr>", desc = "VtrFocusrunner" },
    { "<leader>rr", "<cmd>VtrSendLinesToRunner<cr>", desc = "VtrSendLinesToRunner" },
    { "<leader>rd", "<cmd>VtrSendCtrlD<cr>", desc = "VtrSendCtrlD" },
    { "<leader>sf", "<cmd>VtrSendFile<cr>", desc = "VtrSendFile" },
  },
}
