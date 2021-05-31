" Recorded workflows
" see: plugin/macros.vim

let g:macros['sort-array-block']    = '?\v\[\s*$jVk$%k:!sort'
let g:macros['tabular-array-block'] = '?\v\[\s*$jVk$%k:Tabularize 1=>'
let g:macros['import-alias']        = ':let @" = g:m_src:e " c b:PhpAddImport'
let g:macros['file-header']         = 'ggi<?phpdeclare(strict_types=1);'

let g:macros['remove-unused-use-all'] = '
    \:w
    \:!php-cs-fixer fix "=expand("%:p")" --rules=no_unused_imports
    \:e
\'

let g:macros['import'] = '
    \ma
    \:execute "tjump ".expand("<cword>")
    \:PhpCopyFileValues
    \:b#
    \:PhpAddImport
    \`a
\'

let g:macros['multiline-params'] = '
    \ma
    \F(a$?[^)]f)ik:s/\v, */,\r/g
    \jV`a=
    \`a
\'

let g:macros['interface-method-bodies'] = '
    \:let tmp=@/
    \:%s/\v(public.*);$/\1    {    }/
    \:let @/=tmp
\'
