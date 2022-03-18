if &compatible
    set nocompatible
endif

augroup MyAutoCmd
	autocmd!
augroup END

let mapleader="\<Space>"

" list of {'name', 'background'}
let g:colorschemes = []

function init#set_random_colorschme()
    let l:count_of_colorschemes = len(g:colorschemes)
    if l:count_of_colorschemes == 0
        return
    endif

    let l:choosed = localtime() % l:count_of_colorschemes

    execute 'colorscheme ' . g:colorschemes[l:choosed].name
    execute 'set background=' . g:colorschemes[l:choosed].background
endfunction

function init#load_project_local_settings()
    let l:opened_dir = getcwd()
    let l:local_config_dir = l:opened_dir . '/.vim'
    let l:local_config_file = l:local_config_dir . '/settings.vim'
    if !isdirectory(l:local_config_dir) || (glob(l:local_config_file) == '')
        return
    endif
    execute 'source ' . l:opened_dir . '/.vim/settings.vim'
endfunction

autocmd MyAutoCmd VimEnter * call init#load_project_local_settings()

" dein setup
if has('nvim') && has('win64')
    let s:cache_home = expand($LOCALAPPDATA . '/nvim-data')
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

let g:dein#lazy_rplugins = v:true
let g:dein#install_progress_type = 'tabline'
let g:dein#install_check_diff = v:true
let g:dein#enable_notification = v:true

let b:use_ddc = v:true

let s:path = s:cache_home . '/dein'
if dein#load_state(s:path)
    let s:base_dir = fnamemodify(expand('<sfile>'), ':h') . '/deinrc/'

    let s:nolazy_toml   = s:base_dir . 'nolazy.toml'
    let s:lazy_toml     = s:base_dir . 'lazy.toml'
    let s:nvim_lsp_toml = s:base_dir . 'nvim-lsp.toml'
    let s:ddc_toml      = s:base_dir . 'ddc.toml'
    let s:porn_toml     = s:base_dir . 'porn.toml'
    let s:ddu_toml      = s:base_dir . 'ddu.toml'

    call dein#begin(s:path, [
                \ expand('<sfile>'), s:nolazy_toml, s:lazy_toml
                \ ])

    call dein#load_toml(s:nolazy_toml,      {'lazy': 0})
    call dein#load_toml(s:lazy_toml,        {'lazy': 1})
    call dein#load_toml(s:porn_toml,        {'lazy': 0})
    call dein#load_toml(s:ddu_toml,         {'lazy': 1})
    call dein#load_toml(s:nvim_lsp_toml,    {'lazy': 1})
    call dein#load_toml(s:ddc_toml,         {'lazy': 1})

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
set hlsearch
if has('nvim')
    set inccommand=split
endif

" indent
set tabstop=4
set shiftwidth=4
set softtabstop=0
set expandtab

set autoindent
set smartindent
set smarttab
set shiftround

set hidden
set noswapfile
set nowrap

if has('win32')
    if executable('pwsh')
        let s:interactive_shell = 'pwsh'
    elseif executable('powershell')
        let s:interactive_shell = 'powershell'
    endif
elseif has('unix')
    if executable('fish')
        let s:interactive_shell = 'fish'
    elseif executable('bash')
        let s:interactive_shell = 'bash'
    endif
endif

" :TermOpen to open terminal
if exists('s:interactive_shell')
    execute 'command TermOpen terminal ' . s:interactive_shell
    execute 'command HTermOpen split | wincmd j | terminal ' . s:interactive_shell
    execute 'command VTermOpen vsplit | wincmd l | terminal ' . s:interactive_shell
endif

set number
set cursorline

set termguicolors

let g:netrw_liststyle=3
let g:netrw_banner=0
let g:netrw_sizestyle="H"
let g:netrw_timefmt="%Y/%m/%d(%a) %H:%M:%S"
let g:netrw_preview=1

filetype plugin indent on
syntax enable

cabbrev vh vert bo h
nnoremap <C-d> :q<CR>

" around clipboard
vmap <Leader>y "+y
nmap <Leader>p "+p
nmap <Leader>P "+P
vmap <Leader>p "+p
vmap <Leader>P "+P

nnoremap j gj
nnoremap k gk
nnoremap j gj
nnoremap k gk

" escape from terminal insert mode
tnoremap <silent><Esc> <C-\><C-n>
