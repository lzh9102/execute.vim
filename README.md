execute.vim
-----------

Execute the currently edited script.

This script provides two commands `:Execute` and `:ExecutePromptForArguments`
to execute the current script with an interpreter. It first looks for the
shebang line to find a proper interpreter.  If an interpreter is not found, it
falls back to the global setting `g:execute_interpreters`, which maps each
filetype (key) to its interpreter (value).

This plugin doesn't save the file automatically. You have to save the file
before calling `:Execute` or `:ExecutePromptForArguments`.

### License

Copyright (c) 2014 Che-Huai Lin <lzh9102@gmail.com>

This plugin is licensed under the same terms as Vim itself.
