monstrandum.vim
================================================================================

*A plugin for displaying presentations within Vim.*

This README as a presentation in Vim:

![demo/monstrandum.gif](demo/monstrandum.gif)

Monstrandum works great in combination with
[goyo.vim](https://github.com/junegunn/goyo.vim).

<!-- next_slide -->
Agenda
================================================================================

1. Introduction
2. Installation
3. Usage
4. Configuration
5. Callbacks
6. Inspiration
7. License

<!-- next_slide -->
Introduction
================================================================================

* Monstrandum displays a text file (like this markdown file) as a
  presentation
* the text file is split up into slides
* slides are separated by lines matching a pattern
* by default, this separator is `---`. Example:

```markdown
    This is the first slide.
    ---
    This is the second slide.
      ------- 
    This is the third slide.
```

<!-- next_slide -->
Installation
================================================================================

Monstrandum should be installable with any plugin manager.

<!-- next_slide -->
Usage
================================================================================

Monstrandum provides four commands that control the presentation:

* `:StartPresentation {file}`:
  Runs `{file}` as a presentation.
* `:NextSlide`:
  Moves to the next slide.
* `:PrevSlide`:
  Moves to the previous slide.
* `:EndPresentation`:
  Ends the presentation.

<!-- next_slide -->
Configuration
================================================================================

Monstrandum allows you to set two special global variables:

* `g:monstrandum_new_tab`:
  When set to `1`, presentations will be opened in a new tab (this is
  the default setting).
  When set to `0`, presentations will be opened in a vertical split.

* `g:monstrandum_slide_separator`: a regexp pattern that specifies the
  the line separator. The pattern is applied to single lines.
  Default value: `"^\\s*---\\+\\s*$"` (this matches three or more
  dashes, optionally preceded or followed by whitespace)

<!-- next_slide -->
Callbacks
================================================================================

Monstrandum provides three events:

* `PresentationStart`:
  This event fires when a presentation starts.
* `PresentationShowSlide`:
  This event fires when a new slide is displayed.
* `PresentationEnd`:
  This event fires when a presentation ends.

<!-- next_slide -->
These events can be used customize Monstrandum. Example:

```vimscript
" this configuration is used in this demo
function! s:my_presentation_start ()
    " start Goyo
    Goyo

    " arrow keys to move forward and backward, q to quit
    noremap <buffer> <Left>  :PrevSlide<CR>
    noremap <buffer> <Right> :NextSlide<CR>
    noremap <buffer> q       :EndPresentation<CR>
endfunction

" whenever a presentation starts, call `s:my_presentation_start`
autocmd! User PresentationStart call <SID>my_presentation_start()
```

<!-- next_slide -->
Inspiration
================================================================================

* [presenting.vim](https://github.com/sotte/presenting.vim)
* [vimdeck](https://github.com/tybenz/vimdeck)

<!-- next_slide -->
License
================================================================================

Monstrandum is released under the MIT license.
