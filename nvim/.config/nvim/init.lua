vim.pack.add { 'https://github.com/NMAC427/guess-indent.nvim.git' }
vim.pack.add { 'https://github.com/catppuccin/nvim.git' }
vim.pack.add { 'https://github.com/neovim/nvim-lspconfig.git' }
vim.pack.add { 'https://github.com/nvim-lualine/lualine.nvim.git' }
vim.pack.add { 'https://github.com/nvim-mini/mini.nvim.git' }
vim.pack.add { { src = 'https://github.com/nvim-treesitter/nvim-treesitter.git', version = 'main' } }

vim.opt.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
vim.opt.autoindent = true
vim.opt.clipboard:append { 'unnamed', 'unnamedplus', }
vim.opt.colorcolumn = '80,120'
vim.opt.completeopt = 'menuone,popup'
vim.opt.cursorline = true
vim.opt.formatoptions:remove 'cro'
vim.opt.guicursor = guicursor_saved
vim.opt.guifont = 'Maple Mono NF CN:h12'
vim.opt.hlsearch = false
vim.opt.ignorecase = true
vim.opt.linespace = 0
vim.opt.mouse = ''
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.shiftwidth = 4
vim.opt.signcolumn = 'yes'
vim.opt.smartindent = true
vim.opt.tabstop = 4
vim.opt.wrap = false
vim.wo.foldexpr = 'v:lua.vim.treesitter.foldexpr()'

require 'guess-indent' .setup {}
require 'lualine' .setup()
require 'mini.pairs' .setup()

vim.lsp.config('csharp_ls', { cmd = { '/home/mason/.dotnet/tools/csharp-ls' } })
vim.lsp.enable 'csharp_ls'
vim.lsp.enable 'lua_ls'

vim.api.nvim_create_autocmd('BufEnter', {
	callback = function ()
	  	pcall(vim.treesitter.start)
	end,
})

vim.cmd [[colorscheme catppuccin-latte]]
