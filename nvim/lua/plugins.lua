return require('packer').startup(function()
	-- Packer can manage itself
	use 'wbthomason/packer.nvim'
	
	-- theme
	use 'navarasu/onedark.nvim'

	use {
		-- status line
		'nvim-lualine/lualine.nvim',
		requires = { 'kyazdani42/nvim-web-devicons', opt = true }
	}

	use {
		-- file explorer
 		'nvim-tree/nvim-tree.lua',
  		requires = {
    			'nvim-tree/nvim-web-devicons', -- optional, for file icons
  		},
  		-- tag = 'nightly' -- optional, updated every week. (see issue #1193)
	}

	use {
		-- auto brackets
		"windwp/nvim-autopairs",
		config = function() require("nvim-autopairs").setup {} end
	}

	use {
		-- fuzzy finder
		'nvim-telescope/telescope.nvim', tag = '0.1.0',
		-- or 			       , branch = '0.1.x',
		requires = { {'nvim-lua/plenary.nvim'} }
	}	
end)
