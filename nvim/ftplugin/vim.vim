if exists('b:did_user_ftplugin')
  finish
endif
let b:did_user_ftplugin = v:true

const b:tabwidth = 2

execute 'setlocal shiftwidth=' . b:tabwidth
execute 'setlocal tabstop='    . b:tabwidth
