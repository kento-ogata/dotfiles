require 'nvim-treesitter.configs'.setup {
	ensure_installed = { 'vim','toml','c','cpp','c_sharp' },
	indent = { enable = true },
	incremental_selection = { enable = true },
	highlight = { enable = true }
}
