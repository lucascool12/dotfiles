-- Tabs settings
vim.bo.tabstop = 4 -- size of a hard tabstop (ts).
vim.bo.shiftwidth = 4 -- size of an indentation (sw).
vim.bo.expandtab = true -- always uses spaces instead of tab characters (et).
vim.bo.softtabstop = 4 -- number of spaces a <Tab> counts for. When 0, feature is off (sts).

-- ctrl+z and ctrl+y - undo redo, esc to exit terminal mode
vim.cmd("tnoremap <Esc> <C-\\><C-n>")
vim.cmd([[
    nnoremap <C-Z> u
    nnoremap <C-Y> <C-R>
	inoremap <C-Z> <C-O>u
	inoremap <C-Y> <C-O><C-R>
]])

-- No back and forth
vim.cmd("set signcolumn=yes")

-- better line numbers
vim.cmd([[set number]])
vim.cmd([[
augroup numbertoggle
  autocmd!
  autocmd BufEnter,FocusGained,InsertLeave,WinEnter * if &nu && mode() != "i" | set rnu   | endif
  autocmd BufLeave,FocusLost,InsertEnter,WinLeave   * if &nu                  | set nornu | endif
augroup END
]])
