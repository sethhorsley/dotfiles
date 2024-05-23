return {
	"goolord/alpha-nvim",
	event = "VimEnter",
	config = function()
		local alpha = require("alpha")
		local dashboard = require("alpha.themes.dashboard")

		-- Set header
		-- Font: ANSI Shadow
		-- https://patorjk.com/software/taag/#p=display&h=0&v=0&f=ANSI%20Shadow&t=Hi%20Seth
		local logo = [[
			██╗  ██╗██╗    ███████╗███████╗████████╗██╗  ██╗          Z
			██║  ██║██║    ██╔════╝██╔════╝╚══██╔══╝██║  ██║      Z    
			███████║██║    ███████╗█████╗     ██║   ███████║   z       
			██╔══██║██║    ╚════██║██╔══╝     ██║   ██╔══██║ z         
			██║  ██║██║    ███████║███████╗   ██║   ██║  ██║
			╚═╝  ╚═╝╚═╝    ╚══════╝╚══════╝   ╚═╝   ╚═╝  ╚═╝
		]]

		dashboard.section.header.val = vim.split(logo, "\n")
		-- Set menu
		dashboard.section.buttons.val = {
			dashboard.button("n", " " .. " New file", "<cmd> ene <BAR> startinsert <cr>"),
			dashboard.button("f", "󰱼 " .. " Find file", "<cmd> Telescope find_files <cr>"),
			dashboard.button("r", " " .. " Recent files", "<cmd> Telescope oldfiles <cr>"),
			dashboard.button("g", " " .. " Find text", "<cmd> Telescope live_grep <cr>"),
			-- dashboard.button(
			-- 	"c",
			-- 	" " .. " Config",
			-- 	"<cmd> lua require('lazyvim.util').telescope.config_files()() <cr>"
			-- ),
			-- 		"<cmd> lua require('telescope').find_files({ cwd = vim.fn.stdpath('config')}) <cr>"
			-- builtin.find_files({ cwd = vim.fn.stdpath("config") })

			-- dashboard.button("s", " " .. " Restore Session", [[<cmd> lua require("persistence").load() <cr>]]),
			dashboard.button("s", " " .. " Restore Session For Current Directory", "<cmd>SessionLoad<CR>"),
			dashboard.button("l", "󰒲 " .. " Lazy", "<cmd> Lazy <cr>"),
			dashboard.button("q", " " .. " Quit", "<cmd> qa <cr>"),
		}

		for _, button in ipairs(dashboard.section.buttons.val) do
			button.opts.hl = "AlphaButtons"
			button.opts.hl_shortcut = "AlphaShortcut"
		end

		-- dashboard.section.header.opts.hl = "AlphaHeader"
		dashboard.section.buttons.opts.hl = "AlphaButtons"
		dashboard.section.footer.opts.hl = "AlphaFooter"
		dashboard.opts.layout[1].val = 8

		-- Send config to alpha
		alpha.setup(dashboard.opts)

		-- Disable folding on alpha buffer
		vim.cmd([[autocmd FileType alpha setlocal nofoldenable]])

		vim.api.nvim_create_autocmd("User", {
			once = true,
			pattern = "LazyVimStarted",
			callback = function()
				local stats = require("lazy").stats()
				local ms = (math.floor(stats.startuptime * 100 + 0.5) / 100)
				local footer = "⚡ Neovim loaded "
					.. stats.loaded
					.. "/"
					.. stats.count
					.. " plugins in "
					.. ms
					.. "ms"

				-- add text to the footer on new line centered
				local firstLineLength = #footer
				local text = "I AM MR. SETH"
				local textWidth = #text
				local padding = math.max(0, math.floor((firstLineLength - textWidth) / 2))
				local centeredText = string.rep(" ", padding) .. text

				-- Add centered text to the footer on new line
				footer = footer .. "\n" .. centeredText
				dashboard.section.footer.val = footer
				pcall(vim.cmd.AlphaRedraw)
			end,
		})
	end,
}
