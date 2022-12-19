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

require('general')
local keyMaps = require'keyMaps'
keyMaps.init()


-- vim.cmd([[set clipboard=unnamedplus]])

vim.cmd([[let g:python3_host_prog = '/usr/bin/python3.9']])
require('lspConfig')

-- coq neovim
vim.g.coq_settings = {
  auto_start = 'shut-up',
  ["keymap.pre_select"] = true,
  ["display.pum.fast_close"] = false,
}
