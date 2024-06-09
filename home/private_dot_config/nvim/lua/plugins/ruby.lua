-- Replacement for lazyvim's ruby plugin

-- ruby-lsp: textDocument/diagnostic support until 0.10.0 is released
_timers = {}
local function setup_diagnostics(client, buffer)
  if require("vim.lsp.diagnostic")._enable then
    return
  end

  local diagnostic_handler = function()
    local params = vim.lsp.util.make_text_document_params(buffer)
    client.request("textDocument/diagnostic", { textDocument = params }, function(err, result)
      if err then
        local err_msg = string.format("diagnostics error - %s", vim.inspect(err))
        -- vim.lsp.log.error(err_msg)
      end
      local diagnostic_items = {}
      if result then
        diagnostic_items = result.items
      end
      vim.lsp.diagnostic.on_publish_diagnostics(
        nil,
        vim.tbl_extend("keep", params, { diagnostics = diagnostic_items }),
        { client_id = client.id }
      )
    end)
  end

  diagnostic_handler() -- to request diagnostics on buffer when first attaching

  vim.api.nvim_buf_attach(buffer, false, {
    on_lines = function()
      if _timers[buffer] then
        vim.fn.timer_stop(_timers[buffer])
      end
      _timers[buffer] = vim.fn.timer_start(200, diagnostic_handler)
    end,
    on_detach = function()
      if _timers[buffer] then
        vim.fn.timer_stop(_timers[buffer])
      end
    end,
  })
end

return {
  {
    "nvim-treesitter/nvim-treesitter",
    opts = function(_, opts)
      vim.list_extend(opts.ensure_installed, {
        "ruby",
      })
    end,
  },
  -- {
  --   "williamboman/mason.nvim",
  --   opts = function(_, opts)
  --     vim.list_extend(opts.ensure_installed, {
  --       "solargraph",
  --     })
  --   end,
  -- },
  {
    "neovim/nvim-lspconfig",
    dependencies = {
      "Shopify/ruby-lsp",
      -- Hook up the pre nvim v10 fix
      init = function()
        require("lazyvim.util").lsp.on_attach(function(client, buffer)
          setup_diagnostics(client, buffer)
        end)
      end,
    },
    opts = {
      servers = {
        -- _don't_ install with mason as that causes gem install errors when
        -- launching nvim after the initial install
        ruby_lsp = {
          mason = false,
          init_options = {
            linters = { "rubocop" },
          },
        },
      },
    },
  },
  {
    "mfussenegger/nvim-dap",
    optional = true,
    dependencies = {
      "suketa/nvim-dap-ruby",
      config = function()
        require("dap-ruby").setup()
      end,
    },
  },
  -- {
  --   "nvim-neotest/neotest",
  --   optional = true,
  --   dependencies = {
  --     "olimorris/neotest-rspec",
  --     "zidhuss/neotest-minitest",
  --   },
  --   opts = {
  --     -- ~/.local/state/nvim/neotest.log
  --     -- log_level = "debug",
  --     adapters = {
  --       ["neotest-rspec"] = {
  --         -- NOTE: without overriding like below, it will use bundle exec instead of local
  --         -- binstubs (and thus, ignoring spring)
  --         rspec_cmd = function()
  --           return vim.tbl_flatten({
  --             "rspec",
  --           })
  --         end,
  --       },
  --       "neotest-minitest",
  --     },
  --     watch = {
  --       enabled = true,
  --       symbol_queries = {
  --         ruby = [[
  --           ;query
  --           ;rspec - class name
  --           (call
  --             method: (identifier) @_ (#match? @_ "^(describe|context)")
  --             arguments: (argument_list (constant) @symbol )
  --           )
  --           ;rspec - namespaced class name
  --           (call
  --             method: (identifier)
  --             arguments: (argument_list
  --               (scope_resolution
  --                 name: (constant) @symbol))
  --           )
  --         ]],
  --       },
  --     },
  --   },
  --   keys = {
  --     {
  --       "<leader>ta",
  --       function()
  --         require("neotest").run.attach()
  --       end,
  --       desc = "Attach to current test",
  --     },
  --   },
  -- },
}
