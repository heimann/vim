" -----------------------------------------------------------------------------
" Overview and Principles.
"
" Hi there, welcome to my vim configuration! A couple of notes and disclaimers
" that you might want to read before you dig in.  1. This configuration is
" neovim specific. I left Vim8 behind a while ago and these dotfiles are a lot
" easier to maintain without having to worry about Vim compatability.
"
" 2. There are a good amount of plugins. I don't necessarily aim to make this
" configuration work like VSCode, but I'm far from a purist. There are
" lanaguage server integrations, linting tools etc. Generally speaking, my
" programming setup is designed to keep me in flow as much as possible, and
" things like autocomplete and jump to definition help a lot with that.
"
" 3. I hope for this configuration to be as self contained as it can be. Some
" people prefer to split up their vim configuration into multiple files, but I
" generally prefer to use a search based workflow. Hence, this one long
" configuration. If you want some inspiration on breaking up a vim
" configuration into multiple files, I suggest looking at:
" 	- https://github.com/naps62/dotfiles/tree/master/config/nvim
" 	- https://github.com/christoomey/dotfiles/tree/master/vim
"
" In case you have any questions, please do reach out at d@dmeh.net.
"
" David Heimann (2020)
" -----------------------------------------------------------------------------


" -----------------------------------------------------------------------------
" Basic Setup.
"
" Some general setting that you probably always want to maximize
" compatibility.
"
" To learn more about any of these settings use ':help <setting>'
" -----------------------------------------------------------------------------

" Tell vim to shut up
set belloff=all

" Better display for messages
set cmdheight=2

" don't give |ins-completion-menu| messages.
set shortmess+=c

" You will have bad experience for diagnostic messages when it's default 4000.
set updatetime=100

" splits
 set diffopt+=vertical

syntax on
set encoding=utf-8
set hidden
set autoread
set autowrite
set undofile
set mouse="" " Disable the mouse. The mouse is evil.
set number
" spaces > tabs
set tabstop=2
set softtabstop=2
set shiftwidth=2
set autoindent
set smarttab
set expandtab

" Folding
set foldmethod=indent
set foldnestmax=10
set nofoldenable
set foldlevel=2

" Set nice indentation for wraps
set breakindent
set breakindentopt=shift:2,min:40,sbr

" Create splits to the right and below focused split
set splitbelow
set splitright

" Fix [200^ ... when pasting
set t_BE=

set backup
set backupdir=~/.vim/backup
set noswapfile
set backupskip=/tmp/*
set ttimeout
set ttimeoutlen=1
set lazyredraw " Speeds up scrolling a lot. See:
" https://eduncan911.com/software/fix-slow-scrolling-in-vim-and-neovim.html

set laststatus=1
set backspace=indent,eol,start
set termguicolors " <- This one is important to get all the colors you want.
let g:lastplace_ignore_buftype = "quickfix,nofile,help"

set wildmenu
set wildignore+=*.bmp,*.gif,*.ico,*.jpg,*.png,*.ico
set wildignore+=*.pdf,*.psd
set wildignore+=node_modules/*,bower_components/*
set wildignore+=.git/*,bin/*

set number
set nolist
set listchars=tab:▸\ ,eol:¬,extends:❯,precedes:❮

" Search stuff
set hlsearch                       " highlight results

" Incremental Replacement if in neovim
if has("nvim")
  set inccommand=nosplit
endif

set incsearch                      " go as you type
set ignorecase                     " and who cares about capitals
set smartcase                      " unless there is one
set showmatch                      " and show the match
noremap <leader><space> :nohl<CR>  " and get rid of highlighting when we're done

" Set cursor in the same place when switching buffers
set nostartofline

" I like space for my leader key, in some ways you'll find that this setup is
" a bit 'emacs'-y. I like bindings that go <Leader>[prefix][action], like for
" example, searching project files is <leader>sp - [s]earch[p]roject
let mapleader = "\<Space>"

" We need this to ensure that we wrrap gitcommit file types.
filetype indent plugin on


" -----------------------------------------------------------------------------
" Packages & Plug Setup.
"
" This section gets a little convoluted but don't fret.
" Hold on for a second here, it's about to get kind of convoluted but don't
" -----------------------------------------------------------------------------

" This snippet ensures that we install 'Plug' (which we're using for plugin
" management), it can't already be found.
" See (https://github.com/junegunn/vim-plug/issues/739) for notes.
let plug_install = 0
let autoload_plug_path = stdpath('config') . '/autoload/plug.vim'
if !filereadable(autoload_plug_path)
    silent exe '!curl -fL --create-dirs -o ' . autoload_plug_path .
        \ ' https://raw.github.com/junegunn/vim-plug/master/plug.vim'
    execute 'source ' . fnameescape(autoload_plug_path)
    let plug_install = 1
endif
unlet autoload_plug_path

" Plugins begin here.
call plug#begin('~/.config/nvim/plugins')

" Plugins - Aesthetics.
Plug 'bluz71/vim-nightfly-guicolors'
Plug 'bronson/vim-trailing-whitespace' " Show trailing whitespace

" Git Stuff
Plug 'airblade/vim-gitgutter'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-rhubarb'

" Navigation
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
Plug 'pbogut/fzf-mru.vim'

Plug 'justinmk/vim-sneak'       " Get around in your files.
Plug 'farmergreg/vim-lastplace' " open files at the last edited place
Plug 'heimann/vim-slash'        " improve / search experience

" Navigate between tmux and vim splits seamlessly
Plug 'christoomey/vim-tmux-navigator'

" Fancy Language Server Stuff.
" Here be dragons, but this is what gets me around my projects the quickest.
" I recommend spending some time getting to know these tools.
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'antoinemadec/coc-fzf'

Plug 'ludovicchabant/vim-gutentags' "For tag management

" Knowledge management.
Plug 'vimwiki/vimwiki'
Plug 'michal-h21/vim-zettel'
call plug#end()

if plug_install
    PlugInstall --sync
endif
unlet plug_install


" -----------------------------------------------------------------------------
" Theming and Aesthetics.
"
" This section gets a little convoluted but don't fret.
" Hold on for a second here, it's about to get kind of convoluted but don't
" -----------------------------------------------------------------------------

" I've been using nightfly for a while. I also make sure to configure the
" colors in my terminal to use the same basic palette.
colorscheme nightfly

" I don't like the default comment highlighting in nightfly, so this changes
" it
highlight Comment guifg=#081e2f guibg=#296596

" See 80th column
if (exists('+colorcolumn'))
    set colorcolumn=80
    highlight ColorColumn guibg=#8b1e3f
endif

" Extend the color column beyond 80
let &colorcolumn=join(range(81,999),",") " extend column highlight beyond 80

set fillchars+=vert:\|
highlight VertSplit guibg=#011627 guifg=#ae81ff ctermbg=6 ctermfg=0

" -----------------------------------------------------------------------------
" Status line
" -----------------------------------------------------------------------------

" Straight up stolen from:
" https://github.com/nickjj/dotfiles/blob/9256a4f4f0b7c00e36ab9e7a997fa44843fb39ac/.vimrc#L146
function! s:statusline_expr()
  let mod = "%{&modified ? '[+] ' : !&modifiable ? '[x] ' : ''}"
  let ro  = "%{&readonly ? '[RO] ' : ''}"
  let ft  = "%{len(&filetype) ? '['.&filetype.'] ' : ''}"
  let fug = "%{exists('g:loaded_fugitive') ? fugitive#statusline() : ''}"
  let sep = ' %= '
  let pos = ' %-12(%l : %c%V%) '
  let pct = ' %P'

  return '[%n] %f %<'.mod.ro.ft.fug.sep.pos.'%*'.pct
endfunction

let &statusline = s:statusline_expr()

" Add coc to status line.
" see: `:h coc-status`
set statusline^=%{coc#status()}%{get(b:,'coc_current_function','')}

" -----------------------------------------------------------------------------
" Behaviours.
"
" -----------------------------------------------------------------------------

" If you're in a terminal, you don't want line numbers :)
au BufEnter * if &buftype == 'terminal' | :set nonumber | endif
au BufEnter * if &buftype == 'terminal' | :set nornu | endif
au BufEnter * if &buftype == 'terminal' | :set nocursorline | endif

" Vim Fugitive Improvements
" Close fugitive buffers automatically
" http://vimcasts.org/episodes/fugitive-vim-browsing-the-git-object-database/
autocmd BufReadPost fugitive://* set bufhidden=delete

" Move cursor to the end if yanking in visual mode
vnoremap y ygv<Esc>

" Highlight yank (Requires nightly nvim)
augroup LuaHighlight
  autocmd!
  autocmd TextYankPost * silent! lua require'vim.highlight'.on_yank()
augroup END

" Copy to clipboard in visualmode
vnoremap <leader>cp "*y<cr>

" Fix Whitespace
nnoremap <leader>W :FixWhitespace<enter>

" Behave sanely when opening a terminal in neovim.
function! s:OnTermOpen(buf)
	setl nolist norelativenumber nonumber
	if &buftype ==# 'terminal'
		nnoremap <buffer> q :<C-U>bd!<CR>
	endif
endfunction

" Make closing the terminal easier
if has('nvim')
  tmap <C-o> <C-\><C-n>
endif

augroup autocmds
	autocmd!
	" Update signature help on jump placeholder (useful for floating
	" window)
	autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
	autocmd TermOpen  *  :call s:OnTermOpen(+expand('<abuf>'))
augroup end


" -----------------------------------------------------------------------------
" Navigation.
"
" Getting around town! This part of the conmfiguration is probably what I
" polish the most.
" -----------------------------------------------------------------------------
"
" I've admittedly forgotten what this line does, but I'm afraid of removing
" it. I use 'zz' all the time.
noremap <plug>(slash-after) zz

" For navigation between splits seamlessly.
nnoremap <c-j> <c-w>j
nnoremap <c-k> <c-w>k
nnoremap <c-h> <c-w>h
nnoremap <c-l> <c-w>l

" Also when in a terminal.
tnoremap <c-j> <C-\><C-N><c-w>j
tnoremap <c-k> <C-\><C-N><c-w>k
tnoremap <c-h> <C-\><C-N><c-w>h
tnoremap <c-l> <C-\><C-N><c-w>l

" Use tab to toggle between most recently looked at buffers.
nmap <Tab> :b#<CR>

" SNEAK!
"replace 'f' with 1-char Sneak
nmap f <Plug>Sneak_f
nmap F <Plug>Sneak_F
xmap f <Plug>Sneak_f
xmap F <Plug>Sneak_F
omap f <Plug>Sneak_f
omap F <Plug>Sneak_F
""replace 't' with 1-char Sneak
nmap t <Plug>Sneak_t
nmap T <Plug>Sneak_T
xmap t <Plug>Sneak_t
xmap T <Plug>Sneak_T
omap t <Plug>Sneak_t
omap T <Plug>Sneak_T

" -----------------------------------------------------------------------------
" File Management.
" -----------------------------------------------------------------------------

" Close the currently focused buffer.
nnoremap <leader>bd :bd<cr>

" Navigate between files in a project!
nnoremap <leader>sb :Buffers<cr>
nnoremap <leader>sp :Files<cr>
nnoremap <leader>sm :FZFMru<cr>

" FZF Specific Configuration.
let $FZF_DEFAULT_COMMAND = 'rg --files --hidden'
let g:fzf_layout = { 'window': { 'width': 0.9, 'height': 0.6 } }

let g:fzf_mru_relative = 0

" Find word under cursor in project.
nmap <leader>* :Rg <c-r>=expand("<cword>")<cr><cr>

" Git bindings!
nnoremap <leader>gs :G<cr><c-n><c-n><c-n>
nnoremap <leader>gp :Gpush<cr>

nnoremap <leader>gr :Git stat<cr>

nnoremap <leader>gh :Gbrowse!<cr>
vnoremap <leader>gh :Gbrowse!<cr>
nnoremap <leader>gd :Gdiff master<cr>zR

nnoremap <leader>gt <Plug>(git-time-lapse)

nnoremap <leader>hN :GitGutterPrevHunk<cr>
nnoremap <leader>hn :GitGutterNextHunk<cr>

let g:gitgutter_highlight_linenrs=1

let g:vimwiki_list = [{'path':'~/Nextcloud/wiki/', 'syntax': 'markdown', 'ext': '.md'}]
let g:zettel_fzf_command = "rg --column --line-number --ignore-case --no-heading --color=always "

" -----------------------------------------------------------------------------
" COC and LSP Related Configuration
"
" -----------------------------------------------------------------------------

" I used to use tagbar but this gets me more, and is quicker.
nnoremap <silent> <leader>co  :<C-u>CocFzfList outline<CR>

" Snippets and autocomplete
inoremap <silent><expr> <TAB>
      \ pumvisible() ? coc#_select_confirm() :
      \ coc#expandableOrJumpable() ? "\<C-r>=coc#rpc#request('doKeymap', ['snippets-expand-jump',''])\<CR>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

let g:coc_snippet_next = '<tab>'

nnoremap <leader>es :CocCommand snippets.editSnippets<cr>

" Use <cr> to confirm completion, `<C-g>u` means break undo chain at current
" position Coc only does snippet and additional edit on confirm.
inoremap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"

" Use `[c` and `]c` to navigate diagnostics
nmap <silent> [c <Plug>(coc-diagnostic-prev)
nmap <silent> ]c <Plug>(coc-diagnostic-next)

" Remap keys for gotos
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gD :vsp<CR><Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)


" Remap for rename current word
nmap <leader>rn <Plug>(coc-rename)

" Use K to show documentation in preview window
nnoremap <silent> K :call <SID>show_documentation()<CR>

function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  else
    call CocAction('doHover')
  endif
endfunction

" Highlight symbol under cursor on CursorHold
autocmd CursorHold * silent call CocActionAsync('highlight')
