require('plugins')
-- auto packerCompile on saveing plugins.lua, doesnt work
vim.cmd([[
  augroup packer_user_config
    autocmd!
    autocmd BufWritePost plugins.lua source <afile> | PackerSync
  augroup end
]])
vim.cmd([[set modelines=0]])
-- nvim.tree:
    -- disable netrw at the very start of your init.lua (strongly advised)
    vim.g.loaded_netrw = 1
    vim.g.loaded_netrwPlugin = 1
    -- set termguicolors to enable highlight groups
    vim.opt.termguicolors = true

    -- empty setup using defaults
    require("nvim-tree").setup()
require('general')
local keyMaps = require'keyMaps'
keyMaps.init()


require('colorScheme')
-- status line
require'lualine'.setup()

vim.cmd([[let g:python3_host_prog = '/usr/bin/python3.9']])
require('lspConfig')

local lsp_sig_config = {
  on_attach = function(client, bufnr)
    require "lsp_signature".on_attach({
      bind = true, -- This is mandatory, otherwise border config won't get registered.
      handler_opts = {
        border = "rounded"
      }
    }, bufnr)
  end,
}
require "lsp_signature".setup(lsp_sig_config)
require'toggleterm'.setup{
  open_mapping = require'keyMaps'.ttmap
}
-- coq neovim
vim.g.coq_settings = {
  auto_start = 'shut-up',
  ["keymap.pre_select"] = true,
  ["display.pum.fast_close"] = false,
}
-- chad tree
-- local vim.g.coq_settings = { ["auto_start"] = 'shut-up' }
require'nvim-treesitter.configs'.setup {
  -- -- A list of parser names, or "all"
  -- ensure_installed = { "c", "lua", "python" },
  --
  -- -- Install parsers synchronously (only applied to `ensure_installed`)
  -- sync_install = false,
  --
  -- -- Automatically install missing parsers when entering buffer
  -- -- Recommendation: set to false if you don't have `tree-sitter` CLI installed locally
  -- auto_install = true,
  --
  -- -- List of parsers to ignore installing (for "all")
  -- ignore_install = { "javascript" },
  --
  -- ---- If you need to change the installation directory of the parsers (see -> Advanced Setup)
  -- -- parser_install_dir = "/some/path/to/store/parsers", -- Remember to run vim.opt.runtimepath:append("/some/path/to/store/parsers")!
  --
  highlight = {
    -- `false` will disable the whole extension
    enable = true,
    indentation = false,
  },
  --
  --   -- Setting this to true will run `:h syntax` and tree-sitter at the same time.
  --   -- Set this to `true` if you depend on 'syntax' being enabled (like for indentation).
  --   -- Using this option may slow down your editor, and you may see some duplicate highlights.
  --   -- Instead of true it can also be a list of languages
  --   additional_vim_regex_highlighting = false,
  -- },
  indent = {
    disable = true
  },
}

-- temp solution to treesitter indentation not turning off
vim.cmd([[
autocmd FileType python set indentexpr=
autocmd FileType python set autoindent
autocmd FileType python set smartindent
]])
require('lintConfig')

-- lazygit
local Terminal  = require('toggleterm.terminal').Terminal
local lazygit = Terminal:new({
  id = 10,
  cmd = "lazygit",
  dir = "git_dir",
  direction = "float",
  float_opts = {
    border = "double",
  },
  hidden = true, -- ctrl + \ cannot be used to open lazygit term
  on_create = function (term)
    -- escape acts like escape in lazygit
	  vim.cmd("tnoremap <buffer> <Esc> <Esc>")
    -- ctrl + \ get out of lazygit
    vim.cmd("tnoremap <buffer> <c-\\> <cmd>" .. tostring(term.id) .. "ToggleTerm<CR>")
  end,
  -- function to run on opening the terminal
  on_open = function(term)
    vim.cmd("startinsert!")
    vim.api.nvim_buf_set_keymap(term.bufnr, "n", "q", "<cmd>close<CR>", {noremap = true, silent = true})
  end,
  -- function to run on closing the terminal
  on_close = function(term)
    vim.cmd("startinsert!")
  end,
})

function _lazygit_toggle()
  lazygit:toggle()
end

vim.api.nvim_set_keymap("n", "<leader>g", "<cmd>lua _lazygit_toggle()<CR>", {noremap = true, silent = true})
