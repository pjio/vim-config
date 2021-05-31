" Recorded workflows
" see: plugin/macros.vim

let g:macros['sort-array-block']    = '?\v\[\s*$
let g:macros['tabular-array-block'] = '?\v\[\s*$
let g:macros['import-alias']        = ':let @" = g:m_src
let g:macros['file-header']         = 'ggi<?php

let g:macros['remove-unused-use-all'] = '
    \:w
    \:!php-cs-fixer fix "=expand("%:p")
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
    \F(a
    \jV`a=
    \`a
\'

let g:macros['interface-method-bodies'] = '
    \:let tmp=@/
    \:%s/\v(public.*);$/\1
    \:let @/=tmp
\'