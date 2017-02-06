" vim-godebug.vim - Go debugging for Vim
" Maintainer:    Luca Guidi <https://lucaguidi.com>
" Version:       0.1

if exists("g:godebug_loaded_install")
  finish
endif
let g:godebug_loaded_install = 1

" Set a global list of breakpoints, if not already exist
if !exists("g:godebug_breakpoints")
  let g:godebug_breakpoints = []
endif

if !exists("g:godebug_breakpoints_file")
  let g:godebug_breakpoints_file = '.gobreakpoints'
endif

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
  let args = ["debug", "--init=" . g:godebug_breakpoints_file]

  " FIXME: this doesn't works for Vim 8
  " if go#util#has_job()
  "   " use vim's job functionality to call it asynchronously
  "   let job_args = {
  "         \ 'cmd': ['dlv'] + args,
  "         \ 'bang': a:bang,
  "         \ }

  "   call s:cmd_job(job_args)
  "   return
  " elseif has('nvim')
    " use nvims's job functionality
    if get(g:, 'go_term_enabled', 0)
      let id = go#term#new(a:bang, ["dlv"] + args)
    else
      let id = go#jobcontrol#Spawn(a:bang, "dlv", args)
    endif

    return id
  " endif
endfunction
" }}}1

" " Public functions {{{1
" function! GoToggleBreakpoint()
"   call godebug#toggleBreakpoint(expand('%:p'), line('.'))
" endfunction

" function! GoDebug()
"   call godebug#debug()
" endfunction
" " }}}1
command! -nargs=* -bang GoToggleBreakpoint call godebug#toggleBreakpoint(expand('%:p'), line('.'), <f-args>)
command! -nargs=* -bang GoDebug call godebug#debug(<bang>0, 0, <f-args>)
