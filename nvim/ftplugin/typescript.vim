if exists('b:did_user_ftplugin')
  finish
endif
let b:did_user_ftplugin = v:true

setlocal shiftwidth=2
nmap <buffer> <C-e> :!deno run %<CR>
