function vimrc#dein#setup()
  if exists('g:vimrc#dein#loaded')
    finish
  endif
  let g:vimrc#dein#loaded = v:true

  if has('win64')
    const s:cache_home = expand($LOCALAPPDATA) . '\nvim-data'
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

  let g:vimrc#dein#use_ddc = v:true
  let g:vimrc#dein#use_cmp = !g:vimrc#dein#use_ddc

  let g:dein#lazy_rplugins = v:true
  let g:dein#install_progress_type = 'floating'
  let g:dein#install_check_diff = v:true
  let g:dein#enable_notification = v:true

  const s:path = s:cache_home . '/dein'
  if dein#load_state(s:path)
    const s:base_dir = fnamemodify(expand($MYVIMRC), ':h') . '/deinrc/'
    "execute printf('echomsg "%s"', s:base_dir)

    const s:ft_toml       = s:base_dir . 'ft.dein.toml'
    const s:lib_toml      = s:base_dir . 'lib.dein.toml'
    const s:nolazy_toml   = s:base_dir . 'nolazy.dein.toml'
    const s:lazy_toml     = s:base_dir . 'lazy.dein.toml'
    const s:nvim_lsp_toml = s:base_dir . 'nvim-lsp.dein.toml'
    const s:ddc_toml      = s:base_dir . 'ddc.dein.toml'
    const s:nvim_cmp_toml = s:base_dir . 'nvim-cmp.dein.toml'
    const s:porn_toml     = s:base_dir . 'porn.dein.toml'
    const s:ddu_toml      = s:base_dir . 'ddu.dein.toml'
    const s:fern_toml     = s:base_dir . 'fern.dein.toml'
    const s:git_toml      = s:base_dir . 'git.dein.toml'

    call dein#begin(s:path, [
          \ $MYVIMRC, s:lib_toml, s:nolazy_toml, s:lazy_toml, s:nvim_lsp_toml, s:ddc_toml,
          \ s:ddu_toml, s:porn_toml, s:fern_toml, s:git_toml, s:nvim_cmp_toml, s:ft_toml
          \ ])

    call dein#load_toml(s:ft_toml,          {'lazy': 0})
    call dein#load_toml(s:lib_toml,         {'lazy': 1})
    call dein#load_toml(s:nolazy_toml,      {'lazy': 0})
    call dein#load_toml(s:lazy_toml,        {'lazy': 1})
    call dein#load_toml(s:porn_toml,        {'lazy': 0})
    call dein#load_toml(s:ddu_toml,         {'lazy': 1})
    call dein#load_toml(s:nvim_lsp_toml,    {'lazy': 1, 'if': 'has("nvim")'})
    call dein#load_toml(s:ddc_toml,         {'lazy': 1})
    call dein#load_toml(s:nvim_cmp_toml,    {'lazy': 1, 'if': 'has("nvim")'})
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
