return {
  {
    "neovim/nvim-lspconfig",
    init = function()
      local keys = require("lazyvim.plugins.lsp.keymaps").get()
      -- change a keymap
      keys[#keys + 1] = { "<leader>cl", vim.lsp.codelens.run, desc = "Run code lens" }
      -- disable a keymap
      keys[#keys + 1] = { "<leader>cc", false }
      -- add a keymap
      keys[#keys + 1] = { "<leader>i", "<cmd>LspInfo<cr>", desc = "Show LSP info" }
    end,
  },
  {
    "williamboman/mason.nvim",
    opts = function(_, opts)
      vim.list_extend(opts.ensure_installed, {
        "stylua",
        "marksman",
        "selene",
        "luacheck",
        "shellcheck",
        "shfmt",
        "tailwindcss-language-server",
        "typescript-language-server",
        "css-lsp",
        "standardrb",
        "ruby-lsp",
        "terraform-ls",
        -- for python
        "black",
        "nextls",
      })
    end,
  },
}
