" Vim syntax file
" Language:     Panini
" Maintainer:   Sean L. Moooney <smooney@iastate.edu>
" URL:
" Last Change:  May 06, 2012
"
" Heavily based on the ptomely syntax highlighting.
" (http://www.cs.iastate.edu/~ptolemy/syntax/ptolemy.vim)


"Quit if a syntax file already loaded
if !exists("main_syntax")
    if version < 600
        syntax clear
    elseif exists("b:current_syntax")
        finish
    endif
    " Define main syntax --lets other included files test for it.
    let main_syntax='panini'
endif

runtime! syntax/java.vim

" New keywords
syn keyword javaClassDecl   capsule system signature


