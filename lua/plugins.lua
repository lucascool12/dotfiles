-- bootstrap Packer
local ensure_packer = function()
  local fn = vim.fn
  local install_path = fn.stdpath('data')..'/site/pack/packer/start/packer.nvim'
  if fn.empty(fn.glob(install_path)) > 0 then
    fn.system({'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path})
    vim.cmd [[packadd packer.nvim]]
    return true
  end
  return false
end

local packer_bootstrap = ensure_packer()

require('packer').startup(function(use)
	use 'wbthomason/packer.nvim'
	use "EdenEast/nightfox.nvim"
	use {
    'nvim-tree/nvim-tree.lua',
  	requires = {
    	'nvim-tree/nvim-web-devicons', -- optional, for file icons
  	}
	}

	use {
		'nvim-lualine/lualine.nvim',
		requires = { 'kyazdani42/nvim-web-devicons', opt = true }
	}
	use {'romgrk/barbar.nvim', wants = 'nvim-web-devicons'}
	use 'mfussenegger/nvim-lint'

	use {
    'lewis6991/gitsigns.nvim',
  	config = function()
    		require('gitsigns').setup()
  	end
	}

	use {
		'stevearc/aerial.nvim',
		config = function() require('aerial').setup() end
  }

	use {
    'numToStr/Comment.nvim',
    config = function()
      require('Comment').setup()
    end
	}

	use {
    'nvim-treesitter/nvim-treesitter',
    run = function()
      local ts_update = require('nvim-treesitter.install').update({ with_sync = true })
      ts_update()
    end,
	}
  use {
    'akinsho/toggleterm.nvim'
  }
  use 'neovim/nvim-lspconfig' -- Configurations for Nvim LSP
  use({"L3MON4D3/LuaSnip", tag = "v<CurrentMajor>.*"})
  use {
    "lewis6991/hover.nvim",
    config = function()
      require("hover").setup {
        init = function()
          -- Require providers
          require("hover.providers.lsp")
          -- require('hover.providers.gh')
          -- require('hover.providers.jira')
          -- require('hover.providers.man')
          -- require('hover.providers.dictionary')
        end,
        preview_opts = {
          border = nil
        },
        -- Whether the contents of a currently open hover window should be moved
        -- to a :h preview-window when pressing the hover keymap.
        preview_window = false,
        title = true
      }
    end
  }
  use {
    'ms-jpq/coq_nvim',
    branch = 'coq',
  }
  use {
    'ms-jpq/coq.artifacts',
    branch = 'artifacts'
  }
  use {
    'ms-jpq/coq.thirdparty',
    branch = '3p',
  }
  use({
    "glepnir/lspsaga.nvim",
    branch = "main",
  })
  use {
    'nvim-telescope/telescope.nvim', tag = '0.1.0',
    -- or                            , branch = '0.1.x',
    requires = { {'nvim-lua/plenary.nvim'} }
  }
  use 'BurntSushi/ripgrep'
	use {
		"ray-x/lsp_signature.nvim",
	}
  use 'Vimjas/vim-python-pep8-indent'
  use({
    "iamcco/markdown-preview.nvim",
    run = function() vim.fn["mkdp#util#install"]() end,
  })
	end
)

if packer_bootstrap then
    require('packer').sync()
end

