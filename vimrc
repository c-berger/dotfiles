" Use VIM settings over VI settings
set nocompatible

syntax on
color desert

let mapleader = " "


set completeopt=menuone,preview
set mouse=a " enable mouse in all modes
set hidden

set splitright
set splitbelow

set ruler " enable cursor position at status bar
set number
set relativenumber

set clipboard=unnamed

set scrolloff=5
set updatetime=500

" search options
set incsearch
set ignorecase
set smartcase
set hlsearch

" setup tabs to be 4 spaces
filetype plugin indent on
set tabstop=4
set shiftwidth=4
set softtabstop=4
set expandtab

if (has("termguicolors"))
    set termguicolors
endif


" Cursor Format
let &t_SI = "\<esc>[5 q"  " blinking I-beam in insert mode
let &t_SR = "\<esc>[3 q"  " blinking underline in replace mode
let &t_EI = "\<esc>[1 q"  " default cursor (usually blinking block) otherwise

" <leader>v to open .vimrc file
nnoremap <leader>v :e $MYVIMRC<CR>
