vim.pack.add { 'https://github.com/neovim/nvim-lspconfig.git' }

local lses = {
	'c3_lsp',
	'clangd',
	'csharp_ls',
	'julials',
	'lua_ls',
	'serve_d',
	'vala_ls',
	'zls',
	'zuban',
}

for _, lsid in pairs(lses) do
	vim.lsp.enable(lsid)
end
