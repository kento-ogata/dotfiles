function vimrc#lightline#gitbranch()
  const branch_name = gina#component#repo#branch()
  return ' ' . branch_name
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
