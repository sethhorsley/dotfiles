return {
  -- {
  --   "nvim-neo-tree/neo-tree.nvim",
  --   opts = {
  --     sources = { "filesystem", "buffers", "git_status", "document_symbols" },
  --     open_files_do_not_replace_types = { "terminal", "Trouble", "trouble", "qf", "Outline" },
  --     filesystem = {
  --       filtered_items = {
  --         hide_dotfiles = false, -- when true, they will just be displayed differently than normal items
  --         hide_by_name = {
  --           "node_modules",
  --           ".git",
  --         },
  --       },
  --       bind_to_cwd = false,
  --       follow_current_file = { enabled = true },
  --       use_libuv_file_watcher = true,
  --     },
  --     window = {
  --       mappings = {
  --         ["<space>"] = "none",
  --         ["Y"] = {
  --           function(state)
  --             local node = state.tree:get_node()
  --             local path = node:get_id()
  --             vim.fn.setreg("+", path, "c")
  --           end,
  --           desc = "Copy Path to Clipboard",
  --         },
  --         ["O"] = {
  --           function(state)
  --             require("lazy.util").open(state.tree:get_node().path, { system = true })
  --           end,
  --           desc = "Open with System Application",
  --         },
  --       },
  --     },
  --     default_component_configs = {
  --       indent = {
  --         with_expanders = true, -- if nil and file nesting is enabled, will enable expanders
  --         expander_collapsed = "",
  --         expander_expanded = "",
  --         expander_highlight = "NeoTreeExpander",
  --       },
  --       git_status = {
  --         symbols = {
  --           unstaged = "󰄱",
  --           staged = "󰱒",
  --         },
  --       },
  --     },
  --   },
  -- },
  {
    "nvim-telescope/telescope-live-grep-args.nvim",
    config = function()
      LazyVim.on_load("telescope.nvim", function()
        require("telescope").load_extension("live_grep_args")
      end)
    end,
    keys = {
      {
        "<leader>sL",
        function()
          require("telescope").extensions.live_grep_args.live_grep_args({})
        end,
        esc = "Live Grep Args",
      },
    },
  },
}
