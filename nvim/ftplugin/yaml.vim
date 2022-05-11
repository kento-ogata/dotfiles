if exists('b:did_user_ftplugin')
  finish
endif
let b:did_user_ftplugin = v:true

const b:tabwidth = 2

execute printf('setlocal shiftwidth=%d', b:tabwidth)
execute printf('setlocal tabstop=%d', b:tabwidth)
