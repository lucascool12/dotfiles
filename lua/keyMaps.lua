local M = {}
local keymap = vim.keymap.set
M.init = function()
	-- ToggleTerm
	keymap("n", "<leader>tt", "<cmd>ToggleTerm<cr>")
	-- ctrl+z and ctrl+y - undo redo, esc to exit terminal mode
	vim.cmd("tnoremap <Esc> <C-\\><C-n>")
	vim.cmd([[
	nnoremap <C-Z> u
	nnoremap <C-Y> <C-R>
	inoremap <C-Z> <C-O>u
	inoremap <C-Y> <C-O><C-R>
	]])

	--" Find files using Telescope command-line sugar.
	vim.cmd([[
	nnoremap <leader>ff <cmd>Telescope find_files<cr>
	nnoremap <leader>fg <cmd>Telescope live_grep<cr>
	nnoremap <leader>fb <cmd>Telescope buffers<cr>
	nnoremap <leader>fh <cmd>Telescope help_tags<cr>
	]])

	-- hover.nvim key maps
	keymap("n", "K", require("hover").hover, {desc = "hover.nvim"})
	-- vim.keymap.set("n", "gK", require("hover").hover_select, {desc = "hover.nvim (select)"})
end

M.lsp_attach = function ()
	-- lsp-saga
	-- Lsp finder find the symbol definition implement reference
	-- if there is no implement it will hide
	-- when you use action in finder like open vsplit then you can
	-- use <C-t> to jump back
	keymap("n", "<C-f>", "<cmd>Lspsaga lsp_finder<CR>", { silent = true })

	-- Code action -- \ca
	keymap({"n","v"}, "<leader>ca", "<cmd>Lspsaga code_action<CR>", { silent = true })

	-- Peek Definition
	-- you can edit the definition file in this flaotwindow
	-- also support open/vsplit/etc operation check definition_action_keys
	-- support tagstack C-t jump back
	keymap("n", "<C-LeftMouse>", "<cmd>Lspsaga peek_definition<CR>", { silent = true })

	keymap("n", "<leader>lr", "<cmd>Lspsaga rename<CR>")
end

M.cmp = function()
	local cmp = require'cmp'
	return {
		['<C-b>'] = cmp.mapping.scroll_docs(-4),
		['<C-f>'] = cmp.mapping.scroll_docs(4),
		['<C-Space>'] = cmp.mapping.complete(),
		['<C-e>'] = cmp.mapping.abort(),
		['<CR>'] = cmp.mapping.confirm({ select = true }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
	}
end
return M
