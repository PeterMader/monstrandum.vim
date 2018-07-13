let g:monstrandum_loaded = 0

function! s:SetDefault (varname, default)
    if !exists("g:" . a:varname)
        execute "let g:" . a:varname . "=" . a:default
    endif
endfunction

" set the defaults for global settings
call s:SetDefault("monstrandum_new_tab", 1)
call s:SetDefault("monstrandum_slide_separator", '"^\\s*---\\+\\s*$"')

function! s:Nop ()
endfunction

" define the public commands for
" controlling the presentation
command! -nargs=1 -complete=file StartPresentation call monstrandum#StartPresentation(<f-args>)
command! NextSlide       call monstrandum#NextSlide()
command! PrevSlide       call monstrandum#PrevSlide()
command! EndPresentation call monstrandum#EndPresentation()

" Add nops so that Vim will not complain about
" missing autocmd for the custom events
autocmd  User PresentationStart     call s:Nop()
autocmd  User PresentationShowSlide call monstrandum#ShowSlideNumber()
autocmd  User PresentationEnd       call s:Nop()
