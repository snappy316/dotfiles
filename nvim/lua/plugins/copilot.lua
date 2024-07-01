-- return {
--   'zbirenbaum/copilot.lua',
--   cmd = 'Copilot',
--   event = 'InsertEnter',
--   opts = {
--     suggestion = {
--       auto_trigger = true,
--       keymap = {
--         accept = '<Tab>',
--       },
--     },
--     filetypes = {
--       ['dap-repl'] = false,
--       dapui_breakpoints = false,
--       dapui_console = false,
--       dapui_scopes = false,
--       dapui_stacks = false,
--       dapui_watches = false,
--       qf = false,
--     },
--   },
-- }

return {
  "zbirenbaum/copilot.lua",
  cmd = "Copilot",
  event = "InsertEnter",
  opts = {
    panel = {
      auto_refresh = false,
      keymap = {
        accept = "<CR>",
        jump_prev = "[[",
        jump_next = "]]",
        refresh = "gr",
        open = "<M-CR>",
      },
    },
    suggestion = {
      auto_trigger = true,
      keymap = {
        accept = "<C-l>",
        prev = "<C-[>",
        next = "<C-]>",
        dismiss = "<C-d>",
      },
    },
  },
}
