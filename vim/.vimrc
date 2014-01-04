set nocompatible
set tabstop=4
set shiftwidth=4
set autoindent
set ai
set smartindent
set showmatch
set expandtab
set number
set mouse=a

set wildmenu
set wildignore=*.class,*.pyc
set path=**
set suffixesadd=.java,.py,.xml

set tags+=.tags

set nofoldenable
set foldmethod=syntax

filetype off		" required!

set rtp+=~/.vim/bundle/vundle/
call vundle#rc()

" let Vundle manage Vundle
" required
Bundle 'gmarik/vundle'

Bundle 'tpope/vim-fugitive'
Bundle 'scrooloose/nerdtree'
Bundle 'Twinside/vim-haskellFold'
" Django Testing
Bundle 'https://github.com/JarrodCTaylor/vim-python-test-runner'
" Syntax checking
Bundle 'https://github.com/scrooloose/syntastic'
" Haskell Dev
Bundle 'bitc/vim-hdevtools'
" Tag Bar
Bundle 'majutsushi/tagbar'
" Indenting
Bundle 'godlygeek/tabular'
"Editing
Bundle 'junegunn/goyo.vim'
"Auto Completion
" Needs vim 7.3.885+ with lua. Haven't gotten it built yet.
Bundle 'Shougo/neocomplete.vim'

filetype plugin indent on " required!

syntax on
let mapleader = ","
set list
set listchars=tab:▸\ ,trail:⋅,nbsp:⋅

" status line information
set laststatus=2
set statusline=%f\ %m\ %{fugitive#statusline()}\ %=%([%l,%v\-%P]%)

"color scheme
:colorscheme desert

" VimTip 1386
" Better word suggestion on ^p
:set completeopt=longest,menuone
:inoremap <expr> <CR> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"

" Haddock browser for haskell mode plugin.
let g:haddock_browser="/usr/bin/chromium-browser"

" For texsuite
set grepprg=grep\ -nH\ $*
let g:tex_flavor='latex'
set clipboard=unnamed

" Use the system clipboard for the unamed buffer. Yank between terminals, etc.


" Toggle line numbers
map <F1> :set nu!<CR>
map <F1> :set relativenumber!<CR>
" Map NERDTree shortcut
map <F2> :NERDTreeToggle<CR>
map <C-F2> :JavaBrowser<CR>
map <F3> :set paste!<CR>
map <F5> :make<CR>
" Generate tags for cxx project
map <C-F11> :JavaBrowser<CR>
map <C-F12> :!ctags -R --sort=yes --c++-kinds=+p --fields=+iaS --extra=+q .<CR>

" Django Testing Shortcuts
nnoremap<Leader>da :DjangoTestApp<CR>
nnoremap<Leader>df :DjangoTestFile<CR>
nnoremap<Leader>dc :DjangoTestClass<CR>
nnoremap<Leader>dm :DjangoTestMethod<CR>
nnoremap<Leader>nf :NosetestFile<CR>
nnoremap<Leader>nc :NosetestClass<CR>
nnoremap<Leader>nm :NosetestMethod<CR>
nnoremap<Leader>rr :RerunLastTests<CR>

" Haskell
map <silent> tu :call GHC_BrowseAll()<CR>
map <silent> tw :call GHC_ShowType(1)<CR>
au FileType haskell nnoremap <buffer> <F4> :HdevtoolsType<CR>
au FileType haskell nnoremap <buffer> <silent> <F5> :HdevtoolsClear<CR>
au FileType haskell nnoremap <buffer> <silent> <F6> :HdevtoolsInfo<CR>

" ~/.vimrc ends here
