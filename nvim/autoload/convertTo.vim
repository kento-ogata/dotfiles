function convertTo#list(variable)
  const type = type(a:variable)
  if (type != v:t_list)
    return [a:variable]
  else
    return a:variable
  endif
endfunction
