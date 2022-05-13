" { 'path': 'result' }
let g:vimrc#util#path_result = {}

" If a:path is in a git repository, this function will return v:true
function vimrc#util#ingitrepo(path) abort
  if has('win32')
    echom 'vimrc#util#is_git_repo: not supported for Windows'
    return v:false
  endif

  const canonical_path = fnamemodify(expand(a:path), ':p')

  " if g:vimrc#util#path_result contains a result of a:path,
  " return that.
  if has_key(g:vimrc#util#path_result, canonical_path)
    return g:vimrc#util#path_result[canonical_path]
  endif

  if ( isdirectory(canonical_path . '/.git') )
    const result = v:true
  elseif ( canonical_path == '/' )
    const result = v:false
  else
    const result = vimrc#util#is_git_repo(fnamemodify(canonical_path, ':h:h'))
  endif

  let g:vimrc#util#path_result[canonical_path] = result
  return result
endfunction
