set tabstop=4
set shiftwidth=4
set autoindent
set ai
set smartindent
set showmatch
set expandtab
set number
set mouse=a
set makeprg=ant\ -emacs

set tags+=.tags

set nofoldenable
set foldmethod=syntax

syntax on

" status line information
set laststatus=2
set statusline=%f\ %m\ %{fugitive#statusline()}\ %=%([%l,%v\-%P]%)

" VimTip 1386
" Better word suggestion on ^p
:set completeopt=longest,menuone
:inoremap <expr> <CR> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"

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

" Toggle line numbers
map <F1> :set nu!<CR>
" Map NERDTree shortcut
map <F2> :NERDTreeToggle<CR>
map <F3> :set paste!<CR>
map <F5> :make<CR>
" Generate tags for cxx project
map <C-F12> :!ctags -R --sort=yes --c++-kinds=+p --fields=+iaS --extra=+q .<CR>

" ~/.vimrc ends here
