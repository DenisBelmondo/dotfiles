vim.pack.add {{
	src = 'https://github.com/nvim-treesitter/nvim-treesitter.git',
	version = 'main',
}}

require 'nvim-treesitter' .setup {
	-- Directory to install parsers and queries to
	install_dir = vim.fn.stdpath('data') .. '/site'
}

vim.api.nvim_create_autocmd('FileType', {
	pattern = { 'c', 'cc', 'cpp', 'cs', 'd', 'h', 'hpp', 'lua', },
	callback = function() vim.treesitter.start() end,
})
