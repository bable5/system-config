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
" Django Testing
Bundle 'https://github.com/JarrodCTaylor/vim-python-test-runner'
" Syntax checking
Bundle 'https://github.com/scrooloose/syntastic'
" Haskell Dev
Bundle 'bitc/vim-hdevtools'
Bundle 'eagletmt/ghcmod-vim'
" Required by ghcmod-vim
Bundle 'Shougo/vimproc.vim'
Bundle 'eagletmt/neco-ghc'
Bundle 'Twinside/vim-haskellFold'
" Tag Bar
Bundle 'majutsushi/tagbar'
" Indenting
Bundle 'godlygeek/tabular'
"Editing
Bundle 'junegunn/goyo.vim'
Bundle 'rodjek/vim-puppet'
" Auto Completion
" Needs vim 7.3.885+ with lua.
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

"Neocomplete configuration
" Disable AutoComplPop.
let g:acp_enableAtStartup = 0
" Use neocomplete.
let g:neocomplete#enable_at_startup = 1
" Use smartcase.
let g:neocomplete#enable_smart_case = 1
" Set minimum syntax keyword length.
let g:neocomplete#sources#syntax#min_keyword_length = 3
let g:neocomplete#lock_buffer_name_pattern = '\*ku\*'

" Define dictionary.
let g:neocomplete#sources#dictionary#dictionaries = {
    \ 'default' : '',
    \ 'vimshell' : $HOME.'/.vimshell_hist',
    \ 'scheme' : $HOME.'/.gosh_completions'
        \ }

" Define keyword.
if !exists('g:neocomplete#keyword_patterns')
    let g:neocomplete#keyword_patterns = {}
endif
let g:neocomplete#keyword_patterns['default'] = '\h\w*'

" Plugin key-mappings.
inoremap <expr><C-g>     neocomplete#undo_completion()
inoremap <expr><C-l>     neocomplete#complete_common_string()

" Recommended key-mappings.
" <CR>: close popup and save indent.
inoremap <silent> <CR> <C-r>=<SID>my_cr_function()<CR>
function! s:my_cr_function()
  return neocomplete#close_popup() . "\<CR>"
  " For no inserting <CR> key.
  "return pumvisible() ? neocomplete#close_popup() : "\<CR>"
endfunction
" <TAB>: completion.
inoremap <expr><TAB>  pumvisible() ? "\<C-n>" : "\<TAB>"
" <C-h>, <BS>: close popup and delete backword char.
inoremap <expr><C-h> neocomplete#smart_close_popup()."\<C-h>"
"inoremap <expr><BS> neocomplete#smart_close_popup()."\<C-h>"
inoremap <expr><C-y>  neocomplete#close_popup()
inoremap <expr><C-e>  neocomplete#cancel_popup()
" Close popup by <Space>.
"inoremap <expr><Space> pumvisible() ? neocomplete#close_popup() : "\<Space>"

" AutoComplPop like behavior.
"let g:neocomplete#enable_auto_select = 1

" Enable omni completion.
autocmd FileType css setlocal omnifunc=csscomplete#CompleteCSS
autocmd FileType html,markdown setlocal omnifunc=htmlcomplete#CompleteTags
autocmd FileType javascript setlocal omnifunc=javascriptcomplete#CompleteJS
autocmd FileType python setlocal omnifunc=pythoncomplete#Complete
autocmd FileType xml setlocal omnifunc=xmlcomplete#CompleteTags
autocmd FileType haskell setlocal omnifunc=necoghc#omnifunc

" Enable heavy omni completion.
if !exists('g:neocomplete#sources#omni#input_patterns')
  let g:neocomplete#sources#omni#input_patterns = {}
endif

" ~/.vimrc ends here
