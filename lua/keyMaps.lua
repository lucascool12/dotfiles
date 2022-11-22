local M = {}
local keymap = vim.keymap.set

-- ToggleTerm toggle terminal
M.ttmap = [[<c-\>]]

function M.init()
	-- ToggleTree
	keymap("n", "<leader>tt", "<cmd>NvimTreeToggle<cr>")
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
	local map = vim.api.nvim_set_keymap
	local opts = { noremap = true, silent = true }

	-- Move to previous/next
	map('n', '<A-,>', '<Cmd>BufferPrevious<CR>', opts)
	map('n', '<A-.>', '<Cmd>BufferNext<CR>', opts)
	-- Re-order to previous/next
	map('n', '<A-<>', '<Cmd>BufferMovePrevious<CR>', opts)
	map('n', '<A->>', '<Cmd>BufferMoveNext<CR>', opts)
	-- Goto buffer in position...
	map('n', '<A-1>', '<Cmd>BufferGoto 1<CR>', opts)
	map('n', '<A-2>', '<Cmd>BufferGoto 2<CR>', opts)
	map('n', '<A-3>', '<Cmd>BufferGoto 3<CR>', opts)
	map('n', '<A-4>', '<Cmd>BufferGoto 4<CR>', opts)
	map('n', '<A-5>', '<Cmd>BufferGoto 5<CR>', opts)
	map('n', '<A-6>', '<Cmd>BufferGoto 6<CR>', opts)
	map('n', '<A-7>', '<Cmd>BufferGoto 7<CR>', opts)
	map('n', '<A-8>', '<Cmd>BufferGoto 8<CR>', opts)
	map('n', '<A-9>', '<Cmd>BufferGoto 9<CR>', opts)
	map('n', '<A-0>', '<Cmd>BufferLast<CR>', opts)
	-- Pin/unpin buffer
	map('n', '<A-p>', '<Cmd>BufferPin<CR>', opts)
	-- Close buffer
	map('n', '<A-c>', '<Cmd>BufferClose<CR>', opts)
	-- Wipeout buffer
	--                 :BufferWipeout
	-- Close commands
	--                 :BufferCloseAllButCurrent
	--                 :BufferCloseAllButPinned
	--                 :BufferCloseAllButCurrentOrPinned
	--                 :BufferCloseBuffersLeft
	--                 :BufferCloseBuffersRight
	-- Magic buffer-picking mode
	map('n', '<C-p>', '<Cmd>BufferPick<CR>', opts)
	-- Sort automatically by...
	map('n', '<Space>bb', '<Cmd>BufferOrderByBufferNumber<CR>', opts)
	map('n', '<Space>bd', '<Cmd>BufferOrderByDirectory<CR>', opts)
	map('n', '<Space>bl', '<Cmd>BufferOrderByLanguage<CR>', opts)
	map('n', '<Space>bw', '<Cmd>BufferOrderByWindowNumber<CR>', opts)
	-- aerial
	require('aerial').setup({
		-- optionally use on_attach to set keymaps when aerial has attached to a buffer
		on_attach = function(bufnr)
			-- Jump forwards/backwards with '{' and '}'
			vim.keymap.set('n', '{', '<cmd>AerialPrev<CR>', {buffer = bufnr})
			vim.keymap.set('n', '}', '<cmd>AerialNext<CR>', {buffer = bufnr})
		end
	})
	vim.keymap.set('n', '{', '<cmd>AerialPrev<CR>')
	vim.keymap.set('n', '}', '<cmd>AerialNext<CR>')
	keymap('n', '<leader>a', '<cmd>AerialToggle!<CR>')
end

function M.lsp_attach ()
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

function M.cmp ()
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
