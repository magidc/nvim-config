return {
	-- Tree file explorer
	"nvim-neo-tree/neo-tree.nvim",
	branch = "v2.x",
	dependencies = { "nvim-lua/plenary.nvim", "MunifTanjim/nui.nvim", "kyazdani42/nvim-web-devicons" },
	config = function()
		require("neo-tree").setup({
			close_if_last_window = true,
			popup_border_style = "rounded",
			enable_git_status = true,
			buffers = {
				follow_current_file = true, -- This will find and focus the file in the active buffer every time the current file is changed while the tree is open.
				group_empty_dirs = true, -- when true, empty folders will be grouped together
				show_unloaded = true,
				window = {
					mappings = {
						["bd"] = "buffer_delete",
						["<bs>"] = "navigate_up",
						["."] = "set_root",
					},
				},
			},
			filesystem = {
				filtered_items = {
					visible = true, -- when true, they will just be displayed differently than normal items
					hide_dotfiles = true,
					hide_gitignored = true,
					hide_hidden = false, -- only works on Windows for hidden files/directories
					hide_by_name = {
						-- "node_modules"
					},
					hide_by_pattern = { -- uses glob style patterns
						-- "*.meta"
					},
					never_show = { -- remains hidden even if visible is toggled to true
						-- ".DS_Store",
						-- "thumbs.db"
					},
				},
				follow_current_file = true, -- This will find and focus the file in the active buffer every
				-- time the current file is changed while the tree is open.
				group_empty_dirs = false, -- when true, empty folders will be grouped together
				use_libuv_file_watcher = false, -- This will use the OS level file watchers to detect changes
				-- instead of relying on nvim autocmd events.
				window = {
					mappings = {
						["<bs>"] = "navigate_up",
						["."] = "set_root",
						["H"] = "toggle_hidden",
						["/"] = "fuzzy_finder",
						["f"] = "filter_on_submit",
						["<c-x>"] = "clear_filter",
						["[g"] = "prev_git_modified",
						["]g"] = "next_git_modified",
					},
				},
			},
			git_status = {
				window = {
					position = "float",
					mappings = {
						["A"] = "git_add_all",
						["gu"] = "git_unstage_file",
						["ga"] = "git_add_file",
						["gr"] = "git_revert_file",
						["gc"] = "git_commit",
						["gp"] = "git_push",
						["gg"] = "git_commit_and_push",
					},
				},
			},
		})
		require("plugins.configs.neotree")
	end,
}
