" Vim syntax file
" Language:	SMV
" Maintainer:	Armin Biere <Armin.Biere@cs.cmu.edu>
" Last change:	Wed Feb 25 11:36:56 EST 1998
"
" put this into to you ~/.vimrc
"
"    augroup syntax
"    au! BufNewFile,BufReadPost *.smv
"    au  BufNewFile,BufReadPost *.smv  so ~/vim/smv.vim
"    augroup END
"
" ... and save this file as ~/vim/smv.vim ;-)
"
"-------------------------------------------"
" I TESTED THIS ONLY ON A (NON COLOR) XTERM "
"-------------------------------------------"

" Remove any old syntax stuff hanging around
syn clear

" keyword definitions

syn keyword smvKeyword ASYNC
syn keyword smvKeyword MODULE
syn keyword smvKeyword process
syn keyword smvKeyword DEFINE
syn keyword smvKeyword VAR
syn keyword smvKeyword CONSTANT
syn keyword smvKeyword INIT
syn keyword smvKeyword TRANS
syn keyword smvKeyword INVAR
syn keyword smvKeyword FORMAT
syn keyword smvKeyword SPEC
syn keyword smvKeyword COMPUTE
syn keyword smvKeyword FAIRNESS
syn keyword smvKeyword ISA
syn keyword smvKeyword ASSIGN
syn keyword smvKeyword INPUT
syn keyword smvKeyword OUTPUT
syn keyword smvKeyword IMPLEMENTS
syn keyword smvKeyword GOTO
syn keyword smvKeyword LET
syn keyword smvKeyword STEP
syn keyword smvKeyword EVAL
syn keyword smvKeyword RESET
syn keyword smvKeyword EX
syn keyword smvKeyword AX
syn keyword smvKeyword EF
syn keyword smvKeyword AF
syn keyword smvKeyword EG
syn keyword smvKeyword AG
syn keyword smvKeyword E
syn keyword smvKeyword A
syn keyword smvKeyword U
syn keyword smvKeyword BU
syn keyword smvKeyword EBF
syn keyword smvKeyword ABF
syn keyword smvKeyword EBG
syn keyword smvKeyword ABG
syn keyword smvKeyword MIN
syn keyword smvKeyword MAX
syn keyword smvKeyword apropos
syn keyword smvOperator case
syn keyword smvOperator esac
syn keyword smvOperator next
syn keyword smvOperator mod
syn keyword smvOperator init
syn keyword smvOperator sigma
syn keyword smvOperator self
syn keyword smvOperator union
syn keyword smvOperator in

" Types
syn keyword smvType array
syn keyword smvType of
syn keyword smvType boolean

" Operators
syn keyword smvOperator         "<<"
syn keyword smvOperator         ":="
syn keyword smvOperator         "+"
syn keyword smvOperator         "-"
syn keyword smvOperator         "*"
syn keyword smvOperator         "/"
syn keyword smvOperator         "="
syn keyword smvOperator         "<="
syn keyword smvOperator         ">="
syn keyword smvOperator         "<"
syn keyword smvOperator         ">"
syn keyword smvOperator         ".."
syn keyword smvOperator         "."
syn keyword smvOperator         "->"
syn keyword smvOperator         "<->"
syn keyword smvOperator         "|"
syn keyword smvOperator         "&"
syn keyword smvOperator         "!"

" Constants
syn match   smvNumber         "-\=\<[0-9]\+"

"Comment
syn match   smvComment        "--.*"

" Catch mismatched parentheses
syn region smvGeneric         transparent start="\[" end="\]" contains=ALLBUT,smvBracketError
syn region smvParen           transparent start="(" end=")" contains=ALLBUT,smvParenError
syn match smvParenError       ")"
syn match smvBracketError     "]"

syn sync lines=10

if !exists("did_smv_syntax_inits")
  let did_smv_syntax_inits = 1
    " The default methods for highlighting.  Can be overridden later
	  hi link smvKeyword		Statement
	    hi link smvNumber 		Number
		  hi link smvOperator		Special
		    hi link smvComment		Comment
			  hi link smvType	 	Type
			    hi link smvParenError		Error
				  hi link smvBracketError	Error
				  endif

				  let b:current_syntax = "smv"

				  " vim: ts=8

