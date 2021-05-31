setlocal expandtab
setlocal formatexpr=CocAction('formatSelected')
setlocal iskeyword=@,48-57,_,192-255
setlocal shiftwidth=2
setlocal signcolumn=yes
setlocal tabstop=2

nnoremap <buffer> <silent> K :call CocAction('doHover')<cr>

noremap  <buffer> <leader>l  :TypeScript
