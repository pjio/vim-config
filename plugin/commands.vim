command! -nargs=0 UtilsClearQuickfix      call setqflist([])
command! -nargs=* UtilsDeleteFile         call delete(expand('%')) | bdelete!
command! -nargs=* UtilsFontSize           call rpcnotify(1, 'Gui', 'Font', 'DejaVu Sans Mono '.<q-args>)
command! -nargs=* UtilsNotes              execute 'edit ~/Projects/dev/storage/notes-'.strftime('%Y').'.md'
command! -nargs=* UtilsOpenChangedFiles   call OpenChangedFiles(<q-args>)
command! -nargs=* UtilsSwapRegisters      call SwapRegisters(<q-args>)

" Coc
command! -nargs=0 Format :call CocAction('format')
command! -nargs=? Fold   :call CocAction('fold', <f-args>)
command! -nargs=0 OR     :call CocAction('runCommand', 'editor.action.organizeImport')
