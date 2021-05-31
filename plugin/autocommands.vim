augroup customDefault
    autocmd!
    autocmd InsertLeave  * set nopaste
    autocmd BufRead,BufNewFile tsconfig.json set filetype=jsonc
augroup END

augroup customDetectChangedFiles
    autocmd!
    autocmd BufEnter    *.* checktime
    autocmd BufWinEnter *.* checktime
    autocmd CursorHold  *.* checktime
    autocmd CursorHoldI *.* checktime
augroup END

augroup Coc
    autocmd!
    autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
    " autocmd CursorHold * silent call CocActionAsync('highlight')
augroup END
