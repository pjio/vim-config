" Recorded workflows
" see: plugin/macros.vim

let g:macros['hello-world'] = ':new:set buftype=nofileihello macro!'

" translate selected text from english to german
let g:macros['i18n-en-de'] ='
  \1v"zx
  \:let @x = system(''trans -brief en:de | tr -d "\n"'', @z)
  \"xP
  \'

" translate selected text from german to english
let g:macros['i18n-de-en'] ='
  \1v"zx
  \:let @x = system(''trans -brief de:en | tr -d "\n"'', @z)
  \"xP
  \'
