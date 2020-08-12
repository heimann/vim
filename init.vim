set encoding=utf-8
set laststatus=2
syntax on
" Wrap gitcommit file types at the appropriate length
filetype indent plugin on

if empty(glob('~/.vim/autoload/plug.vim'))
    silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
	\ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
    autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

call plug#begin('~/.vim/plugged')

Plug 'altercation/vim-colors-solarized'
Plug 'bronson/vim-trailing-whitespace'
" Unite
" "   depend on vimproc
" "   ------------- VERY IMPORTANT ------------
" "   you have to go to .vim/plugin/vimproc.vim and do a ./make
" "   -----------------------------------------
" Plug 'kien/ctrlp.vim'

Plug 'rking/ag.vim'

Plug 'mhinz/vim-startify'

" Git Plugins
Plug 'airblade/vim-gitgutter'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-rhubarb'
Plug 'junegunn/gv.vim'
Plug 'rhysd/git-messenger.vim'
Plug 'junkblocker/git-time-lapse'
Plug  'christoomey/vim-conflicted'


" Typing and Navigation
Plug 'kana/vim-textobj-user'
Plug 'bps/vim-textobj-python'
Plug 'townk/vim-autoclose'                  " auto insert matching brackets etc
Plug 'tpope/vim-eunuch'
Plug 'justinmk/vim-sneak'
Plug 'tpope/vim-unimpaired'
Plug 'tommcdo/vim-lion'
"Plug 'reedes/vim-pencil'
Plug 'junegunn/goyo.vim'
Plug 'junegunn/limelight.vim'
Plug 'danilamihailov/beacon.nvim'           " Highlight jumped to line

" Zettel
 Plug 'BurntSushi/ripgrep'
 Plug 'ihsanturk/neuron.vim'


" Themes & Styling
Plug 'junegunn/seoul256.vim'
"Plug 'morhetz/gruvbox'
"Plug 'haishanh/night-owl.vim'
"Plug 'rakr/vim-one'
"Plug 'joshdick/onedark.vim'
Plug 'srcery-colors/srcery-vim'
Plug 'bluz71/vim-nightfly-guicolors'
"Plug 'bluz71/vim-nightfly-guicolors'


"Plug 'vim-airline/vim-airline'
Plug 'itchyny/lightline.vim'

" Behavior
Plug 'psliwka/vim-smoothie'               " smooth scrolling with c-d/c-u
Plug 'farmergreg/vim-lastplace'           " open files at the last edited place
Plug 'heimann/vim-slash'                  " improve / search experience
Plug 'mcchrish/nnn.vim'                   " File manager

"Plug 'elixir-editors/vim-elixir'
"Plug 'ervandew/supertab'
"Plug 'mileszs/ack.vim'
Plug 'tpope/vim-rails'
Plug 'danchoi/ri.vim'
Plug 'sheerun/vim-polyglot'
"Plug 'vim-ctrlspace/vim-ctrlspace'        " Navigation between projects etc

Plug 'scrooloose/nerdcommenter'
Plug 'scrooloose/nerdtree'
Plug 'Xuyuanp/nerdtree-git-plugin'
Plug 'ludovicchabant/vim-gutentags' "For tag management
Plug 'majutsushi/tagbar' " More tag management

Plug 'liuchengxu/vista.vim'
"Plug 'w0rp/ale' "linting
" Plug 'unblevable/quick-scope' " Movement

" Move between vim and tmux panes seamlessly
Plug 'christoomey/vim-tmux-navigator'


" FZF installed through homebrew
Plug '/usr/local/opt/fzf'
Plug 'junegunn/fzf.vim'
Plug 'pbogut/fzf-mru.vim'
"Plug 'shougo/neomru.vim'                     " Required by fzf-preview.vim
"Plug 'yuki-ycino/fzf-preview.vim', { 'do': ':FzfPreviewInstall' }

" Build the extra binary if cargo exists on your system.
Plug 'liuchengxu/vim-clap', { 'do': ':Clap install-binary' } " Still use for grep
"Plug 'voldikss/vim-floaterm'                 " Floating terminal

Plug 'honza/vim-snippets'

" Tools for programming
Plug 'rizzatti/dash.vim'
Plug 'kshenoy/vim-signature' "Massrks
Plug 'junegunn/vim-peekaboo'
"Plug 'SirVer/ultisnips' "Snippets management
"Plug 'honza/vim-snippets' " The actual snippets
"Plug 'https://github.com/Alok/notational-fzf-vim' "Notational Velocity
Plug 'vimwiki/vimwiki'
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'antoinemadec/coc-fzf'
Plug 'vim-test/vim-test'                        " Run test suites

" Neovim specific hotness
Plug 'kassio/neoterm'

" Delve for Go debugging and vim-go through polyglot doesn't seem to work
Plug 'sebdah/vim-delve'
Plug 'fatih/vim-go', { 'do': ':GoUpdateBinaries' }

" Elixir Specific
"Plug 'slashmili/alchemist.vim'

Plug 'wellle/context.vim'
Plug 'ryanoasis/vim-devicons'


call plug#end()

" STYLING

" -- solarized personal conf
set background=dark

" See 80th column
if (exists('+colorcolumn'))
    set colorcolumn=80
    "highlight ColorColumn ctermbg=2
endif

let &colorcolumn=join(range(81,999),",") " extend column highlight beyond 80

" LEADER COMMANDS

let mapleader = "\<Space>"
set ttimeout
set ttimeoutlen=1

tnoremap <C-\><C-n>


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

" NAVIGATION
" scroll the viewport faster
" from: https://github.com/nicknisi/dotfiles/blob/master/config/nvim/init.vim
nnoremap <C-e> 6<C-e>
nnoremap <C-y> 6<C-y>

nnoremap <F5> :Startify<cr>

let g:smoothie_base_speed=30

let g:lastplace_ignore_buftype = "quickfix,nofile,help"

let g:CtrlSpaceDefaultMappingKey = '<C-space> '
"nnoremap <leader><F10> :Clap floaterm<cr>

noremap <plug>(slash-after) zz

" Context specific settings

let g:context_enabled = 0
nnoremap <leader>tc :ContextToggleWindow<CR>

"if has('win32')
  "let s:vimfiles = '~/vimfiles'
  "let s:os   = 'windows'
"else
  "let s:vimfiles = '~/.vim'
  "if has('mac') || has('gui_macvim')
    "let s:os = 'darwin'
  "else
    "" elseif has('gui_gtk2') || has('gui_gtk3')
    "let s:os = 'linux'
  "endif
"endif

if executable("ag")
    let g:CtrlSpaceGlobCommand = 'ag -l --nocolor -g ""'
endif


"let g:CtrlSpaceFileEngine = s:vimfiles . '/plugged/vim-ctrlspace' . '/bin/file_engine_' . s:os . '_amd64'

" Jump to the current quickfix item and center it

nnoremap [<Space> :ll<cr>zz

" Absolute > Relative Numbers
"
"set rnu
set number


set cursorline
"set cursorline
"set number relativenumber
"
" Except if it's a terminal
"
"set guicursor+=n:hor20
"
"set relativenumber
"if exists('&cursorlineopt')
    "set cursorlineopt=number
    "set cursorline
"endif

"function! RelativeNumberActivity(mode)
    "if &diff
        "" For diffs, do nothing since we want relativenumbers in all windows.
        "return
    "endif
    "if &buftype == "nofile" || &buftype == "nowrite"
        "setlocal nonumber
    "elseif a:mode == "active"
        "setlocal relativenumber
        "if exists('&cursorlineopt')
            "setlocal cursorline
        "endif
    "else
        "setlocal norelativenumber
        "if exists('&cursorlineopt')
            "setlocal nocursorline
        "endif
    "endif
"endfunction

"augroup CustomWindowActivity
    "autocmd!
    "autocmd WinEnter * call RelativeNumberActivity("active")
    "autocmd WinLeave * call RelativeNumberActivity("inactive")
    "if exists('&cursorlineopt')
        "autocmd FileType nerdtree setlocal cursorlineopt=both
    "endif
"augroup END

"au BufEnter * if &buftype == 'terminal' | :startinsert | endif
au BufEnter * if &buftype == 'terminal' | :set nonumber | endif
au BufEnter * if &buftype == 'terminal' | :set nornu | endif
au BufEnter * if &buftype == 'terminal' | :set nocursorline | endif

" Set cursor in the same place when switching buffers
set nostartofline

"augroup numbertoggle
  "autocmd!
  "autocmd BufEnter,FocusGained,InsertLeave * set relativenumber
  "autocmd BufLeave,FocusLost,InsertEnter   * set norelativenumber
"augroup END
"

" Vim Fugitive Improvements
" Close fugitive buffers automatically
" http://vimcasts.org/episodes/fugitive-vim-browsing-the-git-object-database/
autocmd BufReadPost fugitive://* set bufhidden=delete

" Code searching and file management
if executable('ag')
  " Use Ag over Grep
  set grepprg=ag\ --nogroup\ --nocolor\ --hidden\ --ignore\ .git

  " Use ag in CtrlP for listing files. Lightning fast and respects .gitignore
  let g:ctrlp_user_command = 'ag %s -l --nocolor -g ""'
endif

let $FZF_DEFAULT_COMMAND = 'rg --files --hidden'

"nmap ¨ :Ag <c-r>=expand("<cword>")<cr><cr>
"nnoremap <Leader>/ :Ag
"nnoremap <Leader>? :Ag <cword><cr>

nmap <leader>* :Rg <c-r>=expand("<cword>")<cr><cr>
"nnoremap <Leader>* :Rg <cword><cr>
nnoremap <Leader>? :GFiles?<cr>

" autocmd BufWritePost *.exs,*.ex silent :!mix format %


" Theming
set backspace=indent,eol,start

set termguicolors

" seoul256 (dark):
"   Range:   233 (darkest) ~ 239 (lightest)
"   Default: 237
"let g:seoul256_background = 233
"colo seoul256

"colorscheme srcery
colorscheme nightfly
"set background=dark
"
highlight Comment guifg=#081e2f guibg=#296596


" Fuzzy Search
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

" set list " show invisible characters

" Stew's status line from gary bernhardt:
" https://github.com/garybernhardt/dotfiles/blob/master/.vimrc
"set statusline=%<%f\ (%{&ft})\ %-4(%m%)%=%-19(%3l,%02c%03V%)[%p%%]
"set statusline+=%{exists('g:loaded_fugitive')?fugitive#statusline():''}

"set statusline =
"" Buffer number
"set statusline +=[%n]
"" File description
"set statusline +=%f\ %h%m%r%w
"" Filetype
"set statusline +=%y
"" Name of the current branch (needs fugitive.vim)
"set statusline +=\ %{fugitive#statusline()}
"" Line, column and percentage
"set statusline +=%=%-14.(%l,%c%V%)\ %P
"
"
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

set noshowmode        " Lightline shows us the mode.
set fillchars+=vert:\|
"highlight VertSplit guibg=#ae81ff guifg=#011627 ctermbg=6 ctermfg=0
highlight VertSplit guibg=#011627 guifg=#ae81ff ctermbg=6 ctermfg=0

" sppaces > tabs
set tabstop=2
set softtabstop=2
set shiftwidth=2
set autoindent
set smarttab
set expandtab

" Set nice indentation for wraps
set breakindent
set breakindentopt=shift:2,min:40,sbr

" Fix [200^ ... when pasting
set t_BE=


nnoremap <c-j> <c-w>j
nnoremap <c-k> <c-w>k
nnoremap <c-h> <c-w>h
nnoremap <c-l> <c-w>l

tnoremap <c-j> <C-\><C-N><c-w>j
tnoremap <c-k> <C-\><C-N><c-w>k
tnoremap <c-h> <C-\><C-N><c-w>h
tnoremap <c-l> <C-\><C-N><c-w>l

" Tabs
"nnoremap <F7> :tabp<enter>
"nnoremap <F8> :tabn<enter>

" Search
"nnoremap <F9> :cp<enter>
"nnoremap <F10> :cn<enter>
"nnoremap <leader><F9> :ccl<cr>
"nnoremap <leader><F10> :ccl<cr>:%bd<cr>:e#<cr><c-o><c-o>

" Buffer management
nnoremap <leader>D :bd<cr>

nmap <Tab> :b#<CR>

set number

" Open Explore
nnoremap <leader>e :Exp<enter>

" Tab
" vnoremap <tab> %
" nnoremap <tab> %
"
let g:clap_provider_dotfiles = {
      \ 'source': ['~/.config/nvim/init.vim', '~/.zshrc', '~/.tmux.conf'],
      \ 'sink': 'e',
      \ }

let g:fzf_layout = { 'window': { 'width': 0.9, 'height': 0.6 } }
"let g:fzf_layout = { 'window': 'call createcenteredfloatingwindow()' }
"let $fzf_default_opts="--reverse " " top to bottom

"let g:fzf_preview_use_floating_window = 1
"let g:fzf_preview_filelist_command = 'rg --files --hidden --follow --no-messages -g \!"* *"'
"let g:fzf_preview_fzf_preview_window_option = 'up:70%'

" From: https://github.com/Blacksuan19/init.nvim/blob/master/init.vim

"function! CreateCenteredFloatingWindow()
    "let width = min([&columns - 4, max([80, &columns - 20])])
    "let height = min([&lines - 4, max([20, &lines - 10])])
    "let top = ((&lines - height) / 2) - 1
    "let left = (&columns - width) / 2
    "let opts = {'relative': 'editor', 'row': top, 'col': left, 'width': width, 'height': height, 'style': 'minimal'}

    "let top = "╭" . repeat("─", width - 2) . "╮"
    "let mid = "│" . repeat(" ", width - 2) . "│"
    "let bot = "╰" . repeat("─", width - 2) . "╯"
    "let lines = [top] + repeat([mid], height - 2) + [bot]
    "let s:buf = nvim_create_buf(v:false, v:true)
    "call nvim_buf_set_lines(s:buf, 0, -1, v:true, lines)
    "call nvim_open_win(s:buf, v:true, opts)
    "set winhl=Normal:Floating
    "let opts.row += 1
    "let opts.height -= 2
    "let opts.col += 2
    "let opts.width -= 4
    "call nvim_open_win(nvim_create_buf(v:false, v:true), v:true, opts)
    "au BufWipeout <buffer> exe 'bw '.s:buf
"endfunction

" FZF
nnoremap <c-f> :Rg!<cr>
"nnoremap <leader>:Clap history<enter>


let g:fzf_mru_relative = 1
"let g:fzf_layout = { 'window': 'call OpenFloatingWin()' }

function! s:change_working_directory(path)
    execute 'cd' a:path
    execute 'Files'
    execute 'startinsert'
endfunction


command! -nargs=? -complete=dir AF
  \ call fzf#run(fzf#wrap({
  \   'source': 'fd -t d . $HOME '.expand(<q-args>),
  \   'sink' : {path -> s:change_working_directory(path)}
  \ }))

nnoremap <a-c> :AF<cr>

"function! FloatingFZF()
  "let buf = nvim_create_buf(v:false, v:true)
  "call setbufvar(buf, '&signcolumn', 'no')

  "setlocal norelativenumber
  "setlocal nonumber

  "setlocal winhighlight=Normal:MarkdownError

  "let height = 10
  "let width = float2nr(&columns - (&columns * 2 / 10))
  "let col = float2nr((&columns - width) / 2)

  "let opts = {
        "\ 'relative': 'editor',
        "\ 'row': 50,
        "\ 'col': col,
        "\ 'width': width,
        "\ 'height': height
        "\ }

  "call nvim_open_win(buf, v:true, opts)
"endfunction

function! OpenFloatingWin()
  let height = &lines - 3
  let width = float2nr(&columns)
  let col = float2nr((&columns - width) / 2)

  "Set the position, size, etc. of the floating window.
  "The size configuration here may not be so flexible, and there's room for further improvement.
  let opts = {
        \ 'relative': 'editor',
        \ 'row': 0,
        \ 'col': col + width * 3 / 10 ,
        \ 'width': width,
        \ 'height': height / 3
        \ }

  let buf = nvim_create_buf(v:false, v:true)
  let win = nvim_open_win(buf, v:true, opts)

  "Set Floating Window Highlighting
  call setwinvar(win, '&winhl', 'Normal:Pmenu')

  setlocal
        \ buftype=nofile
        \ nobuflisted
        \ bufhidden=hide
        \ nonumber
        \ norelativenumber
        \ signcolumn=no
endfunction

" Autosave on loss of focus
au FocusLost * :wa

" Fix Whitespace
nnoremap <leader>W :FixWhitespace<enter>

" Edit vimrc
nnoremap <leader>ev <C-w><C-v><C-l>:e $MYVIMRC<cr>

" Open a split window and go to it.
nnoremap <leader>w <C-w>v<C-w>l

" Create splits to the right and below focused split
set splitbelow
set splitright

" Enter to save
nnoremap <silent><expr> <CR> empty(&buftype) ? ":up<CR>" : "<CR>"
" Automatically dsiplay buffers when no tabs are open
"let g:airline#extensions#tabline#enabled = 1
"let g:airline_theme='one'

" Shut up
set belloff=all

" Copy to clipboard in visualmode
vnoremap <leader>cp "*y<cr>

" Highlight yank (Requires nightly nvim)
augroup LuaHighlight
  autocmd!
  autocmd TextYankPost * silent! lua require'vim.highlight'.on_yank()
augroup END

" Move cursor to the end if yanking in visual mode
vnoremap y ygv<Esc>

" Toggle NERDTree with C-n.
map <C-n> :NERDTreeFind<CR>

let g:NERDTreeMapOpenVSplit="v"
let g:NERDTreeMapOpenSplit="s"
let g:NERDTreeWinPos = "left"
let g:NERDTreeAutoDeleteBuffer = 1
let g:NERDTreeMinimalUI = 1

" NNN Configuration for File Management
let g:nnn#command = 'nnn -n -e'

set lazyredraw

" Sneak config
let g:sneak#label = 1
let g:sneak#use_ic_scs = 1

" Folding
set foldmethod=indent
set foldnestmax=10
set nofoldenable
set foldlevel=2


" Tagbar
"let g:vista_default_executive = 'coc'
nnoremap <F11> :Goyo<CR>

" Navigation
nnoremap <leader>lt :Vista!!<CR> " toggle Vista
nnoremap <leader>st :Vista finder fzf<cr>
nnoremap <leader>sb :Buffers<cr>
nnoremap <leader>sp :Files<cr>
nnoremap <leader>sm :FZFMru<cr>

let g:tagbar_type_elixir = {
    \ 'ctagstype' : 'elixir',
    \ 'kinds' : [
        \ 'p:protocols',
        \ 'm:modules',
        \ 'e:exceptions',
        \ 'y:types',
        \ 'd:delegates',
        \ 'f:functions',
        \ 'c:callbacks',
        \ 'a:macros',
        \ 't:tests',
        \ 'i:implementations',
        \ 'o:operators',
        \ 'r:records'
    \ ],
    \ 'sro' : '.',
    \ 'kind2scope' : {
        \ 'p' : 'protocol',
        \ 'm' : 'module'
    \ },
    \ 'scope2kind' : {
        \ 'protocol' : 'p',
        \ 'module' : 'm'
    \ },
    \ 'sort' : 0
\ }

"let g:ale_fixers = {
"\  '*': ['remove_trailing_lines', 'trim_whitespace'],
"\  'javascript': ['eslint', 'prettier'],
"\  'ruby': [
"\      'rufo',
"\      'rubocop',
"\  ],
"\  'python': [
"\      'black',
"\  ],
"\  'elixir': [
"\      'mix_format',
"\  ],
"\  'sql': [
"\      'sqlfmt',
"\  ],
"\  'postgressql': [
"\      'prettier',
"\  ],
"\}

"let g:ale_python_black_options = '--line-length=80'
"let g:ale_fix_on_save = 1

nnoremap <leader>a :ALEFix<cr>
nmap <silent> <leader>aj :ALENext<cr>
nmap <silent> <leader>ak :ALEPrevious<cr>

" Quick-scope settings
" let g:qs_highlight_on_keys = ['f', 'F']

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

" : map (what was , before)
" map : <Plug>SneakPrevious

set tabpagemax=100

" Run project test suite
nnoremap <leader>tt :TestSuite<cr>
nnoremap <leader>tm :Ttoggle<cr>
nnoremap <leader>tk :Tkill<cr>
let test#strategy = "neoterm"

let g:neoterm_default_mod = "botright"

" Trigger configuration. Do not use <tab> if you use
" https://github.com/Valloric/YouCompleteMe.
" let g:UltiSnipsExpandTrigger="<c-tab>"
" let g:UltiSnipsJumpForwardTrigger="<c-b>"
" let g:UltiSnipsJumpBackwardTrigger="<c-z>"
"
"  If you want :UltiSnipsEdit to split your window.
" let g:UltiSnipsEditSplit="vertical"

" Fugitive config related stuff
"
" splits
 set diffopt+=vertical

 " shortcuts
 nnoremap <leader>g :G<cr>
 nnoremap <leader>gs :G<cr><c-n><c-n><c-n>
 nnoremap <leader>gp :Gpush<cr>

 nnoremap <leader>gr :Git stat<cr>

 nnoremap <leader>gh :Gbrowse!<cr>
 vnoremap <leader>gh :Gbrowse!<cr>
 nnoremap <leader>gd :Gdiff master<cr>zR

 nnoremap <leader>gt <Plug>(git-time-lapse)

 " Git Messenger Config
 let g:git_messenger_include_diff = "current"
 let g:git_messenger_always_into_popup = v:true


 " GitGutterStuff
 "
 nnoremap <leader>hN :GitGutterPrevHunk<cr>
 nnoremap <leader>hn :GitGutterNextHunk<cr>

 set updatetime=100

 let g:gitgutter_highlight_linenrs=1




 nnoremap <Leader>vr :source $MYVIMRC<CR>

" Mapping to see highlighting under cursor
 map <leader>H :echo "hi<" . synIDattr(synID(line("."),col("."),1),"name") . '> trans<'
       \ . synIDattr(synID(line("."),col("."),0),"name") . "> lo<"
       \ . synIDattr(synIDtrans(synID(line("."),col("."),1)),"name") . ">"<CR>


 let g:fzf_colors =
       \ { 'fg':      ['fg', 'Normal'],
   \ 'bg':      ['bg', 'Normal'],
   \ 'hl':      ['fg', 'Search'],
   \ 'fg+':     ['fg', 'Special'],
   \ 'bg+':     ['bg', 'Constant'],
   \ 'hl+':     ['fg', 'Statement'],
   \ 'info':    ['fg', 'PreProc'],
   \ 'border':  ['fg', 'Ignore'],
   \ 'prompt':  ['fg', 'Conditional'],
   \ 'pointer': ['fg', 'Exception'],
   \ 'marker':  ['fg', 'Keyword'],
   \ 'spinner': ['fg', 'Label'],
   \ 'header':  ['fg', 'Comment'] }

 let g:fzf_files_options = '--preview-window="top:60%" --ansi --bind page-up:preview-page-up,page-down:preview-page-down --preview="bat --color=always --style=header,grid --line-range :300 {}"'

let g:vimwiki_list = [{'path':'~/Nextcloud/wiki/', 'syntax': 'markdown', 'ext': '.md'}, {'path': '~/work/wiki', 'syntax': 'markdown', 'ext': '.md'}]

command! -bang -nargs=* Rg
      \ call fzf#vim#grep(
      \   'rg --column --line-number --no-heading --color=always --smart-case '.shellescape(<q-args>), 1,
      \   <bang>0 ? fzf#vim#with_preview('up:80%')
      \           : fzf#vim#with_preview('right:50%:hidden', '?'),
      \   <bang>0)


" CoC Stuff
nnoremap <silent> <leader>co  :<C-u>CocFzfList outline<CR>

" if hidden is not set, TextEdit might fail.
set hidden

" Some servers have issues with backup files, see #649
set nobackup
set nowritebackup

" Better display for messages
set cmdheight=2

" You will have bad experience for diagnostic messages when it's default 4000.
set updatetime=300

" don't give |ins-completion-menu| messages.
set shortmess+=c

" Use tab for trigger completion with characters ahead and navigate.
" Use command ':verbose imap <tab>' to make sure tab is not mapped by other plugin.
 "inoremap <silent><expr> <TAB>
      "\ pumvisible() ? "\<C-n>" :
      "\ <SID>check_back_space() ? "\<TAB>" :
      "\ coc#refresh()
"inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

"function! s:check_back_space() abort
  "let col = col('.') - 1
  "return !col || getline('.')[col - 1]  =~# '\s'
"endfunction

" Snippets related functionality
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



" Use <c-space> to trigger completion.
inoremap <silent><expr> <c-space> coc#refresh()

" Use <cr> to confirm completion, `<C-g>u` means break undo chain at current position.
" Coc only does snippet and additional edit on confirm.
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


" Use K to show documentation in preview window
nnoremap <silent> K :call <SID>show_documentation()<CR>

function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  else
    call CocAction('doHover')
  endif
endfunction

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

" Floating term settings
"let g:floaterm_position = 'center'
"let g:floaterm_winblend = 5

"let g:floaterm_keymap_new    = '<F10>'
"let g:floaterm_keymap_prev   = '<F7>'
"let g:floaterm_keymap_next   = '<F8>'
"let g:floaterm_keymap_toggle = '<F9>'

"let g:floaterm_width = 0.8
"let g:floaterm_height = 0.6

augroup autocmds
	autocmd!
	" Update signature help on jump placeholder (useful for floating
	" window)
	autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
	autocmd TermOpen  *  :call s:OnTermOpen(+expand('<abuf>'))
augroup end


" Highlight symbol under cursor on CursorHold
autocmd CursorHold * silent call CocActionAsync('highlight')

" Remap for rename current word
nmap <leader>rn <Plug>(coc-rename)

" Remap for format selected region
xmap <leader>f  <Plug>(coc-format-selected)
nmap <leader>f  <Plug>(coc-format-selected)

augroup mygroup
  autocmd!
  " Setup formatexpr specified filetype(s).
  autocmd FileType typescript,json setl formatexpr=CocAction('formatSelected')
  " Update signature help on jump placeholder
  autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
augroup end

" Remap for do codeAction of selected region, ex: `<leader>aap` for current paragraph
xmap <leader>a  <Plug>(coc-codeaction-selected)
nmap <leader>a  <Plug>(coc-codeaction-selected)

" Remap for do codeAction of current line
nmap <leader>ac  <Plug>(coc-codeaction)
" Fix autofix problem of current line
nmap <leader>qf  <Plug>(coc-fix-current)

" Use <tab> for select selections ranges, needs server support, like: coc-tsserver, coc-python
"nmap <silent> <TAB> <Plug>(coc-range-select)
"xmap <silent> <TAB> <Plug>(coc-range-select)
xmap <silent> <S-TAB> <Plug>(coc-range-select-backword)

" Use `:Format` to format current buffer
command! -nargs=0 Format :call CocAction('format')

" Use `:Fold` to fold current buffer
command! -nargs=? Fold :call     CocAction('fold', <f-args>)

" use `:OR` for organize import of current buffer
command! -nargs=0 OR   :call     CocAction('runCommand', 'editor.action.organizeImport')

" Add status line support, for integration with other plugin, checkout `:h coc-status`
set statusline^=%{coc#status()}%{get(b:,'coc_current_function','')}

" Using CocList
" Show all diagnostics
nnoremap <silent> <space>a  :<C-u>CocList diagnostics<cr>
" Manage extensions
nnoremap <silent> <space>e  :<C-u>CocList extensions<cr>
" Show commands
nnoremap <silent> <space>c  :<C-u>CocList commands<cr>
" Find symbol of current document
nnoremap <silent> <space>o  :<C-u>CocList outline<cr>
" Search workspace symbols
"nnoremap <silent> <space>s  :<C-u>CocList -I symbols<cr>
" Do default action for next item.
nnoremap <silent> <space>j  :<C-u>CocNext<CR>
" Do default action for previous item.
nnoremap <silent> <space>k  :<C-u>CocPrev<CR>
" Resume latest coc list
nnoremap <silent> <space>p  :<C-u>CocListResume<CR>

autocmd FileType json syntax match Comment +\/\/.\+$+

" Go Configuration
" Do auto imports and formatting on save
let g:go_fmt_command = "goimports"

" Marks
" nnoremap <C-m> :Marks!<CR>


" Markdown Improvements
" Goyo Configuration
function! s:goyo_enter()
  if executable('tmux') && strlen($TMUX)
    silent !tmux set status off
  endif
  set tw=80
  set fo+=t
endfunction

function! s:goyo_leave()
  if executable('tmux') && strlen($TMUX)
    silent !tmux set status on
  endif
  set tw=80
  set fo-=t
endfunction

let g:goyo_width = 160

autocmd! User GoyoEnter nested call <SID>goyo_enter()
autocmd! User GoyoLeave nested call <SID>goyo_leave()

nnoremap <leader>rr :Goyo<cr>

au BufRead,BufNewFile *.md setlocal textwidth=80

let g:gutentags_ctags_exclude = ['node_modules']

set scl=auto
set cmdheight=1
