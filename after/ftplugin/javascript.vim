setlocal expandtab
setlocal iskeyword=@,48-57,_,192-255
setlocal shiftwidth=2
setlocal signcolumn=yes
setlocal tabstop=2

command! -buffer        JavaScriptAutoformatFile               call <SID>AutoformatFile()
command! -buffer -range JavaScriptAutoformat    <line1>,<line2>call <SID>Autoformat()

nnoremap <buffer> <silent> K :call CocAction('doHover')<cr>
noremap  <buffer> <leader>l  :JavaScript

if !exists('*s:Autoformat')
    function s:Autoformat() range
        let cmd = a:firstline . "," . a:lastline . "!js-beautify"
        execute cmd
    endfunction
endif

if !exists('*s:AutoformatFile')
    function s:AutoformatFile()
        let cmd = "%!js-beautify"
        execute cmd
    endfunction
endif
