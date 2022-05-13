((pair
  (bare_key) @_key
  (string) @vim)
 (#vim-match? @_key "^hook_\w*")(#match? @vim "^\([']{3}.*[']{3}\)$")
 (#offset! @vim 0 3 0 -3))
((pair
  (bare_key) @_key
  (string) @vim)
 (#vim-match? @_key "^hook_\w*")(#match? @vim "^\([']{1}.*[']{1}\)$")
 (#offset! @vim 0 1 0 -1))
((table
  (bare_key) @_key
  (pair
   (string) @vim))
 (#eq? @_key "ftplugin")
 (#offset! @vim 0 3 0 -3))
((table
  (dotted_key) @_key
  (pair
   (string) @vim))
 (#eq? @_key "plugins.ftplugin")
 (#offset! @vim 0 3 0 -3))
