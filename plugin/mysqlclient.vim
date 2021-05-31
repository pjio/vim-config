" Usage:
" 1. Configure a connection in $HOME/.my.cnf
" ```
" [clientCUSTOM_GROUP_SUFFIX]
" host=127.0.0.1
" user=root
" password=
" ```
"
" 2. Set variables in vim
" let g:mysql_group_suffix = "CUSTOM_GROUP_SUFFIX"
" let g:mysql_database     = "CUSTOM_DATABASE"
" let g:mysql_results      = "~/results.sql"
" let g:mysql_queries      = "~/queries.sql"
"
" 3. Open the interface
" :UtilsMysqlStart<cr>
"
" 4. Write a query into the upper buffer
" ..............................
" . select count(*) from user  .
" .                            .
" ..............................
" .                            .
" .                            .
" ..............................
"
" 5. Place the cursor in the same line as the query and call:
" :UtilsMysqlQuery<cr>
"
" 6. The result will be fetched into the lower buffer:
" ..............................
" . select count(*) from user  .
" .                            .
" ..............................
" . select count(*) from user  .
" . +----------+               .
" . | count(*) |               .
" . +----------+               .
" . |        5 |               .
" . +----------+               .
" ..............................
"
" 7. Write multiple queries in separate lines and save the file [optional]
"    Repeat (5.) to run different queries.
" ..............................
" . select count(*) from user  .
" . select * from user         .
" . -- delete from user        .
" ..............................
"
" 8. Close tabpage [optional]
" :tabclose<cr>

command! UtilsMysqlStart call s:start()
command! -range UtilsMysqlQuery <line1>,<line2>call s:query()
command! UtilsMysqlDump call s:dump()

function! s:start()
    tabnew
    if !empty(get(g:, 'mysql_results'))
        execute "edit ".expand(g:mysql_results)
    endif
    set nowrap
    set syntax=sql

    new
    if !empty(get(g:, 'mysql_queries'))
        execute "edit ".expand(g:mysql_queries)
    endif
    set nowrap
    set syntax=sql
    let b:mysql_queries_file = 1
endfunction

function! s:query() range
    if empty(get(g:, 'mysql_group_suffix'))
        echo 'UtilsMysqlQuery: g:mysql_group_suffix not set!'
        return
    endif

    if empty(get(g:, 'mysql_database'))
        echo 'UtilsMysqlQuery: g:mysql_database not set!'
        return
    endif

    if empty(get(b:, 'mysql_queries_file'))
        echo 'UtilsMysqlQuery: b:mysql_queries_file not set!'
        return
    endif

    let lines = getline(a:firstline, a:lastline)
    let sql = join(lines, ' ')

    wincmd j
    call append(0, [sql, sql])
    execute "normal :2!mysql --defaults-group-suffix=".g:mysql_group_suffix." --database=".g:mysql_database." -t\<cr>"
    normal gg
    wincmd k
endfunction

function! s:dump()
    call histadd(':', 'r!mysqldump --defaults-group-suffix='.g:mysql_group_suffix.' --no-create-info --skip-comments --skip-extended-insert --complete-insert --compact --databases '.g:mysql_database.' --tables  --where=''1=1''')
    call feedkeys('q:k$F i', 'in')
endfunction
