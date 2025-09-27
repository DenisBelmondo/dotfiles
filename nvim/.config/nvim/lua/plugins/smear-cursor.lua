vim.pack.add { 'https://github.com/sphamba/smear-cursor.nvim.git' }

if not vim.g.neovide then
	require 'smear_cursor' .enabled = true
end
