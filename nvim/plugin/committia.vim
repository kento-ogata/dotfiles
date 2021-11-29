augroup GitSpellCheck
	autocmd!
	autocmd FileType gitcommit setlocal spell
augroup END

let g:committia_hooks = {}
function! g:committia_hooks.edit_open(info)
	setlocal spell
	setlocal spelllang+=cjk

	imap <buffer><C-n> <Plug>(committia-scroll-diff-down-half)
	imap <buffer><C-p> <Plug>(committia-scroll-diff-up-half)
endfunction

let g:committia_open_only_vim_starting = 1
let g:committia_use_singlecolumn = 'fallback'
let g:committia_min_window_size = 160
let g:committia_status_window_opencmd = 'belowright split'
let g:committia_diff_window_opencmd = 'botright vsplit'
let g:committia_singlecolumn_diff_window_opencmd = 'belowright split'
