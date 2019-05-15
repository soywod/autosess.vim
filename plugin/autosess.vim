if exists('g:autosess_loaded') | finish | endif
let g:autosess_loaded = 1

let s:default_folder = resolve(expand('<sfile>:h:h') . '/sessions')
let s:folder = get(g:, 'autosess_folder' , s:default_folder)
let s:filename = substitute(getcwd(), '[:\\/-_#.%]', '', 'g')
let s:session = fnameescape(resolve(s:folder . '/' . s:filename))
let s:folder = fnameescape(s:folder)

function! s:echo_error(message)
  echohl ErrorMsg
  echo printf('[autosess] %s', a:message)
  echohl None
endfunction

function! s:session_init()
  try
    if !v:this_session
      let v:this_session = s:session
    endif
  catch
    call s:echo_error('error while init session')
  endtry
endfunction

function! s:session_load()
  try
    if !argc() && filereadable(v:this_session)
      execute 'source ' . v:this_session
    endif
  catch
    call s:echo_error('error while loading session')
  endtry
endfunction

function! s:session_make()
  try
    if !isdirectory(s:folder)
      call mkdir(s:folder, 'p', 0700)
    endif

    let buffer_is_empty = bufname('%') == ''
    let is_last_buffer  = len(getbufinfo({'buflisted': 1})) <= 1

    if buffer_is_empty && is_last_buffer
      call delete(v:this_session)
    else
      execute 'mksession! ' . v:this_session
    endif
  catch
    call s:echo_error('error while making session')
  endtry
endfunction

function! s:view_load()
  try
    let is_buffer_file = filereadable(bufname('%'))

    if is_buffer_file
      loadview
    endif
  endtry
endfunction

function! s:view_make()
  try
    let is_buftype_normal = &buftype == ''
    let is_buffer_file = filereadable(bufname('%'))

    if is_buftype_normal && is_buffer_file
      mkview
    endif
  catch
    call s:echo_error('error while making view')
  endtry
endfunction

augroup autosess
  autocmd!
  autocmd VimEnter    *         call s:session_init()
  autocmd VimEnter    * nested  call s:session_load()
  autocmd VimLeave    *         call s:session_make()
  autocmd BufWinEnter *         call s:view_load()
  autocmd BufWinLeave *         call s:view_make()
augroup end
