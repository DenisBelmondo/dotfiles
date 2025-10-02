vim.opt.clipboard:append { 'unnamed', 'unnamedplus', }
vim.opt.colorcolumn = '80,120'
vim.opt.cursorline = true
vim.opt.guifont = 'Maple Mono:h12'
vim.opt.hlsearch = false
vim.opt.ignorecase = true
vim.opt.linespace = 24
vim.opt.mouse = ''
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.shiftwidth = 4
vim.opt.signcolumn = 'yes'
vim.opt.tabstop = 4
vim.opt.wrap = false

-- deps
require 'plugins.plenary'
require 'plugins.telescope-fzf-native'

require 'plugins.autopairs'
require 'plugins.blink-cmp'
require 'plugins.guess-indent'
require 'plugins.indent-blankline'
require 'plugins.lspconfig'
require 'plugins.neoscroll'
require 'plugins.rainbow-delimiters'
require 'plugins.smear-cursor'
require 'plugins.sonokai'
require 'plugins.telescope'
require 'plugins.tree-sitter'

vim.cmd [[filetype plugin indent on]]
vim.cmd [[autocmd FileType * set formatoptions-=cro]]
