" execute.vim - execute the currently edited script
"
" Author: Che-Huai Lin <lzh9102@gmail.com>
" License: Vim license

function! s:GetInterpreterFromShebangLine()
  let l:shebang_line = getline(1)
  let l:matches = matchlist(l:shebang_line, '^#!\(.*\)$')
  if !empty(l:matches)
    let l:interpreter = l:matches[1]
    return l:interpreter
  else
    return ""
  end
endfunction

function! s:BuildArgString(list)
  let l:args = []
  for item in a:list
    call add(l:args, fnameescape(item))
  endfor
  return join(l:args, " ")
endfunction

function! s:Execute(...)
  let l:interpreter = s:GetInterpreterFromShebangLine()
  let l:argstr = s:BuildArgString(a:000)
  let l:filename = fnameescape(expand("%"))
  if !empty(l:interpreter)
    execute("!" . l:interpreter . " " . l:filename . " " . l:argstr)
  else
    echo "The file doesn't assign an interpreter!"
  end
endfunction

command! Execute call s:Execute()
