function! GetNerdtreePath()
    return fnamemodify(b:NERDTree.ui.getPath(line(".")).str(), ':p:.')
endfunction

function! GetQuickfixFiles()
    return join(uniq(sort(map(filter(getqflist(), 'v:val["valid"] == 1'), 'fnameescape(bufname(get(v:val, "bufnr")))'))))
endfunction

function! SetSearchBuffer()
    let word = '\<' . expand('<cword>') . '\>'

    if @/ == word
        let @/ = expand('<cword>')
    else
        let @/ = word
    endif

    call histadd('search', @/)
    normal hebhn
    redraw
endfunction

function! VisualSetSearchBuffer()
    let escaped = substitute(GetVisualSelection(), '\v([#\\/])', '\\\1', 'g')
    let @/ = '\V' . escaped
    call histadd('search', @/)
    normal n
    redraw
endfunction

function! GetVisualSelection()
    let [lnum1, col1] = getpos("'<")[1:2]
    let [lnum2, col2] = getpos("'>")[1:2]
    let lines = getline(lnum1, lnum2)
    let lines[-1] = lines[-1][: col2 - (&selection == 'inclusive' ? 1 : 2)]
    let lines[0] = lines[0][col1 - 1:]
    return join(lines, "\n")
endfunction

function! SwapRegisters(registers)
    if strlen(a:registers) == 2
        let reg_a = a:registers[0]
        let reg_b = a:registers[1]
        call s:SwapRegisters(reg_a, reg_b)
        echom 'Registers ' . reg_a . ' and ' . reg_b  . ' swapped!'
    else
        echom 'No registers swapped! (' . a:registers . ')'
    endif
endfunction

function! s:SwapRegisters(a, b)
    execute 'silent! :let tmp = @' . a:a
    execute 'silent! :let @' . a:a . ' = @' . a:b
    execute 'silent! :let @' . a:b . ' = tmp'
endfunction

function! OpenChangedFiles(upstream)
    let git_cmd = [
        \ "git diff --name-status",
        \ "git diff --staged --name-status",
        \ "git ls-files . --exclude-standard --others",
        \]

    if !empty(a:upstream)
        call add(git_cmd, "git diff ".a:upstream."...HEAD --name-status")
    endif

    let files = []
    for cmd in git_cmd
        let files += split(system(cmd . " | grep -v '^D	' | sed -r -e 's/^.*	(.*)$/\\1/'"), '\n')
    endfor

    let prefix = trim(system('git rev-parse --show-prefix . | head -n1'))
    if prefix != ''
        let files_rel = []
        for file in files
            let file_rel = substitute(file, prefix, '', '')
            call add(files_rel, file_rel)
        endfor
        let files = files_rel
    endif

    for file in files
        if filereadable(file)
            execute "edit " . substitute(file, ' ', '\\ ', 'g')
        endif
    endfor
endfunction
