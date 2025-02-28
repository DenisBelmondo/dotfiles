local lua_snip = nil

local function set_vim_options()
	local function set_numbers()
		-- enable numbers in netrw
		vim.api.nvim_create_autocmd('FileType', {
			pattern = 'netrw',
			callback = set_numbers,
		})

		vim.opt.number = true
		vim.opt.relativenumber = true
	end

	set_numbers()
	vim.opt.tabstop = 4
	vim.opt.shiftwidth = 4
	vim.opt.wrap = false

	-- so lsp doesn't shift the whole buffer to the right when there's an error
	vim.opt.signcolumn = 'yes'

	vim.opt.cursorline = true
	vim.opt.guifont = 'Cascadia Code:h8'
	vim.opt.mouse = ''
	vim.opt.hlsearch = false
	vim.opt.ignorecase = true

	vim.diagnostic.config {
		signs = true,
		-- don't show diagnostics to the right of lines
		virtual_text = false,
	}

	vim.cmd([[colorscheme gruvbox]])
end

local function install_lazy_nvim()
	local lazypath = vim.fn.stdpath('data') .. '/lazy/lazy.nvim'

	if not (vim.uv or vim.loop).fs_stat(lazypath) then
		local lazyrepo = 'https://github.com/folke/lazy.nvim.git'
		local out = vim.fn.system({ 'git', 'clone', '--filter=blob:none', '--branch=stable', lazyrepo, lazypath })

		if vim.v.shell_error ~= 0 then
			vim.api.nvim_echo(
				{
					{ 'Failed to clone lazy.nvim:\n', 'ErrorMsg' },
					{ out,                            'WarningMsg' },
					{ '\nPress any key to exit...' },
				},
				true,
				{}
			)

			vim.fn.getchar()
			os.exit(1)
		end
	end

	vim.opt.rtp:prepend(lazypath)

	-- Make sure to setup `mapleader` and `maplocalleader` before
	-- loading lazy.nvim so that mappings are correct.
	vim.g.mapleader = '\\'
	vim.g.maplocalleader = ' '
end

local function set_up_lazy_plugin_specs()
	require('lazy').setup {
		spec = {
			{
				'NMAC427/guess-indent.nvim',
			},
			{
				'lukas-reineke/indent-blankline.nvim',
				main = 'ibl',
			},
			{
				'windwp/nvim-autopairs',
				event = 'InsertEnter',
				config = true,
			},
			{
				'nvim-treesitter/nvim-treesitter',
				build = ':TSUpdate',
				config = function()
					local configs = require('nvim-treesitter.configs')

					configs.setup {
						highlight = { enable = true },
						indent = { enable = true },
					}
				end
			},
			{
				'lewis6991/gitsigns.nvim',
			},
			{
				'neovim/nvim-lspconfig',
			},
			{
				'williamboman/mason.nvim',
			},
			{
				'williamboman/mason-lspconfig.nvim',
			},
			{
				'hrsh7th/cmp-nvim-lsp',
			},
			{
				'hrsh7th/cmp-buffer',
			},
			{
				'hrsh7th/cmp-path',
			},
			{
				'hrsh7th/cmp-cmdline',
			},
			{
				'hrsh7th/nvim-cmp',
				version = false,
				dependencies = {
					'hrsh7th/cmp-nvim-lsp',
					'hrsh7th/cmp-buffer',
					'hrsh7th/cmp-path',
				},
			},
			{
				'L3MON4D3/LuaSnip',
				version = 'v2.*',
				build = 'make install_jsregexp',
			},
			{
				'saadparwaiz1/cmp_luasnip',
			},
			{
				'ellisonleao/gruvbox.nvim'
			},
			{
				'sphamba/smear-cursor.nvim',
			},
			{
				'declancm/cinnamon.nvim',
			},
			{
				'mfussenegger/nvim-jdtls',
			},
			-- {
			-- 	'Mofiqul/vscode.nvim',
			-- 	opts = {
			-- 		italic_comments = true,
			-- 		underline_links = true,
			-- 	},
			-- },
			{
				'ibhagwan/fzf-lua',
			}
		},
		-- Configure any other settings here. See the documentation for more details.
		-- colorscheme that will be used when installing plugins.
		-- install = { colorscheme = { 'habamax' } },
		-- automatically check for plugin updates
		checker = { enabled = true },
	}
end

local function set_up_the_newly_installed_plugins()
	require('guess-indent').setup {}
	require('ibl').setup()
	require('gitsigns').setup()
	require('mason').setup()
	require('gruvbox').setup {
		contrast = 'high',
		transparent_mode = true,
	}
	require('smear_cursor').setup()
	require('cinnamon').setup {
		keymaps = {
			basic = true,
			extra = true,
		},

		options = { mode = 'window' },
	}
end

local function hook_up_cmp_with_snippets()
	local cmp = require 'cmp'

	lua_snip = require 'luasnip'

	cmp.setup {
		snippet = {
			expand = function(args)
				lua_snip.lsp_expand(args.body)
			end,
		},
		mapping = cmp.mapping.preset.insert {
			['<C-Space>'] = cmp.mapping.complete(),
			['<CR>'] = cmp.mapping.confirm { select = true },
		},
		sources = cmp.config.sources(
			{
				{ name = 'nvim_lsp' },
				{ name = 'luasnip' },
			},
			{
				{ name = 'buffer' },
			}),
	}

	cmp.setup.cmdline({ '/', '?' }, {
		mapping = cmp.mapping.preset.cmdline(),
		sources = {
			{ name = 'buffer' },
		},
	})

	cmp.setup.cmdline(':', {
		mapping = cmp.mapping.preset.cmdline(),
		sources = cmp.config.sources(
			{
				{ name = 'path' }
			},
			{
				{ name = 'cmdline' },
			}),
		matching = { disallow_symbol_nonprefix_matching = false },
	})
end

local function set_up_lsp_capabilities()
	local capabilities = require('cmp_nvim_lsp').default_capabilities()
	local lspconfig = require 'lspconfig'

	local lsp_identifiers = {
		'bashls',
		'clangd',
		'emmet_language_server',
		'gdscript',
		'jdtls',
		'jedi_language_server',
		'jsonls',
		'lua_ls',
		'ts_ls',
	}

	for _, k in pairs(lsp_identifiers) do
		local args = {
			capabilities = capabilities,
		}

		-- if k == 'clangd' then
		-- 	args.on_init = function (client, _)
		-- 		client.server_capabilities.semanticTokensProvider = nil
		-- 	end
		-- end

		lspconfig[k].setup(args)
	end
end

local function set_up_keymaps()
	local my_keymaps = {
		{
			{ 'i' },
			'<C-S-Space>',
			function()
				vim.lsp.buf.signature_help()
			end,
			nil,
		},
		{
			{ 'i', 'n' },
			'<F2>',
			function()
				vim.lsp.buf.rename()
			end,
			nil,
		},
		{
			{ 'v', 'i', 'n' },
			'<leader>d',
			function()
				vim.diagnostic.open_float()
			end,
			nil,
		},
		{
			{ 'v', 'i', 'n' },
			'<leader>g',
			function()
				vim.lsp.buf.definition()
			end,
			nil,
		},
		{
			{ 'v', 'i', 'n' },
			'<leader>h',
			function()
				vim.lsp.buf.hover()
			end,
			nil,
		},
		{
			{ 'i', 's' },
			'<C-L>',
			function()
				lua_snip.jump(1)
			end,
			{ silent = true },
		},
		{
			{ 'i', 's' },
			'<C-Right>',
			function()
				lua_snip.jump(1)
			end,
			{ silent = true },
		},
		{
			{ 's' },
			'<Tab>',
			function()
				lua_snip.jump(1)
			end,
			{ silent = true },
		},
		{
			{ 'i', 's' },
			'<C-H>',
			function()
				lua_snip.jump(-1)
			end,
			{ silent = true },
		},
		{
			{ 'i', 's' },
			'<C-Left>',
			function()
				lua_snip.jump(-1)
			end,
			{ silent = true },
		},
		{
			{ 'v', 'i', 'n', 's' },
			'<C-.>',
			function ()
				vim.lsp.buf.code_action()
			end,
			{ silent = true },
		},
	}

	for _, t in pairs(my_keymaps) do
		vim.keymap.set(unpack(t))
	end
end

install_lazy_nvim()
set_up_lazy_plugin_specs()
set_up_the_newly_installed_plugins()
hook_up_cmp_with_snippets()
set_up_lsp_capabilities()
set_vim_options()
set_up_keymaps()
