let s:extend_general_rules = [
      \ {'char': '<Tab>', 'at': '\%#\s*)', 'leave': ')'},
      \ {'char': '<Tab>', 'at': '\%#\s*]', 'leave': ']'},
      \ {'char': '<Tab>', 'at': '\%#\s*}', 'leave': '}'},
      \ {'char': '<Tab>', 'at': '\%#"', 'leave': '"'},
      \ {'char': '<Tab>', 'at': "\%#'", 'leave': "'" },
      \ {'char': '<Tab>', 'at': '\%#`', 'leave': '`'},
      \ ]

let s:html_rules = [
      \ { 'char': '>', 'at': '<\(\w\+\)\(\s\+\w\+=\"\w\+\"\)*\%#', 'input_after': '</\1>', 'with_submatch': '1' , 'filetype': 'html'},
      \ { 'char': '<Tab>', 'at': '\%#</\w\+>', 'leave': '>' },
      \ { 'char': '<CR>', 'at': '\%#</\w\+>', 'input_after': '<CR>' },
      \ { 'char': '/', 'at': '<\(\w\+\)\(\s\+\w\+=\"\w\+\"\)*\%#', 'input': '/>', 'filetype': 'html'},
      \ { 'char': '=', 'at': '\w\+\%#', 'input': '="', 'input_after': '"', 'filetype': 'html' },
      \ ]

function vimrc#lexima#setup()
  for rule in s:extend_general_rules
    call lexima#add_rule(rule)
  endfor

  for rule in s:html_rules
    call lexima#add_rule(rule)
  endfor
"  call lexima#add_rule({'char': '<CR>', 'at': '\%#''''''', 'input': '<CR>', 'input_after': '<CR>', 'filetype': 'toml'})
"
"  " cs:
"  " { |, $, $"|" }
"  call lexima#add_rule({'char': '$', 'input': '$\"', 'input_after': '\"', 'filetype': ['cs','razor']})
"
"  " html:
"  " { |, <, <|> }
"  call lexima#add_rule({'char': '<', 'input': '<', 'input_after': '>', 'filetype': ['html', 'razor']})
"  " { <input type="text"/|>, <Tab>, <input type="text"/>| }
"  call lexima#add_rule({'char': '<Tab>', 'at': '\%#>', 'leave': '>', 'filetype': ['html','razor']})
"  " { <input type="text"|>, <Tab>, <input type="text">|</input> }
"  call lexima#add_rule({
"      \ 'char': '<Tab>',
"      \ 'at': '<\(\w\+\)\s[^>]\+[^\/]\%#>',
"      \ 'leave': '>',
"      \ 'input_after': '</\1>',
"      \ 'with_submatch': 1,
"      \ 'filetype': ['html','razor']})
"  " { <div|>, <Tab>, <div>|</div> }
"  call lexima#add_rule({
"      \ 'char': '<Tab>',
"      \ 'at': '<\(\w\+\)\%#>',
"      \ 'leave': '>',
"      \ 'input_after': '</\1>',
"      \ 'with_submatch': 1,
"      \ 'filetype': ['html', 'razor']})
"  " { <|>, <BS>, | }
"  call lexima#add_rule({'char': '<BS>', 'at': '<\%#>', 'input': '<BS>', 'delete': '>', 'filetype': ['html', 'razor']})
"  " { <input type|>, =, <input type="|"> }
"  call lexima#add_rule({'char': '=', 'at': '<[^>]\+\s\w\+\%#>', 'input': '=\"', 'input_after': '\"', 'filetype': ['html','razor']})
"
"  " markdown itemization rules
"  call lexima#add_rule({'char': '<CR>', 'at': '^\s*- \S\+\%#$', 'input': '<CR>- ', 'filetype': 'markdown'})
"  call lexima#add_rule({'char': '<CR>', 'at': '^\s\+- \%#$', 'input': '<BS><BS><BS>- ', 'filetype': 'markdown'})
"  call lexima#add_rule({'char': '<CR>', 'at': '^- \%#$', 'input': '<BS><BS>', 'filetype': 'markdown'})
"  call lexima#add_rule({'char': '-', 'at': '- \%#$', 'input': '<BS><BS>  - ', 'filetype': 'markdown'})
endfunction
