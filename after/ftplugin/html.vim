setlocal expandtab
setlocal iskeyword=@,48-57,_,192-255,-
setlocal shiftwidth=4
setlocal signcolumn=yes
setlocal tabstop=4

command! -buffer -range=% HtmlAutoformat <line1>,<line2>call <SID>Autoformat()

noremap <buffer> <leader>a :call <line1>,<line2>call <SID>Autoformat()<cr>

if !exists('*s:Autoformat')
    function s:Autoformat() range
        let cmd = a:firstline . "," . a:lastline . "!html-beautify"
        execute cmd
    endfunction
endif
