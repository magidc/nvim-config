return {
	-- Project management
	"ahmedkhalf/project.nvim",
	-- Not loaded on first use: setup() reads project_history asynchronously, so the first picker would be empty
	event = "VeryLazy",
	dependencies = "nvim-telescope/telescope.nvim",
	config = function()
		require("project_nvim").setup({
			-- No auto detection, managing file manually
			-- ~/.local/share/nvim/project_nvim/project_history must be manually managed. In my case is a symlink to a file used by other processes
			detection_methods = {},
		})
		-- Drop project.nvim's autocmds: on VimLeavePre it rewrites project_history from its in-memory list
		pcall(vim.api.nvim_del_augroup_by_name, "project_nvim")
		require("telescope").load_extension("projects")
	end,
}
