let s:extend_general_rules = [
      \ {'char': '<Tab>', 'at': '\%#\s*)', 'leave': ')'},
      \ {'char': '<Tab>', 'at': '\%#\s*]', 'leave': ']'},
      \ {'char': '<Tab>', 'at': '\%#\s*}', 'leave': '}'},
      \ {'char': '<Tab>', 'at': '\%#"', 'leave': '"'},
      \ {'char': '<Tab>', 'at': '\%#''', 'leave': '''' },
      \ {'char': '<Tab>', 'at': '\%#`', 'leave': '`'},
      \ ]

let s:html_rules = [
      \ { 'char': '>', 'at': '<\(\w\+\)\(\s\+\w\+=\"\w\+\"\)*\%#', 'input_after': '</\1>', 'with_submatch': '1' , 'filetype': 'html'},
      \ { 'char': '<Tab>', 'at': '\%#</\w\+>', 'leave': '>' },
      \ { 'char': '<CR>', 'at': '\%#</\w\+>', 'input_after': '<CR>' },
      \ { 'char': '/', 'at': '<\(\w\+\)\(\s\+\w\+=\"\w\+\"\)*\%#', 'input': '/>', 'filetype': 'html'},
      \ { 'char': '=', 'at': '\w\+\%#', 'input': '="', 'input_after': '"', 'filetype': 'html' },
      \ ]

let s:toml_rules = [
      \ {'char': '<CR>', 'at': '\%#''''''', 'input': '<CR>', 'input_after': '<CR>', 'filetype': 'toml'}
      \ ]

function vimrc#lexima#setup()
  for rule in s:extend_general_rules
    call lexima#add_rule(rule)
  endfor

  for rule in s:html_rules
    call lexima#add_rule(rule)
  endfor

  for rule in s:toml_rules
    call lexima#add_rule(rule)
  endfor
"  call lexima#add_rule()
"
"  " cs:
"  " { |, $, $"|" }
"  call lexima#add_rule({'char': '$', 'input': '$\"', 'input_after': '\"', 'filetype': ['cs','razor']})
"
"  " html:
"  " { <input type|>, =, <input type="|"> }
"  call lexima#add_rule({'char': '=', 'at': '<[^>]\+\s\w\+\%#>', 'input': '=\"', 'input_after': '\"', 'filetype': ['html','razor']})
"
"  " markdown itemization rules
"  call lexima#add_rule({'char': '<CR>', 'at': '^\s*- \S\+\%#$', 'input': '<CR>- ', 'filetype': 'markdown'})
"  call lexima#add_rule({'char': '<CR>', 'at': '^\s\+- \%#$', 'input': '<BS><BS><BS>- ', 'filetype': 'markdown'})
"  call lexima#add_rule({'char': '<CR>', 'at': '^- \%#$', 'input': '<BS><BS>', 'filetype': 'markdown'})
"  call lexima#add_rule({'char': '-', 'at': '- \%#$', 'input': '<BS><BS>  - ', 'filetype': 'markdown'})
endfunction
