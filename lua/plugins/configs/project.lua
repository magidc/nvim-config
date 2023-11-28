return {
	-- Project management
	"ahmedkhalf/project.nvim",
	lazy = true,
	dependencies = "nvim-telescope/telescope.nvim",
	config = function()
		require("project_nvim").setup({
			-- No auto detection, managing file manually
            -- ~/.local/share/nvim/project_nvim/project_history must be manually managed. In my case is a symlink to a file used by other processes
			detection_methods = {},
		})
		require("telescope").load_extension("projects")
	end,
}
