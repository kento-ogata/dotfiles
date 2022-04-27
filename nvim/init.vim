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
  const l:count_of_colorschemes = len(g:colorschemes)
  if l:count_of_colorschemes == 0
    return
  endif

  const l:choosed = rand(srand()) % l:count_of_colorschemes

  execute 'colorscheme ' . g:colorschemes[l:choosed].name
  if has_key(g:colorschemes[l:choosed], 'background')
    execute 'set background=' . g:colorschemes[l:choosed].background
  endif
endfunction

" dein setup
if has('nvim') && has('win64')
  const s:cache_home = $TEMP
else
  const s:cache_home = empty($XDG_CACHE_HOME) ? expand('~/.cache') : $XDG_CACHE_HOME
endif

" Load dein
if &runtimepath !~# '/dein.vim'
  const s:dein_dir = s:cache_home . '/dein/repos/github.com/Shougo/dein.vim'
  if !isdirectory(s:dein_dir)
    execute '!git clone https://github.com/Shougo/dein.vim.git ' s:dein_dir
  endif
  execute 'set runtimepath^=' . substitute(
        \ fnamemodify(s:dein_dir, ':p') , '[/\\]$', '', '')
endif

let g:dein#lazy_rplugins = v:true
let g:dein#install_progress_type = 'floating'
let g:dein#install_check_diff = v:true
let g:dein#enable_notification = v:true

const b:use_ddc = v:true

const s:path = s:cache_home . '/dein'
if dein#load_state(s:path)
  const s:base_dir = fnamemodify(expand('<sfile>'), ':h') . '/deinrc/'

  const s:nolazy_toml   = s:base_dir . 'nolazy.toml'
  const s:lazy_toml     = s:base_dir . 'lazy.toml'
  const s:nvim_lsp_toml = s:base_dir . 'nvim-lsp.toml'
  const s:ddc_toml      = s:base_dir . 'ddc.toml'
  const s:porn_toml     = s:base_dir . 'porn.toml'
  const s:ddu_toml      = s:base_dir . 'ddu.toml'

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
    const s:interactive_shell = 'pwsh'
  elseif executable('powershell')
    const s:interactive_shell = 'powershell'
  endif
elseif has('unix')
  if executable('fish')
    const s:interactive_shell = 'fish'
  elseif executable('bash')
    const s:interactive_shell = 'bash'
  endif
endif

" :TermOpen to open terminal
if exists('s:interactive_shell')
  execute 'command  TermOpen                     terminal ' . s:interactive_shell
  execute 'command HTermOpen  split | wincmd j | terminal ' . s:interactive_shell
  execute 'command VTermOpen vsplit | wincmd l | terminal ' . s:interactive_shell
endif

set number
set relativenumber
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

inoremap <C-v>u <C-r>=nr2char(0x)<Left>

set secure
