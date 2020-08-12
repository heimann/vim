set encoding=utf-8
set noshowmode        " Lightline shows us the mode.
set fillchars+=vert:\|
highlight VertSplit guibg=#ae81ff guifg=#011627 ctermbg=6 ctermfg=0
set laststatus=2
syntax on
" Wrap gitcommit file types at the appropriate length
filetype indent plugin on
filetype on

if empty(glob('~/.vim/autoload/plug.vim'))
    silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
	\ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
    autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

call plug#begin('~/.vim/plugged')
" Behavior
Plug 'scrooloose/nerdcommenter' " Toggle comment with <leader>cc

" Language Support
Plug 'neovim/nvim-lsp'
Plug 'haorenW1025/completion-nvim'
Plug 'wbthomason/lsp-status.nvim'
Plug 'haorenW1025/diagnostic-nvim'

Plug 'sheerun/vim-polyglot'

" Git Plugins
Plug 'airblade/vim-gitgutter'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-rhubarb'

" Snippets stuff

" Ultisnippets
Plug 'SirVer/ultisnips'
Plug 'honza/vim-snippets'
let g:UltiSnipsDisablePreview = 1


" Navigation
"
" FZF installed through homebrew
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'

Plug 'shougo/neomru.vim'                     " Required by fzf-preview.vim
Plug 'yuki-ycino/fzf-preview.vim'

Plug 'justinmk/vim-sneak'
Plug 'tpope/vim-unimpaired'

Plug 'liuchengxu/vista.vim'

" Navigate between vim and tmux panes seamlessly
Plug 'christoomey/vim-tmux-navigator'

" Theme
Plug 'bluz71/vim-nightfly-guicolors'
Plug 'ryanoasis/vim-devicons' " Required by fzf-preview

Plug 'itchyny/lightline.vim'

Plug 'kshenoy/vim-signature' " Show marks

call plug#end()

" Theming and Styling

set number
set cursorline

" Set cursor in the same place when switching buffers
set nostartofline

"colorscheme nightfly
set termguicolors " required for nightfly to work right
colorscheme nightfly
highlight Comment guifg=#081e2f guibg=#296596

set noshowmode        " Lightline shows us the mode.
set fillchars+=vert:\|
highlight VertSplit guibg=#ae81ff guifg=#011627 ctermbg=6 ctermfg=0

let g:lightline = {
      \ 'colorscheme': 'nightfly',
      \ 'active': {
      \   'left': [ [ 'mode', 'paste' ],
      \             [ 'gitbranch', 'readonly', 'filename', 'modified' ] ]
      \ },
      \ 'component_function': {
      \   'gitbranch': 'FugitiveHead'
      \ },
      \ }

" See 80th column
if (exists('+colorcolumn'))
    set colorcolumn=80
    "highlight ColorColumn ctermbg=2
endif

let &colorcolumn=join(range(81,999),",") " extend column highlight beyond 80


" Behavioral improvements

let mapleader = "\<Space>"  " space is just a better leader key
set ttimeout
set ttimeoutlen=1
set backspace=indent,eol,start

" disable mouse
set mouse=""

" FILE MANAGEMENT
set autoread " Is enabled by default but for clarity
set autowrite
set undofile

set backup
set backupdir=~/.vim/backup
set noswapfile
set backupskip=/tmp/*

" Make closing the terminal easier
tmap <C-o> <C-\><C-n>

au BufEnter * if &buftype == 'terminal' | :startinsert | endif
au BufEnter * if &buftype == 'terminal' | :set nonumber | endif
au BufEnter * if &buftype == 'terminal' | :set nornu | endif
au BufEnter * if &buftype == 'terminal' | :set nocursorline | endif


" You will have bad experience for diagnostic messages when it's default 4000.
set updatetime=100

" Reload vimrc
nnoremap <Leader>vr :source $MYVIMRC<CR>

" Copy to clipboard in visualmode
vnoremap <leader>c "*y<cr>

" Enter to save
nnoremap <silent><expr> <CR> empty(&buftype) ? ":up<CR>" : "<CR>"

" Shut up
set belloff=all

" Create splits to the right and below focused split
set splitbelow
set splitright

" Buffer management
nnoremap <leader>D :bd<cr>

nmap <Tab> :b#<CR>

" Search Optimizations

" Fuzzy Search
set wildmenu
set wildignore+=*.bmp,*.gif,*.ico,*.jpg,*.png,*.ico
set wildignore+=*.pdf,*.psd
set wildignore+=node_modules/*,bower_components/*
set wildignore+=.git/*,bin/*

set number
set nolist
set listchars=tab:▸\ ,eol:¬,extends:❯,precedes:❮

" Incremental Replacement if in neovim
set inccommand=nosplit

set hlsearch                       " highlight results 
set incsearch                      " go as you type
set ignorecase                     " and who cares about capitals
set smartcase                      " unless there is one
set showmatch                      " and show the match
noremap <leader><space> :nohl<CR>  " and get rid of highlighting when we're done

" spaces > tabs
set tabstop=2
set softtabstop=2
set shiftwidth=2
set autoindent
set smarttab
set expandtab

" Fix [200^ ... when pasting
set t_BE=

" Navigate between buffers and panes (and tmux panes)

nnoremap <c-j> <c-w>j
nnoremap <c-k> <c-w>k
nnoremap <c-h> <c-w>h
nnoremap <c-l> <c-w>l

tnoremap <c-j> <C-\><C-N><c-w>j
tnoremap <c-k> <C-\><C-N><c-w>k
tnoremap <c-h> <C-\><C-N><c-w>h
tnoremap <c-l> <C-\><C-N><c-w>l
let g:completion_enable_snippet = 'Ultisnips'

" Use <Tab> and <S-Tab> to navigate through popup menu
inoremap <expr> <Tab>   pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"

" Set completeopt to have a better completion experience
set completeopt=menuone,noinsert,noselect

" Avoid showing message extra message when using completion
set shortmess+=c

" Set completeopt to have a better completion experience
set completeopt=menuone,noinsert,noselect

" Avoid showing message extra message when using completion
set shortmess+=c

lua << END
require'nvim_lsp'.elixirls.setup{
  cmd = {'/home/david/Downloads/elx/release/language_server.sh'};
  on_attach = require'diagnostic'.on_attach
}
END

autocmd BufEnter * lua require'completion'.on_attach()

"inoremap <silent><expr> <c-p> completion#trigger_completion() "map <c-p> to manually trigger completion

" NVIM-LSP 
let g:diagnostic_auto_popup_while_jump = 1

" Keybindings for LSP
nnoremap <silent> gd    <cmd>lua vim.lsp.buf.definition()<CR>
nnoremap <silent> K     <cmd>lua vim.lsp.buf.hover()<CR>
nnoremap <silent> 1gD   <cmd>lua vim.lsp.buf.type_definition()<CR>
nnoremap <silent> gr    <cmd>lua vim.lsp.buf.references()<CR>
nnoremap <silent> g0    <cmd>lua vim.lsp.buf.document_symbol()<CR>
nnoremap <silent> gW    <cmd>lua vim.lsp.buf.workspace_symbol()<CR>
nnoremap <silent> gF    <cmd>lua vim.lsp.buf.formatting()<CR>
nnoremap <silent> D     <cmd>lua vim.lsp.util.show_line_diagnostics()<CR>

" Navigation

nnoremap <leader>tt :Vista!!<CR> " toggle Vista
nnoremap <leader>st :Vista finder fzf<cr>

let g:vista_fzf_preview = ['right:50%']
let g:vista_sidebar_width = 50

let $FZF_DEFAULT_COMMAND = 'rg --files --no-ignore-vcs --hidden'
command! -bang -nargs=* Rg
      \ call fzf#vim#grep(
      \   'rg --column --line-number --no-heading --color=always --smart-case '.shellescape(<q-args>), 1,
      \   <bang>0 ? fzf#vim#with_preview('up:80%')
      \           : fzf#vim#with_preview('right:50%:hidden', '?'),
      \   <bang>0)

" FZF Preview Configuration
nnoremap <c-p> :FzfPreviewProjectFiles<cr>
nnoremap <Leader>? :FzfPreviewGitStatus<cr>
nnoremap <c-f> :Rg!<cr>
nnoremap <leader>sb :FzfPreviewAllBuffers<cr>

let g:fzf_preview_fzf_preview_window_option = 'up:70%'
" Use floating window (for neovim)
let g:fzf_preview_use_floating_window = 1

" floating window size ratio
let g:fzf_preview_floating_window_rate = 0.9

" floating window winblend value
let g:fzf_preview_floating_window_winblend = 15

" Git config,
" Le Fugitive
nnoremap <leader>gs :G<cr><c-n><c-n><c-n>
nnoremap <leader>gp :Gpush<cr>
nnoremap <leader>gh :Gbrowse!<cr>
vnoremap <leader>gh :Gbrowse!<cr>
nnoremap <leader>gd :Gdiff master<cr>zR

" Le Gitgutter
nnoremap <leader>hN :GitGutterPrevHunk<cr>
nnoremap <leader>hn :GitGutterNextHunk<cr>


let g:gitgutter_highlight_linenrs=1


" Sneak config
let g:sneak#label = 1
let g:sneak#use_ic_scs = 1
