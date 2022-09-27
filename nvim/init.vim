source ~/.vimrc

" syntax on
" color desert

" let mapleader = " "


" set completeopt=menuone,preview
" set mouse=a " enable mouse in all modes
" set hidden

" set splitright
" set splitbelow

" set ruler " enable cursor position at status bar
" set number
" set relativenumber

" set clipboard=unnamed

" set scrolloff=5
" set updatetime=500

" " search options
" set incsearch
" set ignorecase
" set smartcase
" set hlsearch

" " setup tabs to be 4 spaces
" filetype plugin indent on
" set tabstop=4
" set shiftwidth=4
" set softtabstop=4
" set expandtab

" if (has("termguicolors"))
"     set termguicolors
" endif

" " Cursor Format
" let &t_SI = "\<esc>[5 q"  " blinking I-beam in insert mode
" let &t_SR = "\<esc>[3 q"  " blinking underline in replace mode
" let &t_EI = "\<esc>[1 q"  " default cursor (usually blinking block) otherwise

" " <leader>v to open .vimrc file
" nnoremap <leader>v :e $MYVIMRC<CR>

" =============================================================================
" Specify a directory for plugins
" - For Neovim: stdpath('data') . '/plugged'
" - Avoid using standard Vim directory names like 'plugin'
call plug#begin(stdpath('config') . '/plugged')
" call plug#begin('~/AppData/Local/nvim/plugged')
" call plug#begin('~/.config/nvim/plugged')

Plug 'tomasiser/vim-code-dark'
Plug 'itchyny/lightline.vim'
Plug 'itchyny/vim-gitbranch'
Plug 'szw/vim-maximizer'
Plug 'tpope/vim-commentary'
" Plug 'kassio/neoterm'
Plug 'sbdchd/neoformat'

" Plug 'easymotion/vim-easymotion'

" Fuzzy Finder
Plug 'junegunn/fzf', {'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'

" Git Stuff
Plug 'tpope/vim-fugitive'
Plug 'airblade/vim-gitgutter'
Plug 'voldikss/vim-floaterm'

" Autocompletion
Plug 'neoclide/coc.nvim', {'branch': 'release'}

" Linting
Plug 'dense-analysis/ale'

" LSP Plugins
"
" --- Rust
Plug 'rust-lang/rust.vim'
"
" --- Lua
" Plug 'neovim/nvim-lspconfig'
" Plug 'nvim-lua/completion-nvim'

" Initialize plugin system
call plug#end()

" =============================================================================

" voldikss/vim-floaterm
" ---------------------
nnoremap <Leader>tt :FloatermToggle<CR>
nnoremap <Leader>tg :FloatermNew lazygit<CR>
let g:floaterm_width = 0.95  " Set width to 95 %
let g:floaterm_height = 0.95 " Set heigth to 95 %



" tpope/vim-commentary
" --------------------
" Comment/Uncomment source code w/ CTRL-/
" Default keys are gc<motion> (or gcc)
nnoremap <C-/> :.Commentary<CR>
inoremap <C-/> <c-o>:.commentary<cr>
vnoremap <C-/> :'<,'>commentary<cr>gv


" sbdchd/neoformat
" ---------------
" Source code formatting via <Leader>F
nnoremap <Leader>F :Neoformat<CR>
vnoremap <Leader>F :'<,'>Neoformat<CR>


" szw/vim-maximizer
" -----------------
" Use <C-m> to maximize current split window.
" Default is <F3>
nnoremap <Leader>m :MaximizerToggle<CR>
vnoremap <Leader>m :MaximizerToggle<CR>gv
" inoremap <leader><m> <C-O>:MaximizerToggle<CR>
"

" tomasiser/vim-code-dark
" -----------------------
" Set color scheme to vim-code-dark
colorscheme codedark


" itchyny/lighline.vim; 
" itchyny/vim-gitbranch
" ---------------------
" Individualize status bar at bottom
" Adds gitbranch to default bar.
let g:lightline = {
      \ 'active': {
      \   'left': [ [ 'mode', 'paste' ],
      \             [ 'gitbranch', 'readonly', 'filename', 'modified' ] ]
      \ },
      \ 'component_function': {
      \   'gitbranch': 'gitbranch#name'
      \ },
      \ 'colorscheme': 'codedark',
      \ }


" junegunn/fzf.vim
" ----------------
" Fuzzy file finder
" Git repo file search:
nnoremap <Leader><Space> :GFiles<CR> 
" Global file search using Rg:
nnoremap <Leader>ff :Rg<CR> 
" Search Buffers
nnoremap <Leader>fb :Buffers<CR> 
" Search Lines in Buffers
nnoremap <Leader>fl :Lines<CR> 


" tpope/vim-fugitive
" ------------------
" Git status via <Leader>gg
nnoremap <Leader>gg :G<CR>

" neoclide/coc.nvim
" -----------------
" https://github.com/neoclide/coc.nvim/#example-vim-configuration
inoremap <silent><expr> <TAB>
      \ coc#pum#visible() ? coc#pum#next(1) :
      \ CheckBackspace() ? "\<Tab>" :
      \ coc#refresh()
inoremap <expr><S-TAB> coc#pum#visible() ? coc#pum#prev(1) : "\<C-h>"

inoremap <silent><expr> <CR>
      \ coc#pum#visible() ? coc#pum#confirm() :
      \ "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

if has('nvim')
  inoremap <silent><expr> <c-space> coc#refresh()
else
  inoremap <silent><expr> <c-@> coc#refresh()
endif


function! CheckBackspace() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" Use <c-space> to trigger completion.
if has('nvim')
  inoremap <silent><expr> <c-space> coc#refresh()
else
  inoremap <silent><expr> <c-@> coc#refresh()
endif

" Use `[g` and `]g` to navigate diagnostics
" Use `:CocDiagnostics` to get all diagnostics of current buffer in location list.
nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)

nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)


" " neovim/nvim-lspconfig
" " nvim-lua/completion-nvim
" " ------------------------
" lua require'lspconfig'.pyright.setup{}

" " Use completion-nvim in every buffer
" autocmd BufEnter * lua require'completion'.on_attach()

" nnoremap <silent> gd    <cmd>lua vim.lsp.buf.definition()<CR>
" nnoremap <silent> gD    <cmd>lua vim.lsp.buf.implementation()<CR>
" nnoremap <silent> gr    <cmd>lua vim.lsp.buf.references()<CR>
" nnoremap <silent> gR    <cmd>lua vim.lsp.buf.rename()<CR>
" nnoremap <silent> gh    <cmd>lua vim.lsp.buf.hover()<CR>
" nnoremap <silent> gH    <cmd>lua vim.lsp.buf.code_action()<CR>
" nnoremap <silent> gk    <cmd>lua vim.lsp.buf.signature_help()<CR>


" Rust Language Configuration
" ---------------------------
" Auto-Format upon save using rustfmt
let g:rustfmt_autosave = 1
let g:rustfmt_emit_files = 1
let g:rustfmt_fail_silently = 0

" Windows must use <bar>
nmap <silent> <F5> :w <bar> Crun<CR>
" On Linux
" nmap <silent> <F5> :w | Crun<CR>


" if exists("g:neovide")
"     " Put anything you want to happen only in Neovide here
" endif


