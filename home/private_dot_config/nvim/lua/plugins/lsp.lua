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
      keys[#keys + 1] = { "<leader>ci", "<cmd>LspInfo<cr>", desc = "Show LSP info" }
    end,

    opts = {
      diagnostics = { virtual_text = { prefix = "icons" } },
      capabilities = {
        workspace = {
          didChangeWatchedFiles = {
            dynamicRegistration = false,
          },
        },
      },
      ---@type lspconfig.options
      servers = {
        lua_ls = {
          -- single_file_support = true,
          settings = {
            Lua = {
              hover = { expandAlias = false },
              type = {
                castNumberToInteger = true,
              },
              diagnostics = {
                disable = { "incomplete-signature-doc", "trailing-space" },
                -- enable = false,
                groupSeverity = {
                  strong = "Warning",
                  strict = "Warning",
                },
                groupFileStatus = {
                  ["ambiguity"] = "Opened",
                  ["await"] = "Opened",
                  ["codestyle"] = "None",
                  ["duplicate"] = "Opened",
                  ["global"] = "Opened",
                  ["luadoc"] = "Opened",
                  ["redefined"] = "Opened",
                  ["strict"] = "Opened",
                  ["strong"] = "Opened",
                  ["type-check"] = "Opened",
                  ["unbalanced"] = "Opened",
                  ["unused"] = "Opened",
                },
                unusedLocalExclude = { "_*" },
              },
            },
          },
        },
        -- ruby_ls = {
        --   mason = false,
        --   cmd = { os.getenv("HOME") .. "/.asdf/shims/ruby-lsp" },
        --   init_options = {
        --     enabledFeatures = {
        --       "codeActions",
        --       "codeLens",
        --       "completion",
        --       "definition",
        --       "documentHighlights",
        --       "documentSymbols",
        --       "foldingRanges",
        --       "hover",
        --       "inlayHint",
        --       "selectionRanges",
        --       "semanticHighlighting",
        --       "workspaceSymbol",
        --       -- "diagnostics",
        --       -- "documentLink",
        --       -- "formatting",
        --       -- "onTypeFormatting",
        --     },
        --   },
        -- },
      },
    },
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
        "terraform-ls",
        -- for python
        "black",
        "nextls",
      })
    end,
  },
  {
    "stevearc/conform.nvim",
    optional = true,
    opts = {
      formatters_by_ft = {
        ["javascript"] = { "dprint", { "prettierd", "prettier" } },
        ["javascriptreact"] = { "dprint" },
        ["typescript"] = { "dprint", { "prettierd", "prettier" } },
        ["typescriptreact"] = { "dprint" },
        -- ["ruby"] = { "standardrb" },
      },
      formatters = {
        dprint = {
          condition = function(_, ctx)
            return vim.fs.find({ "dprint.json" }, { path = ctx.filename, upward = true })[1]
          end,
        },
      },
    },
  },
}
