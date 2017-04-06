" vim-godebug.vim - Go debugging for Vim
" Maintainer:    Luca Guidi <https://lucaguidi.com>
" Version:       0.1

if !has("nvim")
  echom "vim-godebug: vim is not yet supported, try it with neovim"
  finish
endif

if exists("g:godebug_loaded_install")
  finish
endif
let g:godebug_loaded_install = 1

" Set a global list of breakpoints, if not already exist
if !exists("g:godebug_breakpoints")
  let g:godebug_breakpoints = []
endif

" make cache base path overridable
if !exists("g:godebug_cache_path")
  " this will probably suck for people using windows ...
  let g:godebug_cache_path = $HOME . "/.cache/" . v:progname . "/vim-godebug"
endif

" make sure cache base path exists
call mkdir(g:godebug_cache_path, "p")

" create a reasonably unique breakpoints file path per vim instance
let g:godebug_breakpoints_file = g:godebug_cache_path . "/". getpid() . localtime()

autocmd VimLeave * call godebug#deleteBreakpointsFile()<cr>

" Private functions {{{1
function! godebug#toggleBreakpoint(file, line, ...) abort
  " Compose the breakpoint for delve:
  " Example: break /home/user/path/to/go/file.go:23
  let breakpoint = "break " . a:file. ':' . a:line

  " Define the sign for the gutter
  exe "sign define gobreakpoint text=◉ texthl=Search"

  " If the line isn't already in the list, add it.
  " Otherwise remove it from the list.
  let i = index(g:godebug_breakpoints, breakpoint)
  if i == -1
    call add(g:godebug_breakpoints, breakpoint)
    exe "sign place ". a:line ." line=" . a:line . " name=gobreakpoint file=" . a:file
  else
    call remove(g:godebug_breakpoints, i)
    exe "sign unplace ". a:line ." file=" . a:file
  endif
endfunction

function! godebug#writeBreakpointsFile(...) abort
  call writefile(g:godebug_breakpoints + ["continue"], g:godebug_breakpoints_file)
endfunction

function! godebug#deleteBreakpointsFile(...) abort
  if filereadable(g:godebug_breakpoints_file)
    call delete(g:godebug_breakpoints_file)
  endif
endfunction

function! godebug#debug(bang, ...) abort
  call godebug#writeBreakpointsFile()
  return go#term#new(a:bang, ["dlv", "debug", "--init=" . g:godebug_breakpoints_file])
endfunction

function! godebug#test(bang, ...) abort
  call godebug#writeBreakpointsFile()
  return go#term#new(a:bang, ["dlv", "test", "--init=" . g:godebug_breakpoints_file])
endfunction

command! -nargs=* -bang GoToggleBreakpoint call godebug#toggleBreakpoint(expand('%:p'), line('.'), <f-args>)
command! -nargs=* -bang GoDebug call godebug#debug(<bang>0, 0, <f-args>)
command! -nargs=* -bang GoDebugTest call godebug#test(<bang>0, 0, <f-args>)
