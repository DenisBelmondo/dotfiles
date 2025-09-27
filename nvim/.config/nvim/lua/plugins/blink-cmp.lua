vim.pack.add {
	{
		src = 'https://github.com/Saghen/blink.cmp.git',
		version = vim.version.range '1.0',
	}
}

require 'blink.cmp' .setup {
	signature = {
		enabled = true,
	},
	fuzzy = {
		implementation = 'prefer_rust',
	},
}
