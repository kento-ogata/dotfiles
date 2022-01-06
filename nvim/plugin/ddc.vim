call ddc#custom#patch_global('completionMenu', 'pum.vim')

call ddc#custom#patch_global('sources', ['around'])

call ddc#custom#patch_global('sourceOptions', {
            \ '_' : {
                \ 'matchers': ['matcher_head'],
                \ 'sorters': ['sorter_rank']},
                \ })

call ddc#custom#patch_global('sourceOptions', {
            \ 'around': {'mark': 'A'},
            \ })
call ddc#custom#patch_global('sourceParams', {
            \ 'around': {'maxSize': 500},
            \ })

call ddc#custom#patch_filetype(['c', 'cpp'], 'sources', ['around', 'clangd'])
call ddc#custom#patch_filetype(['c', 'cpp'], 'sourceOptions', {
            \ 'clangd': {'mark': 'C'},
            \ })
call ddc#custom#patch_filetype('markdown', 'sourceParams', {
            \ 'around': {'maxSize': 100},
            \ })

inoremap <silent><expr> <TAB>
            \ ddc#map#pum_visible() ? '<C-n>' :
            \ (col('.') <= 1 <Bar><Bar> getline('.')[col('.') - 2] =~# '\s') ?
            \ '<TAB>' : ddc#map#manual_complete()

inoremap <expr><S-TAB> ddc#map#pum_visible() ? '<C-p>' : '<C-h>'

call ddc#custom#patch_global('autoCompleteEvents', [
            \ 'InsertEnter', 'TextChangedI', 'TextChangedP',
            \ 'CmdlineEnter', 'CmdlineChanged',
            \ ])

nnoremap : <Cmd>call CommandlinePre()<CR>:

function! CommandlinePre() abort
    " Note: It disables default command line completion!
    cnoremap <expr> <Tab>
                \ pum#visible() ? '<Cmd>call pum#map#insert_relative(+1)<CR>' :
                \ ddc#manual_complete()
    cnoremap <S-Tab> <Cmd>call pum#map#insert_relative(-1)<CR>
    cnoremap <C-y>   <Cmd>call pum#map#confirm()<CR>
    cnoremap <C-e>   <Cmd>call pum#map#cancel()<CR>

    " Overwrite sources
    let s:prev_buffer_config = ddc#custom#get_buffer()
    call ddc#custom#patch_buffer('sources',
                \ ['cmdline', 'cmdline-history', 'around'])

    autocmd User DDCCmdlineLeave ++once call CommandlinePost()

    " Enable command line completion
    call ddc#enable_cmdline_completion()
    call ddc#enable()
endfunction

function! CommandlinePost() abort
    " Restore sources
    call ddc#custom#set_buffer(s:prev_buffer_config)
    cunmap <Tab>
endfunction

call ddc#enable()

