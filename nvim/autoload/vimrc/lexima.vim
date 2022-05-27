let s:block_escape_rules = [
      \ {'char': '<Tab>', 'at': '\%#\s*)', 'leave': ')'},
      \ {'char': '<Tab>', 'at': '\%#\s*]', 'leave': ']'},
      \ {'char': '<Tab>', 'at': '\%#\s*}', 'leave': '}'},
      \ {'char': '<Tab>', 'at': '\%#"', 'leave': '"'},
      \ {'char': '<Tab>', 'at': '\%#''', 'leave': '''' },
      \ {'char': '<Tab>', 'at': '\%#`', 'leave': '`'},
      \ ]

let s:html_rules = [
      \ { 'char': '>', 'at': '<\(\w\+\)\(\s\+\w\+=\".\+\"\)*\%#', 'input_after': '</\1>', 'with_submatch': '1' , 'filetype': 'html'},
      \ { 'char': '<Tab>', 'at': '\%#</\w\+>', 'leave': '>' },
      \ { 'char': '<CR>', 'at': '\%#</\w\+>', 'input_after': '<CR>' },
      \ { 'char': '/', 'at': '<\(\w\+\)\(\s\+\w\+=\".\+\"\)*\%#', 'input': '/>', 'filetype': 'html'},
      \ { 'char': '=', 'at': '\w\+\%#', 'input': '="', 'input_after': '"', 'filetype': 'html' },
      \ ]

let s:toml_rules = [
      \ {'char': '<CR>', 'at': '\%#''''''', 'input': '<CR>', 'input_after': '<CR>', 'filetype': 'toml'}
      \ ]

let s:cs_rules = [
      \ {'char': '{' , 'at': '^\s\+\(public\|private\)\s\+\(\w\+\(<\w\+>\)*\)\s\+\(\w\+\)\s\+\%#$', 'input': '{ get', 'input_after': '; set; }', 'filetype': 'cs'},
      \ {'char': '<Tab>', 'at': 'get\( => .\+\)*\%#; set', 'leave': 'set', 'filetype': 'cs'},
      \ {'char': '<Tab>', 'at': 'set\( => .\+\)*\%#; }', 'leave': '}', 'filetype': 'cs'},
      \ ]

function vimrc#lexima#setup()
  call vimrc#lexima#_set_rules(s:block_escape_rules)

  augroup LeximaRc
    autocmd!
    autocmd FileType html ++once call vimrc#lexima#_set_rules(s:html_rules)
    autocmd FileType toml ++once call vimrc#lexima#_set_rules(s:toml_rules)
    autocmd FileType cs   ++once call vimrc#lexima#_set_rules(s:cs_rules)
  augroup END

  doautocmd <nomodeline> LeximaRc FileType
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

function vimrc#lexima#_set_rules(rules)
  for rule in a:rules
    call lexima#add_rule(rule)
  endfor
endfunction
