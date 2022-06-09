function vimrc#ddc#add_source_buffer(source_name)
  let l:current_sources = ddc#custom#get_current()['sources']
  call add(l:current_sources, a:source_name)
  call ddc#custom#patch_buffer('sources', l:current_sources)
endfunction

function vimrc#ddc#insert_source_buffer(source_name)
  let l:current_sources = ddc#custom#get_current()['sources']
  call insert(l:current_sources, a:source_name)
  call ddc#custom#patch_buffer('sources', l:current_sources)
endfunction
