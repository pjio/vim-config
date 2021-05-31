setlocal expandtab
setlocal indentexpr=
setlocal iskeyword=@,48-57,_,192-255,-
setlocal shiftwidth=4
setlocal signcolumn=yes
setlocal tabstop=4

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
