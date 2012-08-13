"From http://vim-latex.sourceforge.net/documentation/latex-suite/recommended-settings.html

set sw=2
" TIP: if you write your \label's as \label{fig:something}, then if you
" type in \ref{fig: and press <C-n> you will automatically cycle through
" all the figure labels. Very useful!
set iskeyword+=:

setl tw=79
" Execute the make program explicitly.
" Quick and dirty way to enable make on a button.
" Somewhere latex suite changes the make definition
" to invoke a latex build for a file.
map <F6> :!make <CR>

