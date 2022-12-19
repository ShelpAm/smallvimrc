"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" maintainer:
"   small_sheep_
"
" sections:
"    -> general            configuration
"    -> apearance          configuration
"    -> file               configuration
"    -> key mapping        configuration
"    ->
"    -> vim user interface configuration
"    -> plugin-related     configuration
"
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" general configuration

" Set Vim is not compatible with vi
set nocompatible

"
set term=$TERM

" set encoding
set encoding=utf-8

" use mouse
set mouse=a



" apearance configuration

" background setting
set background=dark

" terminal color
set t_Co=256

" colorscheme
colorscheme gruvbox

" enable highlight
syntax enable

" show line number at left side
set number

" show current cursor position (usually at right down side)
set ruler

" a menu for completion of commands
set wildmenu

"
set showcmd

" status line Always show the status line
set laststatus=2
set noshowmode

" file configuration


" key configuration
set timeout
set timeoutlen=100

set undolevels=1000
set showmatch
set infercase


" maintain undo history between sessions
if has('persistent_undo')
  set undofile
endif





" Set how many lines of history VIM has to remember
set history=500

" Enable filetype plugins
filetype plugin indent on

" Set to auto read when a file is changed from the outside
set autoread
au FocusGained,BufEnter * checktime

" With a map leader it's possible to do extra key combinations
" like <leader>w saves the current file
let g:mapleader = ","

" Fast saving
nnoremap <leader>w :w<cr>
nnoremap <leader>q :q<cr>

" :W saves the file
command! W :w


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => VIM user interface
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Ignore case when searching
set ignorecase

" When searching try to be smart about cases
set smartcase

" Highlight search results
set hlsearch

" Makes search act like search in modern browsers
set incsearch

" Don't redraw while executing macros (good performance config)
set lazyredraw

" For regular expressions turn magic on
set magic

" Show matching brackets when text indicator is over them
set showmatch

" No annoying sound on errors
set noerrorbells
set novisualbell
set t_vb=
set tm=500

" Add a bit extra margin to the left
set foldcolumn=1







set backspace=indent,eol,start

" indent configuration
"set copyindent
"set autoindent
"set smartindent
set cindent
set cinoptions=>s,e0,n0,g1,N0,E0,i4

set shiftwidth=2
set tabstop=2
set softtabstop=2

set list
set listchars=tab:\>\ ,trail:.

set guioptions-=m,T,r,l,b
set vb t_vb=
set nohls
set clipboard=unnamed

set autowrite
set nobackup
"set backupext=.backup



" plugin configuration

" For coc.nvim
" Having longer updatetime (default is 4000 ms = 4 s) leads to noticeable
" delays and poor user experience.
set updatetime=300

" Make <cr> to accept selected completion item or notify coc.nvim to format
" <C-g>u breaks current undo, please make your own choice.
inoremap <silent><expr> <TAB> coc#pum#visible() ? coc#pum#confirm()
                              \: "\<C-g>u\<cr>\<c-r>=coc#on_enter()\<cr>"

" Highlight the symbol and its references when holding the cursor.
autocmd CursorHold * silent call CocActionAsync('highlight')

" Add `:Format` command to format current buffer.
command! -nargs=0 Format :call CocActionAsync('format')
nnoremap <Leader>f :Format<cr>

" Add `:Fold` command to fold current buffer.
command! -nargs=? Fold :call     CocAction('fold', <f-args>)




" For NERDTree
" Start NERDTree and put the cursor back in the other window.
autocmd VimEnter * NERDTree | wincmd p

" Exit Vim if NERDTree is the only window remaining in the only tab.
autocmd BufEnter * if tabpagenr('$') == 1 && winnr('$') == 1 && exists('b:NERDTree') && b:NERDTree.isTabTree() | quit | endif

" If another buffer tries to replace NERDTree, put it in the other window, and bring back NERDTree.
autocmd BufEnter * if bufname('#') =~ 'NERD_tree_\d\+' && bufname('%') !~ 'NERD_tree_\d\+' && winnr('$') > 1 |
    \ let buf=bufnr() | buffer# | execute "normal! \<C-W>w" | execute 'buffer'.buf | endif




" For vim-cmake
nnoremap <leader>cg :CMakeGenerate<cr>
nnoremap <leader>cb :CMakeBuild<cr>

let g:cmake_generate_options = ["-DCMAKE_CXX_COMPILER='clang++'"]
let g:cmake_build_options = []
let g:cmake_link_compile_commands = 1




" For lightline.vim
let g:lightline = {
      \ 'colorscheme': 'solarized',
      \ 'active': {
      \   'left': [ [ 'mode', 'paste' ],
      \             [ 'readonly', 'filename', 'modified'] ],
      \   'right': [ ['percent'], ['lineinfo'], ['filetype'] ]
      \ },
      \ 'component': {
      \ },
      \ }
"let g:lightline = {
"      \ 'colorscheme': 'solarized',
"      \}




" For myself
nnoremap <leader>s :source $MYVIMRC<cr>

augroup small_autocmd_group
  autocmd!

  autocmd FileType c,cpp,vim,glsl,vs,fs,gs set expandtab
  autocmd FileType make set noexpandtab
augroup end

augroup filetype_cpp
  autocmd!
  autocmd FileType cpp let g:comment_string = "//"
augroup end

augroup filetype_vim
  autocmd!
  autocmd FileType vim let g:comment_string = "\""
augroup end


" key mapping configuration
inoremap jk <esc>


" quick comment
function CommentCurrentLine() abort
  let @a = g:comment_string
  " mark a, ^, "ap, `a, l
  normal ma^"aP`al
endfunction
nnoremap <silent> <c-_> :call CommentCurrentLine()<cr>
inoremap <silent> <c-_> <esc>:call CommentCurrentLine()<cr>
vnoremap <silent> <c-_> :call CommentCurrentLine()<cr>

nnoremap <silent> <leader>c :call CommentCurrentLine()<cr>
inoremap <silent> <leader>c <esc>:call CommentCurrentLine()<cr>
vnoremap <silent> <leader>c :call CommentCurrentLine()<cr>
