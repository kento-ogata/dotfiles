let s:block_escape_rules = [
      \ {'char': '<Tab>', 'at': '\%#\s*)', 'leave': ')'},
      \ {'char': '<Tab>', 'at': '\%#\s*]', 'leave': ']'},
      \ {'char': '<Tab>', 'at': '\%#\s*}', 'leave': '}'},
      \ {'char': '<Tab>', 'at': '\%#"', 'leave': '"'},
      \ {'char': '<Tab>', 'at': '\%#''', 'leave': '''' },
      \ {'char': '<Tab>', 'at': '\%#`', 'leave': '`'},
      \ ]

let s:html_rules = [
      \ {'filetype': 'html', 'char': '>', 'at': '<\(\w\+\)\(\s\+\w\+=\".\+\"\)*\%#', 'input_after': '</\1>', 'with_submatch': '1'},
      \ {'filetype': 'html', 'char': '<Tab>', 'at': '\%#</\w\+>', 'leave': '>'},
      \ {'filetype': 'html', 'char': '<CR>', 'at': '\%#</\w\+>', 'input_after': '<CR>'},
      \ {'filetype': 'html', 'char': '/', 'at': '<\(\w\+\)\(\s\+\w\+=\".\+\"\)*\%#', 'input': '/>'},
      \ {'filetype': 'html', 'char': '=', 'at': '\w\+\%#', 'input': '="', 'input_after': '"'},
      \ ]

let s:razor_rules = [
      \ {'filetype': ['razor', 'cshtml'], 'char': '<CR>', 'at': '\%#</\w\+>', 'input_after': '<CR>'},
      \ ]

let s:toml_rules = [
      \ {'filetype': 'toml', 'char': '<CR>', 'at': '\%#''''''', 'input': '<CR>', 'input_after': '<CR>'}
      \ ]

let s:cs_rules = [
      \ {'filetype': 'cs', 'char': '{' , 'at': '^\s\+\(public\|private\|protected\|internal\)\s\+\(\w\+\(<\w\+>\)*\)\s\+\(\w\+\)\s\+\%#$', 'input': '{ get', 'input_after': '; set; }'},
      \ {'filetype': 'cs', 'char': '<Tab>', 'at': 'get\( => .\+\)*\%#; set', 'leave': 'set',},
      \ {'filetype': 'cs', 'char': '<Tab>', 'at': 'set\( => .\+\)*\%#; }', 'leave': '}'},
      \ ]

let s:viml_rules = [
      \ {'filetype': 'vim', 'char': '<CR>', 'at': '\%#\s*]', 'input': '<CR><Bslash><Space>'},
      \ {'filetype': 'vim', 'char': '<CR>', 'at': '\%#\s*}', 'input': '<CR><Bslash><Space>'},
      \ {'filetype': 'vim', 'char': '<CR>', 'at': ',\%#', 'input': '<CR><Bslash><Space>'},
      \ ]

function vimrc#lexima#setup()
  call vimrc#lexima#_set_rules(s:block_escape_rules)

  augroup LeximaRc
    autocmd!
    autocmd FileType html   ++once call vimrc#lexima#_set_rules(s:html_rules)
    autocmd FileType toml   ++once call vimrc#lexima#_set_rules(s:toml_rules)
    autocmd FileType cs     ++once call vimrc#lexima#_set_rules(s:cs_rules)
    autocmd FileType razor  ++once call vimrc#lexima#_set_rules(s:razor_rules)
    autocmd FileType vim    ++once call vimrc#lexima#_set_rules(s:viml_rules)
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
