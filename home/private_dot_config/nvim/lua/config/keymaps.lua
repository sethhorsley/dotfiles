-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

local discipline = require("config.discipline")
discipline.cowboy()

local map = vim.keymap.set
--
-- -- tabufline
-- map("n", "<leader>b", "<cmd>enew<CR>", { desc = "Buffer New" })
--
-- map("n", "<leader>x", "<cmd>BufferLineCyclePrev<CR>", { desc = "Buffer Goto prev" })
map("n", "<leader>ds", require("telescope.builtin").lsp_document_symbols, { desc = "Buffer Goto prev" })

-- map("n", "<S-tab>", function()
--   require("tabufline").prev()
-- end, { desc = "Buffer Goto prev" })
--
-- map("n", "<leader>x", function()
--   require("tabufline").close_buffer()
-- end, { desc = "Buffer Close" })

--
-- vim-tmux-navigator

if os.getenv("TMUX") then
  map("n", "<C-h>", "<cmd>TmuxNavigateLeft<cr>")
  map("n", "<C-j>", "<cmd>TmuxNavigateDown<cr>")
  map("n", "<C-k>", "<cmd>TmuxNavigateUp<cr>")
  map("n", "<C-l>", "<cmd>TmuxNavigateRight<cr>")
end

-- delete other windows
map("n", "<leader>wo", "<cmd>only<cr>", { desc = "Delete other windows" })

-- toggle tokyonight transparency
map(
  "n",
  "<leader>tt",
  "<cmd>lua require('config.colorscheme').toggle_transparency()<cr>",
  { desc = "Toggle transparency" }
)

vim.api.nvim_create_user_command("Cppath", function()
  local path = vim.fn.expand("%:.")
  vim.fn.setreg("+", path)
  vim.notify('Copied "' .. path .. '" to the clipboard!')
end, {})

vim.keymap.set("n", "<leader>cp", ":Cppath<CR>", { noremap = true, silent = true })
