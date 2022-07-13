function vimrc#lightline#setup()
  if !exists('g:lightline')
    let g:lightline = {}
  endif
  let g:lightline['component_function'] = {
        \ 'gitbranch': 'vimrc#lightline#gitbranch',
        \ 'gitreponame': 'vimrc#lightline#gitreponame',
        \ 'fileformat': 'vimrc#lightline#fileformat',
        \ 'fileencoding': 'vimrc#lightline#fileencoding',
        \ 'filetype': 'vimrc#lightline#filetype',
        \ }
  let g:lightline['active'] = {
        \ 'left':  [
          \ [ 'mode', 'paste' ],
          \ [ 'readonly', 'filename', 'modified' ] ],
        \ 'right': [
          \ [ 'lineinfo' ],
          \ [ 'percent' ], 
          \ [ 'fileformat', 'fileencoding', 'filetype' ] ],
        \ }
  let g:lightline['inactive'] = {
        \ 'left': [
          \ [ 'filename' ] ],
        \ 'right': [
          \ [ 'lineinfo' ],
          \ [ 'percent' ] ],
        \ }
  let g:lightline['tabline'] = {
        \ 'left':  [
          \ [ 'gitreponame', 'gitbranch' ],
          \ [ 'tabs' ] ],
        \'right': [ ],
        \ }
  let g:lightline['separator'] = {
        \ 'left': '',
        \ 'right': '',
        \ }
  let g:lightline['subseparator'] = {
        \ 'left': '',
        \ 'right': '',
        \ }
endfunction

function vimrc#lightline#gitreponame()
  const repo_name = gina#component#repo#name()
  if repo_name == ''
    return 'no repo'
  else
    return repo_name
  endif
endfunction

function vimrc#lightline#gitbranch()
  const branch_name = gitbranch#name()
  if branch_name == ''
    return ''
  else
    return ' ' . branch_name
  endif
endfunction

function vimrc#lightline#fileencoding()
  if (winwidth(0) > 70)
    return (&fenc !=# '' ? &fenc : &enc)
  else
    return ''
  endif
endfunction

function vimrc#lightline#fileformat()
  const ff = &fileformat
  if (winwidth(0) > 70)
    return ' ' . nerdfont#fileformat#find(ff) . ' '
  else
    return ''
  endif
endfunction

function vimrc#lightline#filetype()
  const ft = &filetype
  if ft == ''
    return ''
  else
    return ft . ' ' . nerdfont#find(expand('%:t'))
  endif
endfunction
