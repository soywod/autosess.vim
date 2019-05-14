if exists('g:autosess_loaded') | finish | endif
let g:autosess_loaded = 1

let s:default_folder = resolve(expand('<sfile>:h:h') . '/sessions')
let s:folder = get(g:, 'autosess_folder' , s:default_folder)
let s:filename = substitute(getcwd(), '[:\\/-_#.%]', '', 'g')
let s:session = resolve(s:folder . '/' . s:filename)

function! s:init()
  if !v:this_session
    let v:this_session = s:session
  endif
endfunction

function! s:restore()
  if !argc() && filereadable(v:this_session)
    silent execute 'source ' . v:this_session
  endif
endfunction

function! s:save()
  if !isdirectory(s:folder)
    call mkdir(s:folder, 'p', 0700)
  endif

  silent execute 'mksession! ' . v:this_session
endfunction

augroup autosess
  autocmd!
  autocmd VimEnter  *        call s:init()
  autocmd VimEnter  * nested call s:restore()
  autocmd VimLeave  *        call s:save()
augroup end
