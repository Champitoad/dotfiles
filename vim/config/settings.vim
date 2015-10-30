" Remove compatibility with vi
set nocompatible

" Load zsh parameters for commands
set shell=/bin/zsh\ -i

" Commands history
set history=1000

" Indentation
set smartindent
set tabstop=4
set softtabstop=4
set shiftwidth=4
set expandtab

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

" Use "," key for plugins commands shortcuts
let mapleader=","

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

" vim-plug

call plug#begin('/home/pablo/.vim/plugged')

" Make sure you use single quotes
Plug 'junegunn/vim-easy-align'
Plug 'scrooloose/nerdcommenter'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-repeat'
Plug 'vim-scripts/visualrepeat'
Plug 'aklt/plantuml-syntax'

" Group dependencies, vim-snippets depends on ultisnips
Plug 'SirVer/ultisnips' | Plug 'honza/vim-snippets'

" On-demand loading
Plug 'scrooloose/nerdtree', { 'on':  'NERDTreeToggle' }
Plug 'tpope/vim-fireplace', { 'for': 'clojure' }

" Using git URL
Plug 'https://github.com/junegunn/vim-github-dashboard.git'

call plug#end()
