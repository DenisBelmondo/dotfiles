vim.pack.add {{
	src = 'https://github.com/nvim-treesitter/nvim-treesitter.git',
	version = 'main',
}}

require 'nvim-treesitter' .setup {
	-- Directory to install parsers and queries to
	install_dir = vim.fn.stdpath('data') .. '/site'
}

-- [TODO]: be smarter about this?
vim.api.nvim_create_autocmd('FileType', {
	pattern = { 'c', 'cc', 'cpp', 'cs', 'd', 'h', 'hpp', 'lua', 'java' },
	callback = function() vim.treesitter.start() end,
})
