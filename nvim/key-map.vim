let mapleader="\<Space>"

nnoremap <C-d> :q<CR>

" around clipboard
vmap <Leader>y "+y
nmap <Leader>p "+p
nmap <Leader>P "+P
vmap <Leader>p "+p
vmap <Leader>P "+P

nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l

nnoremap j gj
nnoremap k gk
nnoremap j gj
nnoremap k gk

" escape from terminal insert mode
tnoremap <silent><Esc> <C-\><C-n>

nnoremap <silent><Tab> :tabnext<CR>
nnoremap <silent><S-Tab> :tabprevious<CR>
