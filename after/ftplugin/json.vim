setlocal expandtab
setlocal formatexpr=CocAction('formatSelected')
setlocal shiftwidth=2
setlocal signcolumn=yes
setlocal tabstop=2

command! -buffer          JsonAutoformatFile call <SID>AutoformatFile()
command! -buffer -range=% JsonAutoformat     <line1>,<line2>call <SID>Autoformat()

noremap <buffer> <leader>A :call <SID>AutoformatFile()<cr>
noremap <buffer> <leader>a :call <line1>,<line2>call <SID>Autoformat()<cr>
noremap <buffer> <leader>l :Json

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
