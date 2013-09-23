if exists("g:maestro_loaded")
  finish
endif
let g:maestro_loaded = 1

let s:save_cpo = &cpo
set cpo&vim

let s:supported_css_formats = {
      \'css': expand("~/.maestro/bin/maestro-push-css"),
      \'sass': expand("~/.maestro/bin/maestro-push-sass"),
      \'scss': expand("~/.maestro/bin/maestro-push-scss"),
      \'less': expand("~/.maestro/bin/maestro-push-less"),
      \'styl': expand("~/.maestro/bin/maestro-push-styl"),
      \}

function! s:push_style_to_maestro(format)
  let l:maestro_command = get(s:supported_css_formats, a:format, "invalid")
  if l:maestro_command ==# "invalid"
    echomsg printf("ERROR: Extension '%s' not supported by maestro.", a:format)
    return
  endif
  silent exec "w !" . l:maestro_command . "&"
endfunction

function! s:maestro_enable_auto_css_push()
  let s:maestro_updatetime_backup = &updatetime
  set updatetime=800
  let g:maestro_auto_css_on = 1
  augroup maestro_aug
    autocmd!
    au! CursorHoldI <buffer> call <SID>push_style_to_maestro(&filetype)
    au! InsertLeave <buffer> call <SID>push_style_to_maestro(&filetype)
  augroup END
endfunction

function! s:maestro_disable_auto_css_push()
  set updatetime = s:maestro_updatetime_backup
  let g:maestro_auto_css_on = 0
  augroup maestro_aug
    autocmd!
  augroup END
endfunction

function! s:maestro_toggle_auto_css_push()
  if exists("g:maestro_auto_css_on") && g:maestro_auto_css_on
    call s:maestro_disable_auto_css_push()
  else
    call s:maestro_enable_auto_css_push()
  endif
endfunction

command! MaestroCssPush execute <SID>push_style_to_maestro(&filetype)
command! MaestroToggleCssAutoPush execute <SID>maestro_toggle_auto_css_push()
command! MaestroCssAutoPush execute <SID>maestro_enable_auto_css_push()
command! MaestroDisableCssAutoPush execute <SID>maestro_disable_auto_css_push()

let &cpo = s:save_cpo
unlet s:save_cpo
