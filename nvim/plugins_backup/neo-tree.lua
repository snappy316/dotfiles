return {
  "nvim-neo-tree/neo-tree.nvim",
  opts = {
    filesystem = {
      filtered_items = {
        visible = true,
      },
    },
    event_handlers = {
      {
        event = "neo_tree_popup_input_ready",
        ---@param args { bufnr: integer, winid: integer }
        handler = function(args)
          vim.cmd("exe 'norm ^l'") -- Move to start of line
          vim.cmd("stopinsert") -- Enter normal mode

          -- map <esc> to enter normal mode (by default closes prompt)
          vim.keymap.set("i", "<esc>", vim.cmd.stopinsert, { noremap = true, buffer = args.bufnr })
        end,
      },
    },
  },
}
