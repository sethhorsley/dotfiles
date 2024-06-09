return {
  "jackMort/ChatGPT.nvim",
  event = "VeryLazy",
  config = function()
    require("chatgpt").setup({
      -- api_key_cmd = "op read op://private/OpenAI/credential --no-newline",
      edit_with_instructions = {
        keymaps = {
          close = { "q" },
        },
      },
    })
  end,
  dependencies = {
    "MunifTanjim/nui.nvim",
    "nvim-lua/plenary.nvim",
    "folke/trouble.nvim",
    "nvim-telescope/telescope.nvim",
  },
  keys = {
    { "<leader>cc", "<Cmd>ChatGPT<CR>", desc = "ChatGPT" },
    {
      "<leader>ce",
      "<Cmd>ChatGPTEditWithInstruction<CR>",
      desc = "ChatGPT Edit with instruction",
      mode = { "n", "v" },
    },
    { "<leader>cx", "<Cmd>ChatGPT explain_code<CR>", desc = "ChatGPT Explain Code" },

    -- these are not used as much
    -- { "<leader>cx", "<Cmd>ChatGPT explain_code<CR>", desc = "ChatGPT Explain Code" },
  },
}
