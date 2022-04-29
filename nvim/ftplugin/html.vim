if exists('b:did_user_ftplugin')
  finish
endif
let b:did_user_ftplugin = v:true

const b:tabwidth = 2

execute printf('setlocal shiftwidth=%s', b:tabwidth)
execute printf('setlocal tabstop=%s', b:tabwidth)
