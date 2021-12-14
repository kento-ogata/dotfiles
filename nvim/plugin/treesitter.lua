require 'nvim-treesitter.configs'.setup {
	ensure_installed = { 'vim','toml','c','cpp','c_sharp' },
	incremental_selection = { enable = true },
	highlight = { enable = true }
}
