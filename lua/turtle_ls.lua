local util = require 'lspconfig.util'

local paths = {}
local sep = ":"
local path = os.getenv("PATH")
if path ~= nil then
    for str in string.gmatch(path, "([^"..sep.."]+)") do
            table.insert(paths, str)
    end
end

local bin_name = 'turtle-language-server'
local full_path
for _, p in ipairs(paths) do
    local candidate = util.path.join(p, bin_name)
    if util.path.is_file(candidate) then
        full_path = candidate
        break
    end
end
local cmd = { 'node', full_path, '--stdio' }

if vim.fn.has 'win32' == 1 then
  cmd = { 'cmd.exe', '/C', 'node', full_path, '--stdio' }
end

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
-- local util = require 'lspconfig.util'
--
-- local bin_name = 'pyright-langserver'
-- local cmd = { bin_name, '--stdio' }
--
-- if vim.fn.has 'win32' == 1 then
--   cmd = { 'cmd.exe', '/C', bin_name, '--stdio' }
-- end
--
-- local root_files = {
--   'pyproject.toml',
--   'setup.py',
--   'setup.cfg',
--   'requirements.txt',
--   'Pipfile',
--   'pyrightconfig.json',
-- }
--
-- local function organize_imports()
--   local params = {
--     command = 'pyright.organizeimports',
--     arguments = { vim.uri_from_bufnr(0) },
--   }
--   vim.lsp.buf.execute_command(params)
-- end
--
-- return {
--   default_config = {
--     cmd = cmd,
--     filetypes = { 'python' },
--     root_dir = util.root_pattern(unpack(root_files)),
--     single_file_support = true,
--     settings = {
--       python = {
--         analysis = {
--           autoSearchPaths = true,
--           useLibraryCodeForTypes = true,
--           diagnosticMode = 'workspace',
--         },
--       },
--     },
--   },
--   commands = {
--     PyrightOrganizeImports = {
--       organize_imports,
--       description = 'Organize Imports',
--     },
--   },
--   docs = {
--     description = [[
-- https://github.com/microsoft/pyright
-- `pyright`, a static type checker and language server for python
-- ]],
--   },
-- }
