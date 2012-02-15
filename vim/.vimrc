set tabstop=4
set shiftwidth=4
set autoindent
set ai
set smartindent
set showmatch
set expandtab
set number
set mouse=a
"set makeprg=ant\ -emacs

"folding: http://smartic.us/2009/04/06/code-folding-in-vim/
"set foldmethod=indent   "fold based on indent
"set foldnestmax=10      "deepest fold is 10 levels
"set nofoldenable        "dont fold by default
"set foldlevel=1         "this is just what i use

set nofoldenable
set foldmethod=syntax

"status line information
set laststatus=2
set statusline=%f\ %m\ %{fugitive#statusline()}\ %=%(%l,%v\-%P]%)

" VimTip 1386
" Better word suggestion on ^p
:set completeopt=longest,menuone
:inoremap <expr> <CR> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"

" Haddock browser for haskellmode plugin
let g:haddock_browser="/usr/bin/chromium-browser"


" ~/.vimrc (configuration file for vim only)
" skeletons
function! SKEL_spec()
	0r /usr/share/vim/current/skeletons/skeleton.spec
	language time en_US
	if $USER != ''
	    let login = $USER
	elseif $LOGNAME != ''
	    let login = $LOGNAME
	else
	    let login = 'unknown'
	endif
	let newline = stridx(login, "\n")
	if newline != -1
	    let login = strpart(login, 0, newline)
	endif
	if $HOSTNAME != ''
	    let hostname = $HOSTNAME
	else
	    let hostname = system('hostname -f')
	    if v:shell_error
		let hostname = 'localhost'
	    endif
	endif
	let newline = stridx(hostname, "\n")
	if newline != -1
	    let hostname = strpart(hostname, 0, newline)
	endif
	exe "%s/specRPM_CREATION_DATE/" . strftime("%a\ %b\ %d\ %Y") . "/ge"
	exe "%s/specRPM_CREATION_AUTHOR_MAIL/" . login . "@" . hostname . "/ge"
	exe "%s/specRPM_CREATION_NAME/" . expand("%:t:r") . "/ge"
	setf spec
endfunction
autocmd BufNewFile	*.spec	call SKEL_spec()
" filetypes
filetype plugin on
filetype indent on

au filetype java setlocal mp=ant\ -emacs
au FileType python set omnifunc=pythoncomplete#Complete
let g:SuperTabDefaultCompletionType = "context"
set completeopt=menuone,longest,preview

syntax on

"LaTex Suite
"Make sure grep always generates a file name
set grepprg=grep\ -nH\ $*
"Ensure latex-suite gets load. Will default to plaintex.
let g:tex_flavor='latex'


" Map NERDTree shortcut
map <F2> :NERDTreeToggle<CR>
" Toggle line numbers
map <F1> :set nu!<CR>
map <F5> :make <CR>
map <C-F12> :!ctags -R --sort=yes --c++-kinds=+p --fields=+iaS --extra=+q .<CR>

let g:tex_flavor='latex'

:command! -nargs=+ Calc :py print <args>
:py from math import *
" ~/.vimrc ends here
