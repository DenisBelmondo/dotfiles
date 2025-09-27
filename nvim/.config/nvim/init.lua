vim.o.clipboard = 'unnamedplus'
vim.o.colorcolumn = '80,120'
vim.o.guifont = 'Maple Mono:h12'
vim.o.hlsearch = false
vim.o.ignorecase = true
vim.o.number = true
vim.o.relativenumber = true
vim.o.shiftwidth = 4
vim.o.signcolumn = 'yes'
vim.o.tabstop = 4
vim.o.wrap = false

require 'plugins.lspconfig'
require 'plugins.autopairs'
require 'plugins.blink-cmp'
require 'plugins.guess-indent'
require 'plugins.indent-blankline'
require 'plugins.neoscroll'
require 'plugins.rainbow-delimiters'
require 'plugins.smear-cursor'
require 'plugins.sonokai'
require 'plugins.tree-sitter'

vim.cmd [[filetype plugin indent on]]
vim.cmd [[autocmd FileType * set formatoptions-=cro]]
