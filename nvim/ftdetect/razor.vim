" Vim ftdetect file
" Language: Razor (docs.microsoft.com/en-us/aspnet/core/mvc/views/razor)
" Author: Jeffrey Crochet <jlcrochet@pm.me>
" URL: github.com/jlcrochet/vim-razor

" Copied from
" https://github.com/jlcrochet/vim-razor/blob/master/ftdetect/razor.vim
" Because I want to get razor filetype before loading vim-razor plugin.

autocmd BufRead,BufNewFile *.razor,*.cshtml setlocal filetype=razor
