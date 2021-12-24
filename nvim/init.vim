" dein setup
if has('win64')
	let s:cache_home = expand('~\AppData\Local\nvim-data')
else
	let s:cache_home = empty($XDG_CACHE_HOME) ? expand('~/.cache') : $XDG_CACHE_HOME
endif

let g:config_dir = expand('<sfile>:p:h')

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

	let g:rc_dir	= g:config_dir . '/dein'
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

" search settings
set ignorecase
set smartcase
set wrapscan
set incsearch
set hlsearch
set inccommand=split
nnoremap <Esc><Esc> :nohlsearch<CR>

" indent
set tabstop=8
set shiftwidth=8
set softtabstop=0

set autoindent
set smartindent
set smarttab
set shiftround

execute 'source ' . g:config_dir . '/key-map.vim'

" help split change
cabbrev help vertical botright help
cabbrev h vert bo h

set hidden

if has('win64')
	set shell=pwsh
endif

" :T to open terminal in new split
command! -nargs=* T split | wincmd j | terminal <args>

set number

au ColorScheme * hi Normal ctermbg=none
au ColorScheme * hi MatchParen cterm=bold ctermfg=214 ctermbg=black
au ColorScheme * hi SpellBad ctermfg=23 cterm=none ctermbg=none

set background=dark
colorscheme iceberg

let g:netrw_liststyle=1
let g:netrw_banner=0
let g:netrw_sizestyle="H"
let g:netrw_timefmt="%Y/%m/%d(%a) %H:%M:%S"
let g:netrw_preview=1
