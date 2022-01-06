inoremap <expr> <Tab>   pum#visible() ? pum#map#confirm() : "\<Tab>"
inoremap <C-n>          <Cmd>call pum#map#select_relative(+1)<CR>
inoremap <C-p>          <Cmd>call pum#map#select_relative(-1)<CR>

