let mapleader="\<Space>"

nnoremap <C-d> :q<CR>

" around clipboard
vmap <Leader>y "+y
nmap <Leader>p "+p
nmap <Leader>P "+P
vmap <Leader>p "+p
vmap <Leader>P "+P

nnoremap j gj
nnoremap k gk
nnoremap j gj
nnoremap k gk

" escape from terminal insert mode
tnoremap <silent><Esc> <C-\><C-n>

nnoremap <silent><Tab> :tabnext<CR>
nnoremap <silent><S-Tab> :tabprevious<CR>
