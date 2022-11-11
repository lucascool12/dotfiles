# nvim-config
This is my neovim config !!

lsps used in config use (npm install -g <one-of-the-lsp-servers-just-below-here>:
  * pyright 
  * rust-analyzer
  * turtle-language-server (requires moving lua/turtle_ls.lua to the place where nvim-lspconfig is in lua/lspconfig/server_configurations/
  on wsl ~/.local/share/nvim/site/pack/packer/start/nvim-lspconfig/lua/lspconfig/server_configurations/ and modyfing the absolute path)
 
 autocommand for PackerCompile after plugins.lua changes doesn't work, call it manually with :PackerCompile.
 First PackerCompile will probably fail.
