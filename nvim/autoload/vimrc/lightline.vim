function vimrc#lightline#gitreponame()
  const repo_name = gina#component#repo#name()
  if repo_name == ''
    return 'no repo'
  else
    return repo_name
  endif
endfunction

function vimrc#lightline#gitbranch()
  const branch_name = gina#component#repo#branch()
  if branch_name == ''
    return ''
  else
    return ' ' . branch_name
  endif
endfunction

function vimrc#lightline#fileformat()
  const ff = &fileformat
  return ' ' . nerdfont#fileformat#find(ff) . ' '
endfunction

function vimrc#lightline#filetype()
  const ft = &filetype
  if ft == ''
    return ''
  else
    return ft . ' ' . nerdfont#find('a.' . ft)
  endif
endfunction
