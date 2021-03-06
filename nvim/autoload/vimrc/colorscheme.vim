function s:apply_lightline(theme_name)
  if (!exists('g:lightline'))
    let g:lightline = {}
  endif
  let g:lightline.colorscheme = a:theme_name
  if (dein#tap('lightline.vim'))
    call lightline#init()
    call lightline#colorscheme()
    call lightline#update()
  endif
endfunction

function s:choice(options)
  const options_count = len(a:options)
  const choosed_index = rand(srand()) % options_count
  const option = a:options[choosed_index]
  return option
endfunction

let s:theme_names = []

" a:theme_name is must configured in this script.
function vimrc#colorscheme#register(theme_name)
  if (has_key(s:colorscheme_setups, a:theme_name))
    call add(s:theme_names, a:theme_name)
    execute printf('autocmd ColorSchemePre %s call s:colorscheme_setups["%s"]()', a:theme_name, a:theme_name)
  else
    throw 'colorsheme ' .. a:theme_name .. expand(' is not configured in <sfile>.')
  endif
endfunction

function vimrc#colorscheme#set_atrandom()
  const theme_name = s:choice(s:theme_names)
  execute printf('colorscheme %s', theme_name)
endfunction

let s:colorscheme_setups = {}

function s:iceberg() dict
  execute printf('set bg=%s', s:choice(['dark', 'light']))
  call s:apply_lightline('iceberg')
endfunction
let s:colorscheme_setups['iceberg'] = function('s:iceberg')

function s:gruvbox_material() dict
  set background=dark
  call s:apply_lightline('gruvbox_material')

  let g:gruvbox_material_background = s:choice(['hard', 'medium', 'soft'])
  let g:gruvbox_material_foreground = s:choice(['material', 'mix', 'original'])
  let g:gruvbox_material_disable_italic_comment = 0
  let g:gruvbox_material_enable_bold = 0
  let g:gruvbox_material_enable_italic = 0
  let g:gruvbox_material_cursor = 'auto'
  let g:gruvbox_material_transparent_background = 0
  let g:gruvbox_material_visual = 'grey background'
  let g:gruvbox_material_menu_selection_background = 'grey'
  let g:gruvbox_material_sign_column_background = 'none'
  let g:gruvbox_material_spell_foreground = 'colored'
  let g:gruvbox_material_ui_contrast = s:choice(['low', 'high'])
  let g:gruvbox_material_show_eob = 1
  let g:gruvbox_material_diagnostic_text_highlight = 1
  let g:gruvbox_material_diagnostic_line_highlight = 1
  let g:gruvbox_material_diagnostic_virtual_text = 'colored'
  let g:gruvbox_material_current_word = 'grey background'
  let g:gruvbox_material_disable_terminal_colors = 0
  let g:gruvbox_material_statusline_style = s:choice(['default', 'mix', 'original'])
  let g:gruvbox_material_lightline_disable_bold = 0
  let g:gruvbox_material_better_performance = 1
  let g:gruvbox_material_colors_override = {}
endfunction
let s:colorscheme_setups['gruvbox-material'] = function('s:gruvbox_material')

function s:edge() dict
  set background=dark
  call s:apply_lightline('edge')

  let g:edge_style = s:choice(['default', 'aura', 'neon'])
  let g:edge_dim_foreground = 0
  let g:edge_disable_italic_comment = 0
  let g:edge_enable_italic = 0
  let g:edge_cursor = 'auto'
  let g:edge_transparent_background = 0
  let g:edge_menu_selection_background = 'blue'
  let g:edge_spell_foreground = 'none'
  let g:edge_show_eob = 1
  let g:edge_diagnostic_text_highlight = 1
  let g:edge_diagnostic_line_highlight = 1
  let g:edge_diagnostic_virtual_text = 'colored'
  let g:edge_current_word = 'grey background'
  let g:edge_disable_terminal_colors = 0
  let g:edge_lightline_disable_bold = 0
  let g:edge_better_performance = 1
  let g:edge_colors_override = {}
endfunction
let s:colorscheme_setups['edge'] = function('s:edge')

function s:everforest() dict
  execute printf('set bg=%s', s:choice(['dark', 'light']))
  call s:apply_lightline('everforest')

  let g:everforest_background = s:choice(['hard', 'medium', 'soft'])
  let g:everforest_enable_italic = 0
  let g:everforest_disable_italic_comment = 0
  let g:everforest_cursor = 'auto'
  let g:everforest_transparent_background = 0
  let g:everforest_sign_column_background = 'none'
  let g:everforest_spell_foreground = 'none'
  let g:everforest_ui_contrast = s:choice(['low', 'high'])
  let g:everforest_show_eob = 1
  let g:everforest_diagnostic_text_highlight = 1
  let g:everforest_diagnostic_line_highlight = 0
  let g:everforest_diagnostic_virtual_text = 'colored'
  let g:everforest_current_word = 'grey background'
  let g:everforest_disable_terminal_colors = 0
  let g:everforest_lightline_disable_bold = 0
  let g:everforest_better_performance = 1
  let g:everforest_colors_override = {}
endfunction
let s:colorscheme_setups['everforest'] = function('s:everforest')

function s:sonokai() dict
  set background=dark
  call s:apply_lightline('sonokai')

  let g:sonokai_style = s:choice(['default', 'atlantis', 'andromeda', 'shusia', 'maia', 'espresso'])
  let g:sonokai_disable_italic_comment = 0
  let g:sonokai_enable_italic = 0
  let g:sonokai_cursor = 'auto'
  let g:sonokai_transparent_background = 0
  let g:sonokai_menu_selection_background = 'blue'
  let g:sonokai_spell_foreground = 'none'
  let g:sonokai_show_eob = 1
  let g:sonokai_diagnostic_text_highlight = 1
  let g:sonokai_diagnostic_line_highlight = 1
  let g:sonokai_diagnostic_virtual_text = 'colored'
  let g:sonokai_current_word = 'grey background'
  let g:sonokai_disable_terminal_colors = 0
  let g:sonokai_lightline_disable_bold = 0
  let g:sonokai_better_performance = 1
  let g:sonokai_colors_override = {}
endfunction
let s:colorscheme_setups['sonokai'] = function('s:sonokai')
