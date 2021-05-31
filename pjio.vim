" pjio.vim

set complete=.,w,b,u
set hidden
set list
set listchars=tab:>-,trail:~,extends:>,precedes:<
set nofixendofline
set noincsearch
set noshowcmd
set nowritebackup
set number
set pumheight=10
set scrolloff=20
set shiftwidth=4
set shortmess+=Ic
set showtabline=2
set statusline=%f\ %m\ %r\%=\ %l,%v\ \ \ \ %P
set synmaxcol=1024
set tabstop=4
set tags=./tags;,$PWD/tags
set undofile
set updatetime=300
set wildmode=longest,list,full
set winminheight=0
set guicursor=n-v-c-sm:block,i-ci-ve:ver25,r-cr-o:hor20

call plug#begin('~/.vim/extensions')

" text search
Plug 'rking/ag.vim'
let g:ag_apply_lmappings = 0
let g:ag_apply_qmappings = 0
let g:ag_highlight = 0

" list buffers
Plug 'jlanzarotta/bufexplorer'
let g:bufExplorerDisableDefaultKeyMapping = 1
let g:bufExplorerFindActive = 0
let g:bufExplorerShowRelativePath = 1

" file search
Plug 'junegunn/fzf.vim'
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
let g:fzf_buffers_jump = 0
let g:fzf_history_dir = '~/.local/share/fzf-history'

" edit gpg files
Plug 'jamessan/vim-gnupg'
let g:GPGPreferSymmetric = 1

" file explorer
Plug 'preservim/nerdtree'
let NERDTreeWinSize = 35
let NERDTreeQuitOnOpen = 1
let g:NERDTreeDirArrows = 1
let g:NERDTreeMapJumpFirstChild = ""
let g:NERDTreeMapJumpLastChild = ""
let g:NERDTreeCustomOpenArgs = {'file': {'reuse': 'currenttab'}} " Currently not working due: https://github.com/preservim/nerdtree/issues/1168

" text navigation
Plug 'justinmk/vim-sneak'
nmap <leader>(disable-default-SneakForward) <Plug>SneakForward
nmap <leader>(disable-default-SneakBackward) <Plug>SneakBackward

" format text
Plug 'godlygeek/tabular'
let g:tabular_default_format = 'l0'

" auto save
Plug '907th/vim-auto-save'
let g:auto_save = 0
let g:auto_save_events = ["CursorHold"]
let g:auto_save_silent = 1

" IDE tooling
Plug 'neoclide/coc.nvim', {'branch': 'release'}
let g:coc_start_at_startup = 1
let g:coc_global_extensions = [
    \ 'coc-css',
    \ 'coc-html',
    \ 'coc-json',
    \ 'coc-omnisharp',
    \ 'coc-phpls',
    \ 'coc-python',
    \ 'coc-tailwindcss',
    \ 'coc-tsserver',
    \ 'coc-vimlsp',
\ ]

" outline
Plug 'majutsushi/tagbar'
let g:tagbar_ctags_bin = "/usr/local/bin/ctags"
let g:tagbar_map_showproto = ""
let g:tagbar_autoclose = 1
let g:tagbar_autofocus = 1
let g:tagbar_type_typescript = {
    \ 'ctagstype': 'typescript',
    \ 'kinds' : [
        \ 'v:global variables:0:0',
        \ 'c:classes',
        \ 'p:properties:0:0',
        \ 'm:methods',
        \ 'f:functions',
        \ '?:unknown',
    \ ],
    \ 'sort': 0,
    \ 'deffile': '~/.ctags.d/main.ctags'
    \ }

" close tags
Plug 'alvan/vim-closetag'
let g:closetag_close_shortcut = ''
let g:closetag_filetypes = 'html,xhtml,phtml,blade,javascriptreact,typescriptreact'
let g:closetag_xhtml_filetypes = 'xhtml,javascriptreact,typescriptreact'

" refactoring for php
Plug 'phpactor/phpactor', {'for': 'php', 'branch': 'master', 'do': 'composer install --no-dev -o'}

" syntax support
Plug 'sheerun/vim-polyglot'
let g:polyglot_disabled = ['sensible', 'graphql', 'csv', 'smarty']

" smarty syntax
Plug 'blueyed/smarty.vim'

" new parser for syntax highlighting
if has('nvim')
    Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
endif

" git integration
Plug 'tpope/vim-fugitive'

" (un)comment code
Plug 'tpope/vim-commentary'

" colorschemes
Plug 'flazz/vim-colorschemes'
Plug 'bluz71/vim-moonfly-colors'
Plug 'bluz71/vim-nightfly-guicolors'

" generate markup
Plug 'mattn/emmet-vim'

" respect editorconfig
Plug 'editorconfig/editorconfig-vim'

" undo history
Plug 'mbbill/undotree'

" comments for tsconfig.json
Plug 'neoclide/jsonc.vim'

" unittests for vimscript
Plug 'junegunn/vader.vim'

" Ultisnips
Plug 'sirver/ultisnips'
let g:UltiSnipsExpandTrigger = '<s-tab>'

call plug#end()

" treesitter configuration
if has('nvim')
    lua <<EOF
    require'nvim-treesitter.configs'.setup {
      highlight = {
        enable = false,
      },
      incremental_selection = {
        enable = false,
        keymaps = {
          init_selection = "gnn",
          node_incremental = "grn",
          scope_incremental = "grc",
          node_decremental = "grm",
        },
      },
      indent = {
        enable = false
      }
    }
EOF
endif

let cs = exists('g:GtkGuiLoaded') ? 'nightfly' : 'hybrid'
if !empty(globpath(&rtp, 'colors/'.cs.'.vim'))
    execute "colorscheme ".cs
    let loaded_matchparen=1
    syntax sync minlines=256
endif
