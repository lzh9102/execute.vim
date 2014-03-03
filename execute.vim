" execute.vim - execute the currently edited script
"
" Author: Che-Huai Lin <lzh9102@gmail.com>
" License: Vim license

function! s:GetInterpreterFromShebangLine()
  let shebang_line = getline(1)
  let matches = matchlist(shebang_line, '^#!\(.*\)$')
  if !empty(matches)
    let interpreter = matches[1]
    return interpreter
  else
    return ""
  end
endfunction

function! s:Execute()
  let interpreter = s:GetInterpreterFromShebangLine()
  if !empty(interpreter)
    execute("!" . interpreter . " " . fnameescape(expand("%")))
  else
    echo "The file doesn't assign an interpreter!"
  end
endfunction

command! Execute call s:Execute()
