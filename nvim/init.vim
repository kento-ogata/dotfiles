" dein setup
if has('win64')
	let s:cache_home = expand('~\AppData\Local\nvim-data')
	let s:config_home = expand('~\AppData\Local\')
else
	let s:cache_home = empty($XDG_CACHE_HOME) ? expand('~/.cache') : $XDG_CACHE_HOME
	let s:config_home = empty($XDG_CONFIG_HOME) ? expand('~/.config/') : $XDG_CONFIG_HOME
endif
let s:config_dir = s:config_home . '/nvim'

let s:dein_dir = s:cache_home . '/dein'
let s:dein_repo_dir = s:dein_dir . '/repos/github.com/Shougo/dein.vim'

if &compatible
	set nocompatible
endif

if &runtimepath !~# '/dein.vim'
	if !isdirectory(s:dein_repo_dir)
		execute '!git clone https://github.com/Shougo/dein.vim' s:dein_repo_dir
	endif

	execute 'set runtimepath+=' . s:dein_repo_dir
endif

if dein#load_state(s:dein_dir)
	call dein#begin(s:dein_dir)

	let g:rc_dir	= s:config_dir . '/dein'
	let s:toml	= g:rc_dir . '/dein.toml'
	let s:lazy_toml	= g:rc_dir . '/dein_lazy.toml'

	call dein#load_toml(s:toml,	{'lazy': 0})
	call dein#load_toml(s:lazy_toml, {'lazy': 1})

	call dein#end()
	call dein#save_state()
endif

filetype plugin indent on
syntax enable

if dein#check_install()
	call dein#install()
endif

let mapleader="\<Space>"

nnoremap <C-d> :q<CR>

" search settings
set ignorecase
set smartcase
set wrapscan
set incsearch
set hlsearch
set inccommand=split
nnoremap <Esc><Esc> :nohlsearch<CR>

" indent
set tabstop=4
set shiftwidth=4
set softtabstop=0

set autoindent
set smartindent
set smarttab
set shiftround

" around clipboard
vmap <Leader>y "+y
nmap <Leader>p "+p
nmap <Leader>P "+P
vmap <Leader>p "+p
vmap <Leader>P "+P

" move windows
nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l

nnoremap j gj
nnoremap k gk
nnoremap j gj
nnoremap k gk

" help split change
cnoremap help vertical botright help
cabbrev h vert bo h

" escape from terminal insert mode
tnoremap <silent><Esc> <C-\><C-n>

set hidden

if has('win64')
	set shell=pwsh
endif

" :T to open terminal in new split
command! -nargs=* T split | wincmd j | terminal <args>

set number

nnoremap <C-n> :NERDTree<CR>
