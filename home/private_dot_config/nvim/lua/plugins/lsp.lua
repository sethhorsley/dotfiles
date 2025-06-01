vim.lsp.set_log_level("debug")

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
        ruby_ls = {
          on_attach = function(client, bufnr)
            vim.api.nvim_create_autocmd("LspAttach", {
              callback = function(args)
                if args.data.client_id == client.id then
                  vim.notify("Ruby LSP attached", vim.log.levels.INFO)
                end
              end,
            })
          end,
          handlers = {
            ["window/logMessage"] = function(_, result, ctx)
              if vim.lsp.get_client_by_id(ctx.client_id).name == "ruby_ls" then
                vim.notify("Ruby LSP: " .. result.message, vim.log.levels.INFO)
              end
            end,
          },
        },
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
      },
    },
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
