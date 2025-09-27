vim.pack.add { 'https://github.com/karb94/neoscroll.nvim.git' }

if not vim.g.neovide then
	require 'neoscroll' .setup {
		duration_multiplier = 0.5,
		easing = 'quadratic';
	}
end
