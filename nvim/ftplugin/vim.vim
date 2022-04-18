if exists('b:did_user_ftplugin')
  finish
endif
let b:did_user_ftplugin = v:true

const s:tabwidth = 2

execute 'setlocal shiftwidth=' . s:tabwidth
execute 'setlocal tabstop='    . s:tabwidth
