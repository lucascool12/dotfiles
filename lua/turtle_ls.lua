local util = require 'lspconfig.util'

local cmd = { 'node', '/home/lucasvanlaer/.nvm/versions/node/v19.0.1/bin/turtle-language-server', '--stdio' }

-- if vim.fn.has 'win32' == 1 then
--   cmd = { 'cmd.exe', '/C', 'node', '/usr/local/bin/turtle-language-server', '--stdio' }
-- end

local root_files = {
  'pyproject.toml',
  'setup.py',
  'setup.cfg',
  'requirements.txt',
  'Pipfile',
  'pyrightconfig.json',
}


return {
  default_config = {
    cmd = cmd,
    filetypes = { 'turtle', 'ttl' },
    root_dir = util.root_pattern(unpack(root_files)),
  },
  docs = {
    description = [[
https://github.com/microsoft/pyright
`pyright`, a static type checker and language server for python
]],
  }
}
