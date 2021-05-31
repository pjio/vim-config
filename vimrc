" vimrc for classic vim

set autoindent
set autoread
set background=dark
set backspace=indent,eol,start
set directory-=.
set expandtab
set history=10000
set hlsearch
set laststatus=2
set signcolumn=yes
set ttyscroll=1
set wildmenu

call system('mkdir -p ~/.vim-undo')
execute 'set undodir=' . expand('~/.vim-undo')

execute 'source ' . expand('<sfile>:p:h').'/pjio.vim'
