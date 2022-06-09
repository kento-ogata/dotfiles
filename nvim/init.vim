if &compatible
  set nocompatible
endif

let mapleader="\<Space>"
" use ; to a prefix of open finder action
nnoremap ; <Nop>

" list of {'name', 'background', 'lightline'}
let g:colorschemes = []

" cs_params: { 'name': string, 'background': string, 'lightline': string }
function init#pick_random_colorscheme(cs_params)
    const l:count_of_colorschemes = len(a:cs_params)
    if l:count_of_colorschemes == 0
      return
    endif
  
    const l:choosed = rand(srand()) % l:count_of_colorschemes
    return a:cs_params[l:choosed]
endfunction

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

call vimrc#dein#setup()

" search settings
set ignorecase
set smartcase
set wrapscan
set hlsearch

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
  execute 'command  Shell                     terminal ' . s:interactive_shell
  execute 'command HShell  split | wincmd j | terminal ' . s:interactive_shell
  execute 'command VShell vsplit | wincmd l | terminal ' . s:interactive_shell
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

cabbrev vh vert bo h

" around clipboard
vmap <Leader>y "+y
nmap <Leader>p "+p
nmap <Leader>P "+P
vmap <Leader>p "+p
vmap <Leader>P "+P

nnoremap <silent> j gj
nnoremap <silent> k gk
nnoremap <silent> j gj
nnoremap <silent> k gk

" escape from terminal insert mode
tnoremap <silent><Esc> <C-\><C-n>

inoremap <C-v>u <C-r>=nr2char(0x)<Left>

set laststatus=2
set showtabline=2

set secure

command UnixEnc e ++enc=utf-8 ++ff=unix
command DosEnc e ++enc=cp932 ++ff=dos

if has('nvim')
  set inccommand=split

  function s:map_nvim_lsp_actions()
    nmap <buffer><silent> gD          <Cmd>lua vim.lsp.buf.declaration()<CR>
    nmap <buffer><silent> gd          <Cmd>lua vim.lsp.buf.definition()<CR>
    nmap <buffer><silent> gi          <Cmd>lua vim.lsp.buf.implementation()<CR>
    imap <buffer><silent> <C-k>       <Cmd>lua vim.lsp.buf.signature_help()<CR>
    nmap <buffer><silent> <Leader>wa  <Cmd>lua vim.lsp.buf.add_workspace_folder()<CR>
    nmap <buffer><silent> <Leader>wr  <Cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>
    nmap <buffer><silent> <Leader>wl  <Cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folder()))<CR>
    nmap <buffer><silent> <Leader>D   <Cmd>lua vim.lsp.buf.type_definition()<CR>
    nmap <buffer><silent> <Leader>q   <Cmd>lua vim.lsp.diagnostic.set_loclist()<CR>
    nmap <buffer><silent> <Leader>f   <Cmd>lua vim.lsp.buf.format{ async = true }<CR>
  endfunction

  augroup NvimLspRc
    autocmd!
    autocmd LspAttach * call <SID>map_nvim_lsp_actions()
  augroup END
endif

" automatically indent on empty rows
nmap <expr> i (len(getline('.')) !=# 0) ? 'i' : '"_cc'
nmap <expr> A (len(getline('.')) !=# 0) ? 'A' : '"_cc'
