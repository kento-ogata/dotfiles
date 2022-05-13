function vimrc#setup_dein()
  if has('win64')
    " Neovim's expand() function cannot expand MS-Windows's path like 'C:\Users\USER_~1\AppData\Local\Temp' to 'C:\Users\user_name\AppData\Local\Temp'
    const s:cache_home = has('nvim') ? ($LOCALAPPDATA . '\Temp') : expand($TEMP)
  else
    const s:cache_home = empty($XDG_CACHE_HOME) ? expand('~/.cache') : $XDG_CACHE_HOME
  endif

  " Load dein
  if &runtimepath !~# '/dein.vim'
    const s:dein_dir = s:cache_home . '/dein/repos/github.com/Shougo/dein.vim'
    if !isdirectory(s:dein_dir)
      execute printf('!git clone https://github.com/Shougo/dein.vim.git %s', s:dein_dir)
    endif
    execute printf('set runtimepath^=%s', substitute(fnamemodify(s:dein_dir, ':p') , '[/\\]$', '', ''))
  endif

  let g:dein#lazy_rplugins = v:true
  let g:dein#install_progress_type = 'floating'
  let g:dein#install_check_diff = v:true
  let g:dein#enable_notification = v:true

  const s:path = s:cache_home . '/dein'
  if dein#load_state(s:path)
    const s:base_dir = fnamemodify(expand($MYVIMRC), ':h') . '/deinrc/'
    "execute printf('echomsg "%s"', s:base_dir)

    const s:nolazy_toml   = s:base_dir . 'nolazy.toml'
    const s:lazy_toml     = s:base_dir . 'lazy.toml'
    const s:nvim_lsp_toml = s:base_dir . 'nvim-lsp.toml'
    const s:ddc_toml      = s:base_dir . 'ddc.toml'
    const s:porn_toml     = s:base_dir . 'porn.toml'
    const s:ddu_toml      = s:base_dir . 'ddu.toml'
    const s:fern_toml     = s:base_dir . 'fern.toml'
    const s:git_toml      = s:base_dir . 'git.toml'

    call dein#begin(s:path, [
          \ $MYVIMRC, s:nolazy_toml, s:lazy_toml, s:nvim_lsp_toml, s:ddc_toml,
          \ s:ddu_toml, s:porn_toml, s:fern_toml, s:git_toml
          \ ])

    call dein#load_toml(s:nolazy_toml,      {'lazy': 0})
    call dein#load_toml(s:lazy_toml,        {'lazy': 1})
    call dein#load_toml(s:porn_toml,        {'lazy': 0})
    call dein#load_toml(s:ddu_toml,         {'lazy': 1})
    call dein#load_toml(s:nvim_lsp_toml,    {'lazy': 1, 'if': 'has("nvim")'})
    call dein#load_toml(s:ddc_toml,         {'lazy': 1})
    call dein#load_toml(s:fern_toml,        {'lazy': 1})
    call dein#load_toml(s:git_toml,         {'lazy': 1})

    call dein#end()
    call dein#save_state()
  endif

  if dein#check_install()
    call dein#install()
  endif

  filetype plugin indent on
  syntax enable
endfunction
