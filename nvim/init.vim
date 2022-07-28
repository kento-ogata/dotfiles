" important commands
" gf    : type this on filepath string, to jump the file.
" <C-o> : jump to previous point of jumplist
" <C-i> : jump to next point of jumplist
" K     : open help of under cursor word

if has('nvim')
  " :autocmd NvimLspRc
  augroup NvimLspRc
    autocmd!
  augroup END
endif
let mapleader="\<Space>"
nnoremap <Leader> <Nop>

" ./autoload/vimrc.vim
call vimrc#set_maps()
call vimrc#set_options()
if has('nvim')
  call vimrc#set_nvimlsp()
endif

call vimrc#setup_netrw()

call vimrc#set_shellcommand()

call vimrc#grepcmd('rg')

cabbrev vh vert bo h

command UnixEnc e ++enc=utf-8 ++ff=unix
command DosEnc e ++enc=cp932 ++ff=dos

call vimrc#setup_dein()
