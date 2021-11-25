require 'nvim-treesitter.configs'.setup {
	ensure_installed = { 'vim','toml' },
	indent = { enable = true },
	incremental_selection = { enable = true },
	highlight = { enable = true }
}
