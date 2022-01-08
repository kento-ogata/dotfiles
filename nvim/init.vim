if &compatible
    set nocompatible
endif

execute 'source' . fnamemodify(expand('<sfile>'), ':h') . '/key-map.vim'

" dein setup
if has('win64')
    let s:cache_home = expand('~\AppData\Local\nvim-data')
else
    let s:cache_home = empty($XDG_CACHE_HOME) ? expand('~/.cache') : $XDG_CACHE_HOME
endif

" Load dein
if &runtimepath !~# '/dein.vim'
    let s:dein_dir = fnamemodify('dein.vim', ':p')
    if !isdirectory(s:dein_dir)
        let s:dein_dir = s:cache_home . '/dein/repos/github.com/Shougo/dein.vim'
        if !isdirectory(s:dein_dir)
            execute '!git clone https://github.com/Shougo/dein.vim.git ' s:dein_dir
        endif
    endif
    execute 'set runtimepath^=' . substitute(
                \ fnamemodify(s:dein_dir, ':p') , '[/\\]$', '', '')
endif

" -------------------------------------------------------------------------------
"  dein configurations.

" In Windows, auto_recache works too slow. So it is disabled.
let g:dein#auto_recache = !has('win64')

let g:dein#lazy_rplugins = v:true
let g:dein#install_progress_type = 'title'
let g:dein#install_check_diff = v:true
let g:dein#enable_notification = v:true

let s:path = s:cache_home . '/dein'
if dein#load_state(s:path)
    let s:base_dir = fnamemodify(expand('<sfile>'), ':h') . '/'

    let s:dein_toml         = s:base_dir . 'dein.toml'
    let s:dein_lazy_toml    = s:base_dir . 'deinlazy.toml'
    let s:dein_ddc_toml     = s:base_dir . 'ddc.toml'

    call dein#begin(s:path, [
                \ expand('<sfile>'), s:dein_toml, s:dein_lazy_toml
                \ ])

    call dein#load_toml(s:dein_toml,         {'lazy': 0})
    call dein#load_toml(s:dein_lazy_toml,    {'lazy': 1})
    call dein#load_toml(s:dein_ddc_toml,     {'lazy': 0})

    call dein#end()
    call dein#save_state()
endif

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
set tabstop=4
set shiftwidth=4
set softtabstop=0
set expandtab

set autoindent
set smartindent
set smarttab
set shiftround

set helplang=ja,en

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
set cursorline

au ColorScheme * hi Normal ctermbg=none
au ColorScheme * hi MatchParen cterm=bold ctermfg=214 ctermbg=black
au ColorScheme * hi SpellBad ctermfg=23 cterm=none ctermbg=none

set termguicolors

set background=dark
colorscheme hybrid

let g:netrw_liststyle=3
let g:netrw_banner=0
let g:netrw_sizestyle="H"
let g:netrw_timefmt="%Y/%m/%d(%a) %H:%M:%S"
let g:netrw_preview=1

filetype plugin indent on
syntax enable
