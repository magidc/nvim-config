return {
	--- Improved terminal toggle
	"akinsho/toggleterm.nvim",
	version = "*",
	config = function()
		require("toggleterm").setup({
			-- size can be a number or function which is passed the current terminal
			-- size = 20 | 
      size = function(term)
				if term.direction == "horizontal" then
					return 15
				elseif term.direction == "vertical" then
					return vim.o.columns * 0.4
				end
			end,
			open_mapping = [[<leader>vt]],
			insert_mappings = false,
      start_in_insert = true,
      autochdir = true,
			--direction = 'vertical' | 'horizontal' | 'tab' | 'float',
			direction = 'float',
			close_on_exit = true, -- close the terminal window when the process exits
			shell = '/bin/zsh', -- change the default shell
      dir='$(pwd)',
      -- shell = vim.o.shell,
      persist_size = true,
      persist_mode = true, -- if set to true (default) the previous terminal mode will be remembered
      autoscroll = true,
      -- This field is only relevant if direction is set to 'float'
      float_opts = {
        -- The border key is *almost* the same as 'nvim_open_win'
        -- see :h nvim_open_win for details on borders however
        -- the 'curved' border is a custom border type
        -- not natively supported but implemented in this plugin.
        -- border = 'single' | 'double' | 'shadow' | 'curved' | ... other options supported by win open
        border = 'single',
        -- like `size`, width, height, row, and col can be a number or function which is passed the current terminal
        --[[ 
        width = <value>,
        height = <value>,
        row = <value>,
        col = <value>,
        winblend = 3,
        zindex = <value>, 
        ]]--
        -- title_pos = 'left' | 'center' | 'right', position of the title of the floating window
        title_pos = 'left',
      },
    --[[ winbar = {
        enabled = false,
        name_formatter = function(term) --  term: Terminal
          return term.name
        end
      }, ]]--    
    })
	end,
}
