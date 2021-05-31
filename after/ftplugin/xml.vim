setlocal expandtab
setlocal iskeyword=@,48-57,_,192-255,-
setlocal omnifunc=xmlcomplete#CompleteTags
setlocal signcolumn=yes
setlocal shiftwidth=2
setlocal tabstop=2

nnoremap <buffer> <leader>A  :call s:AutoformatFile()<cr>
noremap  <buffer> <leader>a  :call s:Autoformat()<cr>

if !exists('*s:Autoformat')
    function s:Autoformat() range
        let cmd = a:firstline . "," . a:lastline . "!pretty-xml"
        execute cmd
    endfunction
endif

if !exists('*s:AutoformatFile')
    function s:AutoformatFile()
        let cmd = "%!pretty-xml"
        execute cmd
    endfunction
endif
