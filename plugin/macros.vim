" macros.vim: Run persisted vim macros.
"
" Usage:
" 1. Start recording a macro:
" qq
"
" 2. Interactively do a workflow...
"
" 3. Finish recording the macro:
" q
"
" 3. Store macro into g:macros:
" let g:macros['macro-id'] = @q
"
" 4. Run the macro:
" :Macro macro-id<cr>
"
" 5. Save the macro to a file (including the binary, unescaped version of special characters like tab, enter, escape, ...)
" ```vim
" " ~/.vim/macros/all-macros.vim
" let g:macros['macro-id'] = 'gg5jkkkkklhlhlhlhGohello world, these are two chars: ^[ and this is a real escape char: '
" ```
"
" Limitations:
" - No interactive dialoges while running the macro
" - The register "q" gets overwritten (tradeoff, less code)
" - Substitutions which are ok to fail must include the "e" flag:
"   :s/foo/bar/e
" - If using a visual selection, the selection has to be restored at the
"   beginning of the Macro with the normal mode command:
"   1v

let g:macros         = {}
let s:vimdir         = expand('<sfile>:h:h')
let s:macros_global  = s:vimdir."/macros/all-macros.vim"
let s:macros_lang    = s:vimdir."/macros/"
let s:macros_project = ".vim/macros.vim"

command! -nargs=* -range Macro call MacroInvoke(<q-args>)

function! MacroInvoke(macro)
    if filereadable(s:macros_global)
        execute "source ".s:macros_global
    endif

    let macros_lang = s:macros_lang.&filetype."-macros.vim"
    if filereadable(macros_lang)
        execute "source ".macros_lang
    endif

    if filereadable(s:macros_project)
        execute "source ".s:macros_project
    endif

    if empty(get(g:macros, a:macro))
        echo 'Macro "'.a:macro.'" not found!'
        return
    endif

    call setreg('q', g:macros[a:macro], 'c')
    normal @q
endfunction
