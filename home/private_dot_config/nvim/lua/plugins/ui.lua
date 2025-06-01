return {
  { "akinsho/bufferline.nvim", opts = { options = { separator_style = "slope" } } },
  {
    "folke/which-key.nvim",
    enabled = true,
    opts = {
      preset = "helix",
      debug = vim.uv.cwd():find("which%-key"),
      win = {},
      spec = {},
    },
  },
  "folke/twilight.nvim",
  {
    "b0o/incline.nvim",
    dependencies = { "craftzdog/solarized-osaka.nvim" },
    event = "BufReadPre",
    priority = 1200,
    config = function()
      local colors = require("solarized-osaka.colors").setup()
      require("incline").setup({
        highlight = {
          groups = {
            InclineNormal = { guibg = colors.magenta500, guifg = colors.base04 },
            InclineNormalNC = { guifg = colors.violet500, guibg = colors.base03 },
          },
        },
        window = { margin = { vertical = 0, horizontal = 1 } },
        hide = {
          cursorline = true,
        },
        render = function(props)
          local filename = vim.fn.fnamemodify(vim.api.nvim_buf_get_name(props.buf), ":t")
          if vim.bo[props.buf].modified then
            filename = "[+] " .. filename
          end

          local icon, color = require("nvim-web-devicons").get_icon_color(filename)
          return { { icon, guifg = color }, { " " }, { filename } }
        end,
      })
    end,
  },
  -- lualine
  -- {
  --   "nvim-lualine/lualine.nvim",
  --   opts = function(_, opts)
  --     table.insert(opts.sections.lualine_x, {
  --       function()
  --         return require("util.dashboard").status()
  --       end,
  --     })
  --     local count = 0
  --     table.insert(opts.sections.lualine_x, {
  --       function()
  --         count = count + 1
  --         return tostring(count)
  --       end,
  --     })
  --   end,
  -- },
  -- {
  --   "nvim-lualine/lualine.nvim",
  --   event = "VeryLazy",
  --   init = function()
  --     vim.g.lualine_laststatus = vim.o.laststatus
  --     if vim.fn.argc(-1) > 0 then
  --       -- set an empty statusline till lualine loads
  --       vim.o.statusline = " "
  --     else
  --       -- hide the statusline on the starter page
  --       vim.o.laststatus = 0
  --     end
  --   end,
  --   opts = function()
  --     -- PERF: we don't need this lualine require madness 🤷
  --     local lualine_require = require("lualine_require")
  --     lualine_require.require = require
  --
  --     local icons = require("lazyvim.config").icons
  --
  --     vim.o.laststatus = vim.g.lualine_laststatus
  --
  --     local colors = {
  --       blue = "#65D1FF",
  --       green = "#3EFFDC",
  --       violet = "#FF61EF",
  --       yellow = "#FFDA7B",
  --       red = "#FF4A4A",
  --       fg = "#c3ccdc",
  --       bg = "#112638",
  --       inactive_bg = "#2c3043",
  --     }
  --
  --     local my_lualine_theme = {
  --       normal = {
  --         a = { bg = colors.blue, fg = colors.bg, gui = "bold" },
  --         b = { bg = colors.bg, fg = colors.fg },
  --         c = { bg = colors.bg, fg = colors.fg },
  --       },
  --       insert = {
  --         a = { bg = colors.green, fg = colors.bg, gui = "bold" },
  --         b = { bg = colors.bg, fg = colors.fg },
  --         c = { bg = colors.bg, fg = colors.fg },
  --       },
  --       visual = {
  --         a = { bg = colors.violet, fg = colors.bg, gui = "bold" },
  --         b = { bg = colors.bg, fg = colors.fg },
  --         c = { bg = colors.bg, fg = colors.fg },
  --       },
  --       command = {
  --         a = { bg = colors.yellow, fg = colors.bg, gui = "bold" },
  --         b = { bg = colors.bg, fg = colors.fg },
  --         c = { bg = colors.bg, fg = colors.fg },
  --       },
  --       replace = {
  --         a = { bg = colors.red, fg = colors.bg, gui = "bold" },
  --         b = { bg = colors.bg, fg = colors.fg },
  --         c = { bg = colors.bg, fg = colors.fg },
  --       },
  --       inactive = {
  --         a = { bg = colors.inactive_bg, fg = colors.semilightgray, gui = "bold" },
  --         b = { bg = colors.inactive_bg, fg = colors.semilightgray },
  --         c = { bg = colors.inactive_bg, fg = colors.semilightgray },
  --       },
  --     }
  --
  --     return {
  --       options = {
  --         theme = my_lualine_theme,
  --         globalstatus = true,
  --         disabled_filetypes = { statusline = { "dashboard", "alpha", "starter" } },
  --       },
  --       sections = {
  --         lualine_a = { "mode" },
  --         lualine_b = { "branch" },
  --
  --         lualine_c = {
  --           LazyVim.lualine.root_dir(),
  --           {
  --             "diagnostics",
  --             symbols = {
  --               error = icons.diagnostics.Error,
  --               warn = icons.diagnostics.Warn,
  --               info = icons.diagnostics.Info,
  --               hint = icons.diagnostics.Hint,
  --             },
  --           },
  --           { "filetype", icon_only = true, separator = "", padding = { left = 1, right = 0 } },
  --           { LazyVim.lualine.pretty_path() },
  --         },
  --         lualine_x = {
  --           -- {
  --           --   lazy_status.updates,
  --           --   cond = lazy_status.has_updates,
  --           --   color = { fg = "#ff9e64" },
  --           -- },
  --           -- { "encoding" },
  --           -- { "fileformat" },
  --           -- { "filetype" },
  --
  --           -- stylua: ignore
  --           {
  --             function() return require("noice").api.status.command.get() end,
  --             cond = function() return package.loaded["noice"] and require("noice").api.status.command.has() end,
  --             color = LazyVim.ui.fg("Statement"),
  --           },
  --           -- stylua: ignore
  --           {
  --             function() return require("noice").api.status.mode.get() end,
  --             cond = function() return package.loaded["noice"] and require("noice").api.status.mode.has() end,
  --             color = LazyVim.ui.fg("Constant"),
  --           },
  --           -- stylua: ignore
  --           {
  --             function() return "  " .. require("dap").status() end,
  --             cond = function () return package.loaded["dap"] and require("dap").status() ~= "" end,
  --             color = LazyVim.ui.fg("Debug"),
  --           },
  --           {
  --             require("lazy.status").updates,
  --             cond = require("lazy.status").has_updates,
  --             color = LazyVim.ui.fg("Special"),
  --           },
  --           {
  --             "diff",
  --             symbols = {
  --               added = icons.git.added,
  --               modified = icons.git.modified,
  --               removed = icons.git.removed,
  --             },
  --             source = function()
  --               local gitsigns = vim.b.gitsigns_status_dict
  --               if gitsigns then
  --                 return {
  --                   added = gitsigns.added,
  --                   modified = gitsigns.changed,
  --                   removed = gitsigns.removed,
  --                 }
  --               end
  --             end,
  --           },
  --         },
  --         lualine_y = {
  --           { "progress", separator = " ", padding = { left = 1, right = 0 } },
  --           { "location", padding = { left = 0, right = 1 } },
  --         },
  --         lualine_z = {
  --           function()
  --             return " " .. os.date("%R")
  --           end,
  --         },
  --       },
  --       extensions = { "neo-tree", "lazy" },
  --     }
  --   end,
  -- },
  -- {
  --   "nvimdev/dashboard-nvim",
  --   event = "VimEnter",
  --   opts = function(_, opts)
  --     local logo = [[
  --       ██╗  ██╗██╗    ███████╗███████╗████████╗██╗  ██╗          Z
  --       ██║  ██║██║    ██╔════╝██╔════╝╚══██╔══╝██║  ██║      Z
  --       ███████║██║    ███████╗█████╗     ██║   ███████║   z
  --       ██╔══██║██║    ╚════██║██╔══╝     ██║   ██╔══██║ z
  --       ██║  ██║██║    ███████║███████╗   ██║   ██║  ██║
  --       ╚═╝  ╚═╝╚═╝    ╚══════╝╚══════╝   ╚═╝   ╚═╝  ╚═╝
  --     ]]
  --
  --     logo = string.rep("\n", 8) .. logo .. "\n\n"
  --     -- opts.config.header = vim.split(logo, "\n")
  --
  --     local opts = {
  --       theme = "doom",
  --       hide = {
  --         -- this is taken care of by lualine
  --         -- enabling this messes up the actual laststatus setting after loading a file
  --         statusline = false,
  --       },
  --       config = {
  --         header = vim.split(logo, "\n"),
  --         -- stylua: ignore
  --         center = {
  --           { action = LazyVim.pick("files"),                                    desc = " Find File",       icon = "󰱼 ", key = "f" },
  --           { action = "ene | startinsert",                                        desc = " New File",        icon = " ", key = "n" },
  --           { action = "Telescope oldfiles",                                       desc = " Recent Files",    icon = " ", key = "r" },
  --           { action = "Telescope live_grep",                                      desc = " Find Text",       icon = " ", key = "g" },
  --           { action = [[lua LazyVim.telescope.config_files()()]], desc = " Config",          icon = " ", key = "c" },
  --           { action = 'lua require("persistence").load()',                        desc = " Restore Session", icon = " ", key = "s" },
  --           { action = "LazyExtras",                                               desc = " Lazy Extras",     icon = " ", key = "x" },
  --           { action = "Lazy",                                                     desc = " Lazy",            icon = "󰒲 ", key = "l" },
  --           { action = "qa",                                                       desc = " Quit",            icon = " ", key = "q" },
  --         },
  --         footer = function()
  --           local stats = require("lazy").stats()
  --           local ms = (math.floor(stats.startuptime * 100 + 0.5) / 100)
  --           local load_stats = "⚡ Neovim loaded "
  --             .. stats.loaded
  --             .. "/"
  --             .. stats.count
  --             .. " plugins in "
  --             .. ms
  --             .. "ms"
  --
  --           local text = "I AM MR. SETH"
  --           local colorscheme = vim.g.colors_name or "default"
  --           return { load_stats, text, colorscheme }
  --         end,
  --       },
  --     }
  --     for _, button in ipairs(opts.config.center) do
  --       button.desc = button.desc .. string.rep(" ", 43 - #button.desc)
  --       button.key_format = "  %s"
  --     end
  --
  --     -- close Lazy and re-open when the dashboard is ready
  --     if vim.o.filetype == "lazy" then
  --       vim.cmd.close()
  --       vim.api.nvim_create_autocmd("User", {
  --         pattern = "DashboardLoaded",
  --         callback = function()
  --           require("lazy").show()
  --         end,
  --       })
  --     end
  --     return opts
  --   end,
  -- },
}
