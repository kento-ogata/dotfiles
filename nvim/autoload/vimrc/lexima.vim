function vimrc#lexima#setup()
  " { before, input, after }
  " | is cursor position.
  call lexima#add_rule({'char': '<Tab>', 'at': '\%#\s*)', 'leave': ')'})
  call lexima#add_rule({'char': '<Tab>', 'at': '\%#\s*"', 'leave': '"'})
  call lexima#add_rule({'char': '<Tab>', 'at': '\%#\s*''', 'leave': ''''})
  call lexima#add_rule({'char': '<Tab>', 'at': '\%#\s*]', 'leave': ']'})
  call lexima#add_rule({'char': '<Tab>', 'at': '\%#\s*}', 'leave': '}'})

  call lexima#add_rule({'char': '<CR>', 'at': '\%#''''''', 'input': '<CR>', 'input_after': '<CR>', 'filetype': 'toml'})

  " cs:
  " { |, $, $"|" }
  call lexima#add_rule({'char': '$', 'input': '$\"', 'input_after': '\"', 'filetype': ['cs','razor']})

  " html:
  " { |, <, <|> }
  call lexima#add_rule({'char': '<', 'input': '<', 'input_after': '>', 'filetype': ['html', 'razor']})
  " { <input type="text"/|>, <Tab>, <input type="text"/>| }
  call lexima#add_rule({'char': '<Tab>', 'at': '\%#>', 'leave': '>', 'filetype': ['html','razor']})
  " { <input type="text"|>, <Tab>, <input type="text">|</input> }
  call lexima#add_rule({
      \ 'char': '<Tab>',
      \ 'at': '<\(\w\+\)\s[^>]\+[^\/]\%#>',
      \ 'leave': '>',
      \ 'input_after': '</\1>',
      \ 'with_submatch': 1,
      \ 'filetype': ['html','razor']})
  " { <div|>, <Tab>, <div>|</div> }
  call lexima#add_rule({
      \ 'char': '<Tab>',
      \ 'at': '<\(\w\+\)\%#>',
      \ 'leave': '>',
      \ 'input_after': '</\1>',
      \ 'with_submatch': 1,
      \ 'filetype': ['html', 'razor']})
  " { <|>, <BS>, | }
  call lexima#add_rule({'char': '<BS>', 'at': '<\%#>', 'input': '<BS>', 'delete': '>', 'filetype': ['html', 'razor']})
  " { <input type|>, =, <input type="|"> }
  call lexima#add_rule({'char': '=', 'at': '<[^>]\+\s\w\+\%#>', 'input': '=\"', 'input_after': '\"', 'filetype': ['html','razor']})
  " { |</div>, <Tab>, </div>| }
  call lexima#add_rule({
      \ 'char': '<Tab>',
      \ 'at': '\%#<\/\w\+>',
      \ 'leave': '>',
      \ 'filetype': ['html', 'razor']
      \ })
  " {
  "   <div>|</div>,
  "   <CR>,
  "   <div>
  "     |
  "   </div>
  " }
  call lexima#add_rule({
      \ 'char': '<CR>',
      \ 'at': '>\%#<',
      \ 'input': '<CR>',
      \ 'input_after': '<CR>',
      \ 'filetype': ['html', 'razor']})

  " markdown itemization rules
  call lexima#add_rule({'char': '<CR>', 'at': '^\s*- \S\+\%#$', 'input': '<CR>- ', 'filetype': 'markdown'})
  call lexima#add_rule({'char': '<CR>', 'at': '^\s\+- \%#$', 'input': '<BS><BS><BS>- ', 'filetype': 'markdown'})
  call lexima#add_rule({'char': '<CR>', 'at': '^- \%#$', 'input': '<BS><BS>', 'filetype': 'markdown'})
  call lexima#add_rule({'char': '-', 'at': '- \%#$', 'input': '<BS><BS>  - ', 'filetype': 'markdown'})
endfunction
