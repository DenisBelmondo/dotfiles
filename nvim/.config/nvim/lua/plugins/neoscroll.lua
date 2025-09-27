vim.pack.add { 'https://github.com/karb94/neoscroll.nvim.git' }

require 'neoscroll' .setup {
	duration_multiplier = 0.5,
	easing = 'quadratic';
}
