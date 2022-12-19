local M = {}
local keymap = vim.keymap.set


function M.init()
	-- ctrl+z and ctrl+y - undo redo, esc to exit terminal mode
	vim.cmd("tnoremap <Esc> <C-\\><C-n>")
	vim.cmd([[
	nnoremap <C-Z> u
	nnoremap <C-Y> <C-R>
	inoremap <C-Z> <C-O>u
	inoremap <C-Y> <C-O><C-R>
	]])
end

function M.lsp_keymap_attach ()
	-- lsp-saga
	-- Lsp finder find the symbol definition implement reference
	-- if there is no implement it will hide
	-- when you use action in finder like open vsplit then you can
	-- use <C-t> to jump back
	keymap("n", "<C-f>", "<cmd>Lspsaga lsp_finder<CR>", { silent = true })
  keymap("n", "K", "<cmd>Lspsaga hover_doc<CR>", { silent = true })
	-- Code action -- \ca
	keymap({"n","v"}, "<leader>ca", "<cmd>Lspsaga code_action<CR>", { silent = true })

	-- Peek Definition
	-- you can edit the definition file in this flaotwindow
	-- also support open/vsplit/etc operation check definition_action_keys
	-- support tagstack C-t jump back
	keymap("n", "<C-LeftMouse>", "<cmd>Lspsaga peek_definition<CR>", { silent = true })

	keymap("n", "<leader>lr", "<cmd>Lspsaga rename<CR>")
end

return M
