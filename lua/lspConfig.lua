-- completion
-----------------------
local keyMaps = require'keyMaps'

local on_attach = function(_, bufnr)
  keyMaps.lsp_keymap_attach()
  -- require'lsp_signature'.on_attach(lsp_sig_config, bufnr)
end
local lsp_flags = {
  -- This is the default in Nvim 0.7+
  debounce_text_changes = 150,
}

require('lspconfig')['pyright'].setup{
  on_attach = on_attach,
  flags = lsp_flags,
}

require('lspconfig')['tsserver'].setup{
  on_attach = on_attach,
  flags = lsp_flags,
}

require('lspconfig')['turtle_ls'].setup{
  on_attach = on_attach,
  flags = lsp_flags,
}

require('lspconfig')['rust_analyzer'].setup{
  on_attach = on_attach,
  flags = lsp_flags,
  -- Server-specific settings...
  settings = {
    ["rust-analyzer"] = {}
  }
}

require'lspconfig'.sumneko_lua.setup {
  on_attach = on_attach,
  settings = {
    Lua = {
      runtime = {
        -- Tell the language server which version of Lua you're using (most likely LuaJIT in the case of Neovim)
        version = 'LuaJIT',
      },
      diagnostics = {
        -- Get the language server to recognize the `vim` global
        globals = {'vim'},
      },
      workspace = {
        -- Make the server aware of Neovim runtime files
        library = vim.api.nvim_get_runtime_file("", true),
      },
      -- Do not send telemetry data containing a randomized but unique identifier
      telemetry = {
        enable = false,
      },
    },
  },
}

-- cursor hover on error, faster updatetime
vim.cmd([[set updatetime=1000]])
vim.diagnostic.config({ virtual_text = false })
vim.api.nvim_create_autocmd({ "CursorHold" }, {
	callback = function()
		if vim.lsp.buf.server_ready() then
			local _, window_id = vim.diagnostic.open_float({
				focusable = false,
			})
			if(window_id ~= nil) then
				vim.api.nvim_win_call(window_id, function()
					vim.api.nvim_command([[set winblend=30]])
				end)
			end
		end
	end,
})

-- set up LSP signs
for type, icon in pairs({
	Error = "",
	Warn = "",
	Hint = "",
	Info = "",
}) do
	local hl = "DiagnosticSign" .. type
	vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = "" })
end

-- lsp-saga
-- local saga = require('lspsaga')

-- saga.init_lsp_saga()
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
