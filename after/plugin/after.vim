if exists('g:GtkGuiLoaded')
    call rpcnotify(1, 'Gui', 'Option', 'Tabline', 0)
    call rpcnotify(1, 'Gui', 'Option', 'Popupmenu', 0)
    call rpcnotify(1, 'Gui', 'Font', 'DejaVu Sans Mono 10')

    set mouse=a
endif

if exists(':AddTabularPattern')
    AddTabularPattern 1=  /^[^=]*\zs=/l1
    AddTabularPattern 1=> /^[^=]*\zs=>/l1
    AddTabularPattern 1:  /^[^:]*: */l0
endif

" remove vim-sneak shortcut
silent! vunmap s

" autoload project.vim
autocmd StdinReadPre * let s:argument_stdin = 1
autocmd VimEnter * if filereadable(".vim/project.vim") && argc() == 0 && !exists('s:argument_stdin')
    \ | edit .vim/project.vim
    \ | set filetype=vim
    \ | endif
