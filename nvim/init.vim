if &compatible
  set nocompatible
endif

if has('nvim')
  augroup NvimLspRc
    autocmd!
  augroup END
endif
let mapleader="\<Space>"

call vimrc#setup_dein()
call vimrc#map()
call vimrc#set()
if has('nvim')
  call vimrc#set_nvimlsp()
endif

call vimrc#setup_netrw()

call vimrc#set_shellcommand()

cabbrev vh vert bo h

command UnixEnc e ++enc=utf-8 ++ff=unix
command DosEnc e ++enc=cp932 ++ff=dos
