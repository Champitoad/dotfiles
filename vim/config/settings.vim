" Remove compatibility with vi
set nocompatible

" Load zsh parameters for commands
set shell=/bin/zsh

" Commands history
set history=1000

" Indentation
set smartindent
set tabstop=4
set softtabstop=4
set shiftwidth=4
set expandtab

" Folding settings
set foldmethod=syntax
set foldnestmax=10
set nofoldenable
set foldlevel=1

" Use mouse
set mouse=a

" Print line numbers
set number

" Dark background
set background=dark

" Use system clipboard
set clipboard=unnamedplus

" Open new split windows right and below
set splitbelow
set splitright

" Maximum tabs you can open
set tabpagemax=100

" Automatic filetype detection for coloration
filetype plugin on

" Syntax
syntax on

" Avoid automatic comment line start when inserting new line from a comment
autocmd FileType * setlocal formatoptions-=c formatoptions-=r formatoptions-=o

" Key bindings
map <C-n> :tabe 
map <C-Left> gT<CR>
map <C-Right> gt<CR>
map <C-Down> :tabr<CR>
map <C-Up> :tabl<CR>
map <A-Left> :-tabm<CR>
map <A-Right> :+tabm<CR>
map <A-Down> :0tabm<CR>
map <A-Up> :$tabm<CR>
map <Tab> <C-w><C-w>

" Color scheme
colorscheme base16-default
let base16colorspace=256
autocmd ColorScheme * highlight Normal ctermbg=None
autocmd ColorScheme * highlight LineNr ctermbg=None
autocmd ColorScheme * highlight TabLineFill ctermbg=None
autocmd ColorScheme * highlight TabLine ctermbg=None
autocmd ColorScheme * highlight TabLineSel ctermbg=None

" Syntax highlighting

augroup filetype
    au BufRead,BufNewFile *.flex,*.jflex    set filetype=jflex 
    au BufRead,BufNewFile *.cup             set filetype=cup
augroup END
au Syntax jflex so ~/.vim/syntax/jflex.vim
au Syntax cup   so ~/.vim/syntax/cup.vim

" vim-plug

call plug#begin('/home/pablo/.vim/plugged')

" Make sure you use single quotes
Plug 'junegunn/vim-easy-align'
Plug 'scrooloose/nerdcommenter'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-abolish'
Plug 'vim-scripts/visualrepeat'
Plug 'aklt/plantuml-syntax'
Plug 'jeffkreeftmeijer/vim-numbertoggle'
Plug 'asciidoc/vim-asciidoc'
Plug 'beyondwords/vim-twig'
Plug 'lervag/vimtex'
Plug 'vim-pandoc/vim-pandoc'
Plug 'vim-pandoc/vim-pandoc-syntax'
Plug 'let-def/ocp-indent-vim'
Plug 'dhruvasagar/vim-table-mode'

call plug#end()

" Plugins options

" Use "," key for plugins commands shortcuts
let mapleader=","

" vim-pandoc
let g:pandoc#spell#enabled = 0

" vim-table-mode
let g:table_mode_corner_corner='+'
let g:table_mode_header_fillchar='='
