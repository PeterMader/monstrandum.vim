if g:monstrandum_loaded
    finish
endif

let g:monstrandum_loaded = 1

function! s:SplitSlides (lines)
    let slides = []
    let slide = []
    for line in a:lines
        if line =~ g:monstrandum_slide_separator
            call add(slides, slide)
            let slide = []
        else
            call add(slide, line)
        endif
    endfor

    call add(slides, slide)

    return slides
endfunction

function! s:ClearBuffer ()
    silent %delete _
endfunction

function! s:PresentationRunning ()
    return exists("b:slides")
endfunction

function! monstrandum#ShowSlideNumber ()
    echo "Slide" (b:slide_index + 1) "of" b:slides_num
endfunction

function! s:ShowSlide ()
    if (b:slide_index < b:slides_num)
        call s:ClearBuffer()
        call append(0, b:slides[b:slide_index])
        $delete

        doautocmd User PresentationShowSlide
    endif
endfunction

function! monstrandum#NextSlide ()
    if !s:PresentationRunning()
        return
    endif

    if b:slide_index < b:slides_num - 1
        let b:slide_index += 1
        call s:ShowSlide()
    endif
endfunction

function! monstrandum#PrevSlide ()
    if !s:PresentationRunning()
        return
    endif

    if b:slide_index > 0
        let b:slide_index -= 1
        call s:ShowSlide()
    endif
endfunction

function! s:MakePresWindow (bufname)
    if g:monstrandum_new_tab
        tab new
    else
        vnew 
    endif

    execute "silent edit " . a:bufname
    call s:ClearBuffer()
    set buftype=nofile
endfunction

function! monstrandum#StartPresentation (path)
    let bufname = "Presentation_" . fnamemodify(a:path, ":t")

    if buflisted(bufname)
        echoerr "File " . a:path . " is already being displayed as a presentation"
        return
    endif

    call s:MakePresWindow(bufname)

    let b:slides = s:SplitSlides(readfile(a:path))
    let b:slides_num = len(b:slides)
    let b:slide_index = 0

    doautocmd User PresentationStart
    call s:ShowSlide()
endfunction

function! monstrandum#EndPresentation ()
    doautocmd User PresentationEnd
    bd
endfunction
