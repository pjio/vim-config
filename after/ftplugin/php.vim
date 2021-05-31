setlocal expandtab
setlocal shiftwidth=4
setlocal signcolumn=yes
setlocal tabstop=4
setlocal iskeyword=@,48-57,_,192-255
let b:PHP_outdentphpescape = 0

command! -buffer PhpAddImport            call <SID>AddImport()
command! -buffer PhpSortImports          call <SID>SortImports()
command! -buffer PhpRemoveUnusedImports  call <SID>RemoveUnusedImports()
command! -buffer PhpOptimizeImports      call <SID>OptimizeImports()
command! -buffer PhpCopyFileValues       call <SID>CopyFileValues()
command! -buffer PhpDocParams            call <SID>PhpDocParams()
command! -buffer PhpGetSet               call <SID>PhpCreateGetterSetter()
command! -buffer PhpMakeAssignments      call <SID>PhpMakeAssignments()
command! -buffer PhpToggleTest           call <SID>PhpToggleTest()

nnoremap <buffer> <silent> K :call CocAction('doHover')<cr>

nnoremap <buffer> <leader>A  :%!phpcbf -q - ; exit 0<cr>
vnoremap <buffer> <leader>a  :!sed '1 s/^/<?php\n/' \| phpcbf -q - \| sed 1d<cr>gv=`
noremap  <buffer> <leader>l  :Php
noremap  <buffer> <leader>i  :PhpAddImport<cr>
noremap  <buffer> <leader>I  :Macro import<cr>
nnoremap <buffer> <leader>C  :PhpCopyFileValues<cr>

" Syntax tweaks for best render performance.
" See: extensions/vim-polyglot/syntax/php.vim
let php_sql_query          = 0
let php_sql_heredoc        = 0
let php_sql_nowdoc         = 0
let php_xml_heredoc        = 0
let php_xml_nowdoc         = 0
let php_html_in_strings    = 0
let php_html_in_heredoc    = 0
let php_html_in_nowdoc     = 0
let php_html_load          = 0
let php_ignore_phpdoc      = 0
let php_parent_error_close = 0
let php_parent_error_open  = 0
let php_folding            = 0
let php_phpdoc_folding     = 0
let php_sync_method        = -1

if !exists('*s:SortImports')
    function s:SortImports()
        let save_a_mark = getpos(".")
        let tmp=@/

        write
        call system("php-cs-fixer fix \"" . expand("%h") . "\" --rules=\"ordered_imports\" --using-cache=false")
        edit!

        call cursor(1, 1)
        let cmd = "normal /^use \<cr>V/^$\<cr>k:!uniq\<cr>"
        execute cmd

        let @/=tmp
        call setpos(".", save_a_mark)
    endfunction
endif

if !exists('*s:AddImport')
    function s:AddImport()
        let save_a_mark = getpos(".")
        let tmp=@/

        call cursor(1, 1)
        let found = search('^use ')

        if found == 0
            call cursor(1, 1)
            let found = search('^namespace ')
            if found != 0
                normal o
            endif
        endif

        if found == 0
            call cursor(1, 1)
        endif

        normal "bp

        PhpSortImports

        call setpos(".", save_a_mark)
        let @/=tmp
    endfunction
endif

if !exists('*s:RemoveUnusedImports')
    function s:RemoveUnusedImports()
        write
        call system("php-cs-fixer fix \"" . expand("%h") . "\" --rules=\"no_unused_imports\" --using-cache=false")
        edit
    endfunction
endif

if !exists('*s:OptimizeImports')
    function s:OptimizeImports()
        call <SID>RemoveUnusedImports()
        call <SID>SortImports()
    endfunction
endif

if !exists('*s:CopyFileValues')
    function s:CopyFileValues()
        python3 << EOF
from php.misc import copy_file_values
copy_file_values()
EOF
    endfunction
endif

if !exists('*s:PhpDocParams')
    function s:PhpDocParams()
        python3 << EOF
from php.docparams import php_doc_params
php_doc_params()
EOF
    endfunction
endif

if !exists('*s:PhpMakeAssignments')
    function s:PhpMakeAssignments()
        python3 << EOF
from php.make_assignments import php_make_assignments
php_make_assignments()
EOF
    endfunction
endif

if !exists('*s:PhpCreateGetterSetter')
    function s:PhpCreateGetterSetter()
        python3 << EOF
from php.getset import php_make_getter_and_setter
php_make_getter_and_setter()
EOF
    endfunction
endif

if !exists('*s:PhpToggleTest')
    function s:PhpToggleTest()
        python3 << EOF
import vim, re, os
current_file = vim.eval('@%')
if re.match('.*Test.php', current_file):
    toggle_file = re.sub('Test', '', re.sub('^tests?/', 'src/', current_file))
else:
    toggle_file = re.sub('\.php$', 'Test.php', re.sub('^src/', 'test/', current_file))
    if not os.path.isfile(toggle_file):
        toggle_file = re.sub('\.php$', 'Test.php', re.sub('^src/', 'tests/', current_file))

if not os.path.isfile(toggle_file):
    print('Not found: %s' % toggle_file)
elif toggle_file == current_file:
    print('Not found')
else:
    print(toggle_file)
    vim.command(':edit %s' % toggle_file)
EOF
    endfunction
endif
