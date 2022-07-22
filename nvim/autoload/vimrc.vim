function vimrc#toggleMouseOption()
  const currentMouseOption = &mouse
  if currentMouseOption ==# ''
    set mouse=nvi
  else
    set mouse=
  endif
endfunction

function vimrc#set_maps()
  " use ; to a prefix of open finder action
  nnoremap ; <Nop>
  
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
  
  " automatically indent on empty rows
  nmap <expr> i (len(getline('.')) !=# 0) ? 'i' : '"_cc'
  nmap <expr> a (len(getline('.')) !=# 0) ? 'a' : '"_cc'

  nmap ,, <Cmd>call vimrc#toggleMouseOption()<CR>
endfunction

function vimrc#set_options()
  set nocompatible
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

  set number
  set relativenumber
  set cursorline

  set termguicolors

  set laststatus=2
  set showtabline=2

  set mouse=
  set secure
  
  if has('nvim')
    set inccommand=split
  else
    call vimrc#defaults_vim()
  endif
endfunction

function vimrc#set_nvimlsp()
  autocmd NvimLspRc LspAttach * echo printf('LS is now attached to the buffer %s', expand('<amatch>'))

  function s:map_nvim_lsp_actions()
    nmap <buffer><silent> gD            <Cmd>lua vim.lsp.buf.declaration()<CR>
    nmap <buffer><silent> gd            <Cmd>lua vim.lsp.buf.definition()<CR>
    nmap <buffer><silent> gi            <Cmd>lua vim.lsp.buf.implementation()<CR>
    nmap <buffer><silent> <Leader>wa    <Cmd>lua vim.lsp.buf.add_workspace_folder()<CR>
    nmap <buffer><silent> <Leader>wr    <Cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>
    nmap <buffer><silent> <Leader>wl    <Cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folder()))<CR>
    nmap <buffer><silent> <Leader>D     <Cmd>lua vim.lsp.buf.type_definition()<CR>
    nmap <buffer><silent> <Leader>q     <Cmd>lua vim.lsp.diagnostic.set_loclist()<CR>
    nmap <buffer><silent> <Leader>f     <Cmd>lua vim.lsp.buf.format{ async = true }<CR>
    if &ft !=# 'vim'
      nmap <nowait><buffer><silent> K <Cmd>lua vim.lsp.buf.hover()<CR>
    endif
    nmap <buffer><silent> <Leader>h     <Cmd>lua vim.lsp.buf.signature_help()<CR>
    nmap <buffer><silent> <Leader><CR>  <Cmd>lua vim.lsp.buf.code_action()<CR>
    nmap <buffer><silent> ]d            <Cmd>lua vim.diagnostic.goto_next()<CR>
    nmap <buffer><silent> [d            <Cmd>lua vim.diagnostic.goto_prev()<CR>
  endfunction
  
  lua vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, { border = "single" })
  lua vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, { border = "single" })
  
  autocmd NvimLspRc LspAttach * call <SID>map_nvim_lsp_actions()
endfunction

function vimrc#setup_dein()
  if exists('g:vimrc#dein_loaded')
    finish
  endif
  let g:vimrc#dein_loaded = v:true

  if has('win64')
    const cache_home = expand($LOCALAPPDATA) . '\nvim-data'
  else
    const cache_home = empty($XDG_CACHE_HOME) ? expand('~/.cache') : $XDG_CACHE_HOME
  endif

  const dein_cache_path = cache_home . '/dein'
  " Load dein
  if &runtimepath !~# '/dein.vim'
    const dein_dir = dein_cache_path . '/repos/github.com/Shougo/dein.vim'
    if !isdirectory(dein_dir)
      execute printf('!git clone https://github.com/Shougo/dein.vim.git %s', dein_dir)
    endif
    execute printf('set runtimepath^=%s', substitute(fnamemodify(dein_dir, ':p') , '[/\\]$', '', ''))
  endif

  const g:vimrc#use_ddc = v:false
  const g:vimrc#use_cmp = !g:vimrc#use_ddc

  let g:dein#lazy_rplugins = v:true
  let g:dein#install_progress_type = 'floating'
  let g:dein#install_check_diff = v:true
  let g:dein#enable_notification = v:true

  if dein#load_state(dein_cache_path)
    const base_dir = fnamemodify(expand($MYVIMRC), ':h') . '/deinrc/'
    "execute printf('echomsg "%s"', base_dir)

    " ../deinrc
    const ft_toml         = base_dir . 'ft.dein.toml'
    const lib_toml        = base_dir . 'lib.dein.toml'
    const nolazy_toml     = base_dir . 'nolazy.dein.toml'
    const lazy_toml       = base_dir . 'lazy.dein.toml'
    const nvim_lsp_toml   = base_dir . 'nvim-lsp.dein.toml'
    const ddc_toml        = base_dir . 'ddc.dein.toml'
    const nvim_cmp_toml   = base_dir . 'nvim-cmp.dein.toml'
    const porn_toml       = base_dir . 'porn.dein.toml'
    const ddu_toml        = base_dir . 'ddu.dein.toml'
    const fern_toml       = base_dir . 'fern.dein.toml'
    const git_toml        = base_dir . 'git.dein.toml'
    const telescope_toml  = base_dir . 'telescope.dein.toml'

    call dein#begin(dein_cache_path, [
          \ $MYVIMRC, lib_toml, nolazy_toml, lazy_toml, nvim_lsp_toml, ddc_toml,
          \ ddu_toml, porn_toml, fern_toml, git_toml, nvim_cmp_toml, ft_toml,
          \ telescope_toml,
          \ ])

    call dein#load_toml(ft_toml,          {'lazy': 0})
    call dein#load_toml(lib_toml,         {'lazy': 1})
    call dein#load_toml(nolazy_toml,      {'lazy': 0})
    call dein#load_toml(lazy_toml,        {'lazy': 1})
    call dein#load_toml(porn_toml,        {'lazy': 0})
    call dein#load_toml(ddu_toml,         {'lazy': 1})
    call dein#load_toml(nvim_lsp_toml,    {'lazy': 1, 'if': 'has("nvim")'})
    call dein#load_toml(ddc_toml,         {'lazy': 1})
    call dein#load_toml(nvim_cmp_toml,    {'lazy': 1, 'if': 'has("nvim")'})
    call dein#load_toml(fern_toml,        {'lazy': 1})
    call dein#load_toml(git_toml,         {'lazy': 1})
    call dein#load_toml(telescope_toml,   {'lazy': 1})

    call dein#end()
    call dein#save_state()
  endif

  if dein#check_install()
    call dein#install()
  endif

  filetype plugin indent on
  syntax enable
endfunction

function vimrc#setup_netrw()
  let g:netrw_liststyle=3
  let g:netrw_banner=0
  let g:netrw_sizestyle="H"
  let g:netrw_timefmt="%Y/%m/%d(%a) %H:%M:%S"
  let g:netrw_preview=1
endfunction

function vimrc#set_shellcommand()
  if has('win32')
    if executable('pwsh')
      const interactive_shell = 'pwsh'
    elseif executable('powershell')
      const interactive_shell = 'powershell'
    endif
  elseif has('unix')
    if executable('fish')
      const interactive_shell = 'fish'
    elseif executable('bash')
      const interactive_shell = 'bash'
    endif
  endif
  
  " :Shell to open terminal
  if exists('interactive_shell')
    execute printf('command  Shell                     terminal %s', interactive_shell)
    execute printf('command HShell  split | wincmd j | terminal %s', interactive_shell)
    execute printf('command VShell vsplit | wincmd l | terminal %s', interactive_shell)
  endif
endfunction

function vimrc#ddc_add_source_buffer(source_name)
  let l:current_sources = ddc#custom#get_current()['sources']
  call add(l:current_sources, a:source_name)
  call ddc#custom#patch_buffer('sources', l:current_sources)
endfunction

function vimrc#ddc_insert_source_buffer(source_name)
  let l:current_sources = ddc#custom#get_current()['sources']
  call insert(l:current_sources, a:source_name)
  call ddc#custom#patch_buffer('sources', l:current_sources)
endfunction

function vimrc#get_buffer_path()
  return expand('<afile>')
endfunction

function vimrc#defaults_vim()
  " ========== copied from defaults.vim ==========

  " Allow backspacing over everything in insert mode.
  set backspace=indent,eol,start

  set history=200		" keep 200 lines of command line history
  set ruler		" show the cursor position all the time
  set showcmd		" display incomplete commands
  set wildmenu		" display completion matches in a status line

  set ttimeout		" time out for key codes
  set ttimeoutlen=100	" wait up to 100ms after Esc for special key

  " Show @@@ in the last line if it is truncated.
  set display=truncate

  " Show a few lines of context around the cursor.  Note that this makes the
  " text scroll if you mouse-click near the start or end of the window.
  set scrolloff=5

  " Do incremental searching when it's possible to timeout.
  if has('reltime')
    set incsearch
  endif

  " Do not recognize octal numbers for Ctrl-A and Ctrl-X, most users find it
  " confusing.
  set nrformats-=octal

  " For Win32 GUI: remove 't' flag from 'guioptions': no tearoff menu entries.
  if has('win32')
    set guioptions-=t
  endif

  " Don't use Q for Ex mode, use it for formatting.  Except for Select mode.
  " Revert with ":unmap Q".
  map Q gq
  sunmap Q

  " CTRL-U in insert mode deletes a lot.  Use CTRL-G u to first break undo,
  " so that you can undo CTRL-U after inserting a line break.
  " Revert with ":iunmap <C-U>".
  inoremap <C-U> <C-G>u<C-U>

  " In many terminal emulators the mouse works just fine.  By enabling it you
  " can position the cursor, Visually select and scroll with the mouse.
  " Only xterm can grab the mouse events when using the shift key, for other
  " terminals use ":", select text and press Esc.
  if has('mouse')
    if &term =~ 'xterm'
      set mouse=a
    else
      set mouse=nvi
    endif
  endif

  " Only do this part when Vim was compiled with the +eval feature.
  if 1

    " Enable file type detection.
    " Use the default filetype settings, so that mail gets 'tw' set to 72,
    " 'cindent' is on in C files, etc.
    " Also load indent files, to automatically do language-dependent indenting.
    " Revert with ":filetype off".
    filetype plugin indent on

    " Put these in an autocmd group, so that you can revert them with:
    " ":augroup vimStartup | exe 'au!' | augroup END"
    augroup vimStartup
      au!

      " When editing a file, always jump to the last known cursor position.
      " Don't do it when the position is invalid, when inside an event handler
      " (happens when dropping a file on gvim) and for a commit message (it's
      " likely a different one than last time).
      autocmd BufReadPost *
        \ if line("'\"") >= 1 && line("'\"") <= line("$") && &ft !~# 'commit'
        \ |   exe "normal! g`\""
        \ | endif

    augroup END

    " Quite a few people accidentally type "q:" instead of ":q" and get confused
    " by the command line window.  Give a hint about how to get out.
    " If you don't like this you can put this in your vimrc:
    " ":augroup vimHints | exe 'au!' | augroup END"
    augroup vimHints
      au!
      autocmd CmdwinEnter *
      \ echohl Todo | 
      \ echo 'You discovered the command-line window! You can close it with ":q".' |
      \ echohl None
    augroup END

  endif

  " Switch syntax highlighting on when the terminal has colors or when using the
  " GUI (which always has colors).
  if &t_Co > 2 || has("gui_running")
    " Revert with ":syntax off".
    syntax on

    " I like highlighting strings inside C comments.
    " Revert with ":unlet c_comment_strings".
    let c_comment_strings=1
  endif

  " Convenient command to see the difference between the current buffer and the
  " file it was loaded from, thus the changes you made.
  " Only define it when not defined already.
  " Revert with: ":delcommand DiffOrig".
  if !exists(":DiffOrig")
    command DiffOrig vert new | set bt=nofile | r ++edit # | 0d_ | diffthis
        \ | wincmd p | diffthis
  endif

  if has('langmap') && exists('+langremap')
    " Prevent that the langmap option applies to characters that result from a
    " mapping.  If set (default), this may break plugins (but it's backward
    " compatible).
    set nolangremap
  endif
endfunction
