return {
  -- maybe check these out
  -- https://github.com/tzachar/cmp-ai
  -- https://github.com/supermaven-inc/supermaven-nvim
  -- https://github.com/codota/tabnine-nvim
  -- {
  --   "frankroeder/parrot.nvim",
  --   dependencies = { "ibhagwan/fzf-lua", "nvim-lua/plenary.nvim" },
  --   -- optionally include "rcarriga/nvim-notify" for beautiful notifications
  --   config = function()
  --     require("parrot").setup({
  --       -- Providers must be explicitly added to make them available.
  --       providers = {
  --         anthropic = {
  --           api_key = os.getenv("ANTHROPIC_API_KEY"),
  --         },
  --         gemini = {
  --           api_key = os.getenv("GEMINI_API_KEY"),
  --         },
  --         groq = {
  --           api_key = os.getenv("GROQ_API_KEY"),
  --         },
  --         mistral = {
  --           api_key = os.getenv("MISTRAL_API_KEY"),
  --         },
  --         pplx = {
  --           api_key = os.getenv("PERPLEXITY_API_KEY"),
  --         },
  --         -- provide an empty list to make provider available (no API key required)
  --         ollama = {},
  --         openai = {
  --           api_key = os.getenv("OPENAI_API_KEY"),
  --         },
  --         github = {
  --           api_key = os.getenv("GITHUB_TOKEN"),
  --         },
  --       },
  --     })
  --   end,
  --   -- lazy.nvim
  --   {
  --     "robitx/gp.nvim",
  --     config = function()
  --       local conf = {
  --         -- For customization, refer to Install > Configuration in the Documentation/Readme
  --       }
  --       require("gp").setup(conf)
  --
  --       -- Setup shortcuts here (see Usage > Shortcuts in the Documentation/Readme)
  --     end,
  --   },
  -- },
  {
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
  },

  {
    "olimorris/codecompanion.nvim",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-treesitter/nvim-treesitter",
      "hrsh7th/nvim-cmp", -- Optional: For using slash commands and variables in the chat buffer
      "nvim-telescope/telescope.nvim", -- Optional: For using slash commands
      { "stevearc/dressing.nvim", opts = {} }, -- Optional: Improves the default Neovim UI
    },
    config = true,
    {
      "yetone/avante.nvim",
      event = "VeryLazy",
      lazy = false,
      version = false, -- set this if you want to always pull the latest change
      opts = {
        -- add any opts here
      },
      -- if you want to build from source then do `make BUILD_FROM_SOURCE=true`
      build = "make",
      -- build = "powershell -ExecutionPolicy Bypass -File Build.ps1 -BuildFromSource false" -- for windows
      dependencies = {
        "nvim-treesitter/nvim-treesitter",
        "stevearc/dressing.nvim",
        "nvim-lua/plenary.nvim",
        "MunifTanjim/nui.nvim",
        --- The below dependencies are optional,
        "nvim-tree/nvim-web-devicons", -- or echasnovski/mini.icons
        "zbirenbaum/copilot.lua", -- for providers='copilot'
        {
          -- support for image pasting
          "HakonHarnes/img-clip.nvim",
          event = "VeryLazy",
          opts = {
            -- recommended settings
            default = {
              embed_image_as_base64 = false,
              prompt_for_file_name = false,
              drag_and_drop = {
                insert_mode = true,
              },
              -- required for Windows users
              use_absolute_path = true,
            },
          },
        },
        {
          -- Make sure to set this up properly if you have lazy=true
          "MeanderingProgrammer/render-markdown.nvim",
          opts = {
            file_types = { "markdown", "Avante" },
          },
          ft = { "markdown", "Avante" },
        },
      },
    },
  },
}
