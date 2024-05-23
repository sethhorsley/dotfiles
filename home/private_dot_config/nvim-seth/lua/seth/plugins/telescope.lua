return {
	"nvim-telescope/telescope.nvim",
	branch = "0.1.x",
	dependencies = {
		"nvim-lua/plenary.nvim",
		{
			"nvim-telescope/telescope-fzf-native.nvim",
			build = "make",
		},
		"nvim-tree/nvim-web-devicons",
    "folke/todo-comments.nvim",
	},
	config = function()
		local telescope = require("telescope")
		local actions = require("telescope.actions")

		telescope.setup({
			defaults = {
				mappings = {
					i = {
						["<C-Down>"] = actions.cycle_history_next,
						["<C-Up>"] = actions.cycle_history_prev,
						["<C-f>"] = actions.preview_scrolling_down,
						["<C-b>"] = actions.preview_scrolling_up,
					},
					n = {
						["q"] = actions.close,
					},
				},
			},
		})

		pcall(require("telescope").load_extension, "fzf")
		pcall(require("telescope").load_extension, "ui-select")

		local function dynamicTelescopeFinder(builtin, opts)
			opts = opts or {}
			local cwd = opts.cwd -- Only use explicit cwd if provided, otherwise determine dynamically
			local use_current_dir = cwd == false or cwd == nil
			cwd = use_current_dir and vim.loop.cwd() or cwd -- Ensuring the proper use of cwd

			-- Check for git repository and ignore files
			local is_git_repo = vim.loop.fs_stat(cwd .. "/.git") ~= nil
			local no_ignore = vim.loop.fs_stat(cwd .. "/.ignore") == nil
				and vim.loop.fs_stat(cwd .. "/.rgignore") == nil

			-- Determine the correct finder based on the repository status
			local finder = builtin
			if builtin == "files" then
				if is_git_repo and no_ignore then
					finder = "git_files"
					opts.show_untracked = opts.show_untracked or true -- Default to true if not explicitly set
				else
					finder = "find_files"
				end
			end

			-- Calling the appropriate Telescope function with the extended options
			require("telescope.builtin")[finder](vim.tbl_deep_extend("force", { cwd = cwd }, opts))
		end
		-- See `:help telescope.builtin`
		local builtin = require("telescope.builtin")
		vim.keymap.set("n", "<leader>sk", builtin.keymaps, { desc = "[S]earch [K]eymaps" })
		vim.keymap.set("n", "<leader>sf", builtin.find_files, { desc = "[S]earch [F]iles" })
		vim.keymap.set("n", "<leader>ss", builtin.builtin, { desc = "[S]earch [S]elect Telescope" })
		vim.keymap.set("n", "<leader>sw", builtin.grep_string, { desc = "[S]earch current [W]ord" })
		vim.keymap.set("n", "<leader>sg", builtin.live_grep, { desc = "[S]earch by [G]rep" })
		vim.keymap.set("n", "<leader>sd", builtin.diagnostics, { desc = "[S]earch [D]iagnostics" })
		vim.keymap.set("n", "<leader>sr", builtin.resume, { desc = "[S]earch [R]esume" })
		vim.keymap.set("n", "<leader>s.", builtin.oldfiles, { desc = '[S]earch Recent Files ("." for repeat)' })
		vim.keymap.set("n", "<leader><leader>", builtin.buffers, { desc = "[ ] Find existing buffers" })

		vim.keymap.set("n", "<leader>sn", function()
			builtin.find_files({ cwd = vim.fn.stdpath("config") })
		end, { desc = "[S]earch [N]eovim files" })

		vim.keymap.set("n", "<leader>fc", function()
			builtin.find_files({ cwd = vim.fn.stdpath("config") })
		end, { desc = "[F]ile [C]onfig files" })

		-- lazy keymaps
		vim.keymap.set("n", "<leader>,", function()
			builtin.buffers({
				ignore_current_buffer = true,
				sort_mru = true,
				sort_lastused = true,
			})
		end, { desc = "[S]witch buffer" })
		--
		-- live_grep
		vim.keymap.set("n", "<leader>/", builtin.live_grep, { desc = "[S]earch [G]rep" })
		vim.keymap.set("n", "<leader>:", builtin.command_history, { desc = "[S]earch [C]ommand History" })
		vim.keymap.set("n", "<leader><space>", builtin.find_files, { desc = "[S]earch [F]ind Files" })
		vim.keymap.set("n", "<leader>fr", builtin.oldfiles, { desc = "[S]earch [R]ecent Files" })

		vim.keymap.set("n", "<leader>ff", function()
			dynamicTelescopeFinder("files")
		end, { desc = "[ ] Find files" })

    vim.keymap.set("n", "<leader>ft", "<cmd>TodoTelescope<cr>", { desc = "Find todos" })

		vim.keymap.set("n", "<leader>fF", function()
			dynamicTelescopeFinder("files", { cwd = false })
		end, { desc = "[ ] Find git files" })

		-- Slightly advanced example of overriding default behavior and theme
		vim.keymap.set("n", "<leader>bb", function()
			-- You can pass additional configuration to telescope to change theme, layout, etc.
			builtin.current_buffer_fuzzy_find(require("telescope.themes").get_dropdown({
				winblend = 10,
				previewer = false,
			}))
		end, { desc = "[/] Fuzzily search in current buffer" })

		-- git
		vim.keymap.set("n", "<leader>gc", function()
			builtin.git_commits()
		end, { desc = "[G]it [C]ommits" })

		vim.keymap.set("n", "<leader>gs", function()
			builtin.git_status()
		end, { desc = "[G]it [S]tatus" })

		-- search
		vim.keymap.set("n", '<leader>s"', builtin.registers, { desc = "Registers" })
		vim.keymap.set("n", "<leader>sa", builtin.autocommands, { desc = "Auto Commands" })
		vim.keymap.set("n", "<leader>sb", builtin.current_buffer_fuzzy_find, { desc = "Buffer" })
		vim.keymap.set("n", "<leader>sc", builtin.command_history, { desc = "Command History" })
		vim.keymap.set("n", "<leader>sC", builtin.commands, { desc = "Commands" })
		vim.keymap.set("n", "<leader>sd", function()
			builtin.diagnostics({ bufnr = 0 })
		end, { desc = "Document Diagnostics" })
		vim.keymap.set("n", "<leader>sD", builtin.diagnostics, { desc = "Workspace Diagnostics" })
		vim.keymap.set("n", "<leader>sg", builtin.live_grep, { desc = "Grep (Root Dir)" })
		vim.keymap.set("n", "<leader>sG", function()
			builtin.live_grep({ cwd = false })
		end, { desc = "Grep (cwd)" })
		vim.keymap.set("n", "<leader>hh", builtin.help_tags, { desc = "Help Pages" })
		vim.keymap.set("n", "<leader>?", builtin.help_tags, { desc = "Help Pages" })
		vim.keymap.set("n", "<leader>sk", builtin.keymaps, { desc = "Key Maps" })
		vim.keymap.set("n", "<leader>sM", builtin.man_pages, { desc = "Man Pages" })
		vim.keymap.set("n", "<leader>so", builtin.vim_options, { desc = "Options" })
		vim.keymap.set("n", "<leader>sR", builtin.resume, { desc = "Resume" })
		vim.keymap.set("n", "<leader>sw", function()
			builtin.grep_string({ word_match = "-w" })
		end, { desc = "Word (Root Dir)" })
		vim.keymap.set("n", "<leader>sW", function()
			builtin.grep_string({ cwd = false, word_match = "-w" })
		end, { desc = "Word (cwd)" })
		vim.keymap.set("v", "<leader>sw", function()
			builtin.grep_string()
		end, { desc = "Selection (Root Dir)" })
		vim.keymap.set("v", "<leader>sW", function()
			builtin.grep_string({ cwd = false })
		end, { desc = "Selection (cwd)" })
		vim.keymap.set("n", "<leader>uC", function()
			builtin.colorscheme({ enable_preview = true })
		end, { desc = "Colorscheme with Preview" })
	end,
}
