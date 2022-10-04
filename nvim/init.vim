source ~/.vimrc

" =============================================================================
call plug#begin(stdpath('config') . '/plugged')
"
" Color Themes
Plug 'tomasiser/vim-code-dark'
"
" Buffers and Windows
Plug 'itchyny/lightline.vim'
Plug 'mengelbrecht/lightline-bufferline'
Plug 'szw/vim-maximizer'
"
" Terminal
Plug 'voldikss/vim-floaterm'
"" Plug 'kassio/neoterm'
"
" Fuzzy Finder
Plug 'junegunn/fzf', {'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'
"
" Git Stuff
Plug 'itchyny/vim-gitbranch'
Plug 'airblade/vim-gitgutter'
"
" Misc. Plugings
Plug 'sbdchd/neoformat'
Plug 'tpope/vim-commentary'
"
" Autocompletion
Plug 'neoclide/coc.nvim', {'branch': 'release'}
"
"" Linting
"Plug 'dense-analysis/ale'
"
" LSP Plugins
"
" --- Rust
Plug 'rust-lang/rust.vim'
"
"" --- Lua
"" Plug 'neovim/nvim-lspconfig'
"" Plug 'nvim-lua/completion-nvim'
"
" Initialize plugin system
call plug#end()

" =============================================================================
" tomasiser/vim-code-dark
" -----------------------
" Set color scheme to vim-code-dark
colorscheme codedark

" =============================================================================
" itchyny/lighline.vim
" mengelbrecht/lightline-bufferline
" itchyny/vim-gitbranch
" ---------------------
" Individualize status bar at bottom
" Adds gitbranch to default bar.
set showtabline=2 " always show tabline
let g:lightline = {
      \ 'colorscheme': 'codedark',
      \ 'active': {
      \   'left': [ [ 'mode', 'paste' ],
      \             [ 'gitbranch', 'readonly', 'filename', 'modified' ] ]
      \ },
      \ 'tabline': {
      \   'left': [ ['buffers'] ],
      \   'right': [ ['close'] ]
      \ },
      \ 'component_function': {
      \   'gitbranch': 'gitbranch#name'
      \ },
      \ 'component_expand': {
      \   'buffers': 'lightline#bufferline#buffers'
      \ },
      \ 'component_type': {
      \   'buffers': 'tabsel'
      \ }
      \ }
"
" Mappings to cycle buffers
nnoremap <Leader><Tab> :bn<CR>
nnoremap <Leader><S-Tab> :bp<CR>

" =============================================================================
" szw/vim-maximizer
" -----------------
" Use <C-m> to maximize current split window.
" Default is <F3>
nnoremap <Leader>m :MaximizerToggle<CR>
vnoremap <Leader>m :MaximizerToggle<CR>gv

" =============================================================================
" voldikss/vim-floaterm
" ---------------------
let g:floaterm_width = 0.95  " Set width to 95 %
let g:floaterm_height = 0.95 " Set heigth to 95 %
nnoremap <Leader>tt :FloatermToggle<CR>
nnoremap <Leader>tg :FloatermNew lazygit<CR>

" =============================================================================
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

" =============================================================================
" tpope/vim-commentary
" --------------------
" Comment/Uncomment source code w/ CTRL-/
" Default keys are gc<motion> (or gcc)
nnoremap <silent> <C-_> :.Commentary<CR>
inoremap <silent> <C-_> <c-o>:.Commentary<cr>
vnoremap <silent> <C-_> :'<,'>Commentary<cr>gv

" =============================================================================
" sbdchd/neoformat
" ---------------
" Source code formatting via <Leader>F
nnoremap <Leader>F :Neoformat<CR>
vnoremap <Leader>F :'<,'>Neoformat<CR>

" =============================================================================
" neoclide/coc.nvim
" -----------------
" https://github.com/neoclide/coc.nvim/#example-vim-configuration
inoremap <silent><expr> <TAB>
      \ coc#pum#visible() ? coc#pum#next(1) :
      \ CheckBackspace() ? "\<Tab>" :
      \ coc#refresh()
inoremap <expr><S-TAB> coc#pum#visible() ? coc#pum#prev(1) : "\<C-h>"
"
inoremap <silent><expr> <CR>
      \ coc#pum#visible() ? coc#pum#confirm() :
      \ "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"
"
function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction
"
if has('nvim')
  inoremap <silent><expr> <c-space> coc#refresh()
else
  inoremap <silent><expr> <c-@> coc#refresh()
endif
"
function! CheckBackspace() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction
"
" Use <c-space> to trigger completion.
if has('nvim')
  inoremap <silent><expr> <c-space> coc#refresh()
else
  inoremap <silent><expr> <c-@> coc#refresh()
endif
"
" Use `[g` and `]g` to navigate diagnostics
" Use `:CocDiagnostics` to get all diagnostics of current buffer in location list.
nmap <silent> g[ <Plug>(coc-diagnostic-prev)
nmap <silent> g] <Plug>(coc-diagnostic-next)
"
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" =============================================================================
" Rust Language Configuration
" ---------------------------
" Auto-Format upon save using rustfmt
let g:rustfmt_autosave = 1
let g:rustfmt_emit_files = 1
let g:rustfmt_fail_silently = 0

" Windows must use <bar>
" nmap <silent> <F5> :w <bar> Crun<CR>
nmap <silent> <F5> :w <bar> !cargo run<CR>
imap <silent> <F5> <c-o>:w <bar> !cargo run<CR>
" On Linux
" nmap <silent> <F5> :w | Crun<CR>


" =============================================================================
"" " neovim/nvim-lspconfig
"" " nvim-lua/completion-nvim
"" " ------------------------
"" lua require'lspconfig'.pyright.setup{}

"" " Use completion-nvim in every buffer
"" autocmd BufEnter * lua require'completion'.on_attach()

"" nnoremap <silent> gd    <cmd>lua vim.lsp.buf.definition()<CR>
"" nnoremap <silent> gD    <cmd>lua vim.lsp.buf.implementation()<CR>
"" nnoremap <silent> gr    <cmd>lua vim.lsp.buf.references()<CR>
"" nnoremap <silent> gR    <cmd>lua vim.lsp.buf.rename()<CR>
"" nnoremap <silent> gh    <cmd>lua vim.lsp.buf.hover()<CR>
"" nnoremap <silent> gH    <cmd>lua vim.lsp.buf.code_action()<CR>
"" nnoremap <silent> gk    <cmd>lua vim.lsp.buf.signature_help()<CR>



"" if exists("g:neovide")
""     " Put anything you want to happen only in Neovide here
"" endif


