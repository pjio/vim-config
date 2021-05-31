" override
map <space> \
nnoremap <c-h> 5h
nnoremap <c-j> 5j
nnoremap <c-k> 5k
nnoremap <c-l> 5l
nnoremap <c-]> g<c-]>
nnoremap <c-p> :cprev<cr>
nnoremap <c-n> :cnext<cr>
vnoremap <c-h> 5h
vnoremap <c-j> 5j
vnoremap <c-k> 5k
vnoremap <c-l> 5l
nnoremap <expr> Q tabpagenr()==1 && len(tabpagebuflist())==1 ? ":echo 'beep boop'\<cr>" : &buftype == "nofile" ? ":bd!\<cr>" : ":q\<cr>"
inoremap ,, ,<cr>
"inoremap ;; ;<cr>
inoremap jk <esc>
cnoremap <c-j> <down>
cnoremap <c-k> <up>
inoremap <c-h> <left>
inoremap <c-l> <right>
inoremap <expr> <cr> strpart(getline('.'), col('.') -2, 3) == '></' ? "\<cr>\<esc>O" : "\<cr>"

" coc.nvim
nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)
inoremap <silent><expr> <c-space> coc#refresh()
inoremap <silent><expr> <TAB>
    \ pumvisible() ? "\<C-n>" :
    \ coc#expandable() ? "\<C-r>=coc#rpc#request('doKeymap', ['snippets-expand',''])\<CR>" :
    \ <SID>check_back_space() ? "\<TAB>" :
    \ coc#refresh()
function! s:check_back_space() abort
    let col = col('.') - 1
    return !col || getline('.')[col - 1]  =~# '\s'
endfunction
xmap if <Plug>(coc-funcobj-i)
omap if <Plug>(coc-funcobj-i)
xmap af <Plug>(coc-funcobj-a)
omap af <Plug>(coc-funcobj-a)
xmap ic <Plug>(coc-classobj-i)
omap ic <Plug>(coc-classobj-i)
xmap ac <Plug>(coc-classobj-a)
omap ac <Plug>(coc-classobj-a)

" <leader>0-9
nnoremap <leader>1 :call UltiSnips#LeavingBuffer()<cr>1gt
nnoremap <leader>2 :call UltiSnips#LeavingBuffer()<cr>2gt
nnoremap <leader>3 :call UltiSnips#LeavingBuffer()<cr>3gt
nnoremap <leader>4 :call UltiSnips#LeavingBuffer()<cr>4gt
nnoremap <leader>5 :call UltiSnips#LeavingBuffer()<cr>5gt
nnoremap <leader>6 :call UltiSnips#LeavingBuffer()<cr>6gt
nnoremap <leader>7 :call UltiSnips#LeavingBuffer()<cr>7gt
nnoremap <leader>8 :call UltiSnips#LeavingBuffer()<cr>8gt
nnoremap <leader>9 :call UltiSnips#LeavingBuffer()<cr>9gt

" <leader>a
xmap <leader>a <Plug>(coc-format-selected)
nmap <leader>A <Plug>(coc-format-selected)

" <leader>b
nnoremap <leader>b :b#<cr>

" <leader>c
nnoremap <leader>C :let @" = @%<cr>
xmap <leader>ca  <Plug>(coc-codeaction-selected)
nmap <leader>ca  <Plug>(coc-codeaction-selected)
nmap <leader>cA  <Plug>(coc-codeaction)
nmap <leader>cf  <Plug>(coc-fix-current)
nnoremap <silent> <leader>cd :<C-u>CocList diagnostics<cr>
nnoremap <silent> <leader>ce :<C-u>CocList extensions<cr>
nnoremap <silent> <leader>cm :<C-u>CocList commands<cr>
nnoremap <silent> <leader>co :<C-u>CocList outline<cr>
nnoremap <silent> <leader>cs :<C-u>CocList -I symbols<cr>
nnoremap <silent> <leader>cn :<C-u>CocNext<CR>
nnoremap <silent> <leader>cp :<C-u>CocPrev<CR>
nnoremap <silent> <leader>cr :<C-u>CocListResume<CR>

" <leader>d

" <leader>e
nnoremap <leader>e :Buffers<cr>
nnoremap <leader>E :BufExplorer<cr>

" <leader>f
nnoremap <leader>f:  :History:<cr>
nnoremap <leader>f/  :History/<cr>
nnoremap <leader>ft  :Tags<cr>
nnoremap <leader>ff  :NERDTreeFind<cr>
nnoremap <leader>fd  :echo "<leader>fd not set for " . &filetype<cr>
nnoremap <leader>fw  :echo "<leader>fw not set for " . &filetype<cr>
nnoremap <leader>F   :let cmd="Ag ".shellescape(expand('<cword>'), "'")." ./"<cr>:execute cmd<cr>:call histadd(':', cmd)<cr>
nnoremap <leader>fl  :call histadd(':', "Ag --literal --case-sensitive '' ./")                                                          <cr>q:kf';
nnoremap <leader>fml :call histadd(':', "Ag --literal --case-sensitive '' './".expand('%:h')."'")                                       <cr>q:kf';
nnoremap <leader>fnl :call histadd(':', "Ag --literal --case-sensitive '' './".GetNerdtreePath()."'")                      <cr>:wincmd l<cr>q:kf';
nnoremap <leader>f"  :call histadd(':', "Ag --literal --case-sensitive ".shellescape(@", "'")." ./")                                    <cr>q:kf';
nnoremap <leader>fm" :call histadd(':', "Ag --literal --case-sensitive ".shellescape(@", "'")." './".expand('%:h')."'")                 <cr>q:kf';
nnoremap <leader>fn" :call histadd(':', "Ag --literal --case-sensitive ".shellescape(@", "'")." './".GetNerdtreePath()."'")<cr>:wincmd l<cr>q:kf';
nnoremap <leader>f/  :call histadd(':', "Ag --literal --case-sensitive ".shellescape(@/, "'")." ./")                                    <cr>q:kf';
nnoremap <leader>fm/ :call histadd(':', "Ag --literal --case-sensitive ".shellescape(@/, "'")." './".expand('%:h')."'")                 <cr>q:kf';
nnoremap <leader>fn/ :call histadd(':', "Ag --literal --case-sensitive ".shellescape(@/, "'")." './".GetNerdtreePath()."'")<cr>:wincmd l<cr>q:kf';
nnoremap <leader>fr  :cclose<cr>:NERDTreeClose<cr>:argadd .<cr>:argdelete *<cr>:execute "args ".GetQuickfixFiles()<cr>:call histadd(':', 'argdo %s/'.@/.'//gec \| up')<cr>q:kf/;;

" <leader>g
nnoremap <leader>G :Gwrite<cr>
nnoremap <leader>gm :let @/='\v[<=\|>]{7}'<cr>
nnoremap <leader>gj :let l=search('^+++ b/', 'bnW') <cr>:let f=getline(l)[6:]<cr>:execute "tabedit ".escape(f, ' \')<cr>
nnoremap <leader>ge :let l=search('^commit ', 'bnW')<cr>:let h=getline(l)[7:]<cr>:tabnew<cr>:setlocal buftype=nofile nowrap syntax=git<cr>:let c="git show ".h<cr>:call append(0, extend([c, ''], systemlist(c)))<cr>gg
nnoremap <leader>gb :let l=line('.')<cr>:tabnew<cr>:setlocal buftype=nofile nowrap syntax=git<cr>:let c="git blame -- '".@#."'"                    <cr>:call append(0, extend([c, ''], systemlist(c)))<cr>:call cursor(l+2,0)<cr>
nnoremap <leader>gf                     :tabnew<cr>:setlocal buftype=nofile nowrap syntax=git<cr>:let c="git diff -- '".@#."'"                     <cr>:call append(0, extend([c, ''], systemlist(c)))<cr>gg
nnoremap <leader>gF                     :tabnew<cr>:setlocal buftype=nofile nowrap syntax=git<cr>:let c="git diff"                                 <cr>:call append(0, extend([c, ''], systemlist(c)))<cr>gg
nnoremap <leader>gd                     :tabnew<cr>:setlocal buftype=nofile nowrap syntax=git<cr>:let c="git diff -w --follow -- '".@#."'"         <cr>:call append(0, extend([c, ''], systemlist(c)))<cr>gg
nnoremap <leader>gD                     :tabnew<cr>:setlocal buftype=nofile nowrap syntax=git<cr>:let c="git diff -w"                              <cr>:call append(0, extend([c, ''], systemlist(c)))<cr>gg
nnoremap <leader>gs                     :tabnew<cr>:setlocal buftype=nofile nowrap syntax=git<cr>:let c="git diff -w --staged --follow -- '".@#."'"<cr>:call append(0, extend([c, ''], systemlist(c)))<cr>gg
nnoremap <leader>gS                     :tabnew<cr>:setlocal buftype=nofile nowrap syntax=git<cr>:let c="git diff -w --staged"                     <cr>:call append(0, extend([c, ''], systemlist(c)))<cr>gg
nnoremap <leader>gl                     :tabnew<cr>:setlocal buftype=nofile nowrap syntax=git<cr>:let c="git log -- '".@#."'"                      <cr>:call append(0, extend([c, ''], systemlist(c)))<cr>gg
nnoremap <leader>gL                     :tabnew<cr>:setlocal buftype=nofile nowrap syntax=git<cr>:let c="git log"                                  <cr>:call append(0, extend([c, ''], systemlist(c)))<cr>gg

" <leader>h
nnoremap <leader>h :call SetSearchBuffer()<cr>
nnoremap <leader>H :let @/ = ""<cr>
vnoremap <leader>h :call VisualSetSearchBuffer()<cr>

" <leader>i

" <leader>j
nnoremap <leader>j :lnext<cr>

" <leader>k
nnoremap <leader>k :lprev<cr>

" <leader>l
nnoremap <leader>l :echo '<leader>l not set for '.&filetype<cr>
nnoremap <leader>L :lclose<cr>

" <leader>m
nnoremap <leader>m :Macro 

" <leader>n
nnoremap <leader>n :Files<cr>

" <leader>o
nnoremap <leader>o :set paste<cr>o
nnoremap <leader>O :set paste<cr>O

" <leader>p
nnoremap <leader>P =`]
nnoremap <leader>p p=`]


" <leader>q

" <leader>r
nmap <leader>R <Plug>(coc-rename)
nnoremap <silent> <leader>r :call CocActionAsync('jumpReferences')<cr>

" <leader>s
nmap <leader>S <Plug>SneakBackward
nmap <leader>s <Plug>SneakForward

" <leader>t
nnoremap <leader>T  :NERDTreeClose<cr>:TagbarClose<cr>:cclose<cr>:lclose<cr>:pclose<cr>
nnoremap <leader>td :CocDiagnostics<cr>
nnoremap <leader>tn :NERDTree<cr>
nnoremap <leader>tN :NERDTreeClose<cr>
nnoremap <leader>tt :Tagbar<cr>
nnoremap <leader>tT :TagbarClose<cr>
nnoremap <leader>tq :copen<cr>
nnoremap <leader>tQ :cclose<cr>
nnoremap <leader>tl :lopen<cr>
nnoremap <leader>tL :lclose<cr>

" <leader>u
noremap <leader>U  :Utils
noremap <leader>uD :UtilsMysqlStart<cr>
noremap <leader>ud :UtilsMysqlQuery<cr>
noremap <leader>un :UtilsNotes<cr>
noremap <leader>us :UtilsSwapRegisters "+<cr>

" <leader>v

" <leader>w
nnoremap <leader>wh <c-w><Left>
nnoremap <leader>wj <c-w><Down>
nnoremap <leader>wk <c-w><Up>
nnoremap <leader>wl <c-w><Right>
nnoremap <leader>wH <c-w>H
nnoremap <leader>wJ <c-w>J
nnoremap <leader>wK <c-w>K
nnoremap <leader>wL <c-w>L
nnoremap <expr> <leader>wm exists('b:restore_size') ? ":execute b:restore_size\<cr>" : ":let b:restore_size=':resize '.winheight(winnr()).' \| :vertical resize '.winwidth(winnr()).' \| :unlet b:restore_size'\<cr>:resize 999\<cr>:vertical resize 999\<cr>"
nnoremap <leader>wn :call UltiSnips#LeavingBuffer()<cr>:tabn<cr>
nnoremap <leader>wp :call UltiSnips#LeavingBuffer()<cr>:tabp<cr>
nnoremap <leader>W  :silent! wa<cr>
nnoremap <leader>wS :new<cr>
nnoremap <leader>ws :split<cr>
nnoremap <leader>wt :call UltiSnips#LeavingBuffer()<cr>:tabnew<cr>
nnoremap <leader>wV :vnew<cr>
nnoremap <leader>wv :vsplit<cr>
nnoremap <leader>ww :wincmd k<cr>:wincmd l<cr>
nnoremap <leader>wz <c-w><c-z>

" <leader>x

" <leader>y

" <leader>z
