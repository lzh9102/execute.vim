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

function! s:GetInterpreter()
  " shebang line takes precedence
  let l:interpreter = s:GetInterpreterFromShebangLine()
  if !empty(l:interpreter)
    return l:interpreter
  endif
  " if there is no shebang line, get the interpreter from the global setting
  if has_key(g:execute_interpreters, &filetype)
    return g:execute_interpreters[&filetype]
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
  let l:interpreter = s:GetInterpreter()
  let l:argstr = s:BuildArgString(a:000)
  let l:filename = fnameescape(expand("%"))
  if !empty(l:interpreter)
    execute("!" . l:interpreter . " " . l:filename . " " . l:argstr)
  else
    echo "The file doesn't assign an interpreter!"
  end
endfunction

let s:prompt_arguments = " "
function! s:ExecutePromptForArguments()
  call inputsave()
  let l:arguments = input('Arguments: ', s:prompt_arguments)
  call inputrestore()
  if !empty(l:arguments)
    execute "Execute " . l:arguments
    let s:prompt_arguments = l:arguments
  end
endfunction

if !exists("g:execute_interpreters")
  " map filetype to interpreter
  let g:execute_interpreters = {
        \ 'python': 'python',
        \ 'ruby': 'ruby',
        \ 'perl': 'perl',
        \ 'sh': 'sh',
        \ }
endif

command! -nargs=* Execute call s:Execute(<f-args>)
command! ExecutePromptForArguments call s:ExecutePromptForArguments()
