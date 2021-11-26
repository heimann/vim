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
" David Heimann (2021)
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
set updatetime=50

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
" Plug 'wadackel/vim-dogrun'
Plug 'embark-theme/vim', { 'as': 'embark', 'branch': 'main' }
Plug 'bronson/vim-trailing-whitespace' " Show trailing whitespace
Plug 'tpope/vim-commentary'
" Plug 'josegamez82/starrynight'

" Git Stuff
Plug 'airblade/vim-gitgutter'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-rhubarb'

" telescope requirements...
Plug 'nvim-lua/popup.nvim'
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim'
Plug 'nvim-telescope/telescope-fzf-native.nvim', { 'do': 'make', 'branch': 'main' }

Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'

Plug 'justinmk/vim-sneak'       " Get around in your files.
Plug 'farmergreg/vim-lastplace' " open files at the last edited place
Plug 'heimann/vim-slash'        " improve / search experience
Plug 'junegunn/vim-peekaboo'    " See registers when using `'` and `@`

" Neovim LSP
Plug 'neovim/nvim-lspconfig'
"Plug 'nvim-lua/completion-nvim'
Plug 'kyazdani42/nvim-web-devicons'
Plug 'folke/trouble.nvim', { 'branch': 'main'}


" File Navigation
Plug 'liuchengxu/vista.vim'

" Navigate between tmux and vim splits seamlessly
Plug 'christoomey/vim-tmux-navigator'

Plug 'ludovicchabant/vim-gutentags' "For tag management

" Language Support
Plug 'elixir-editors/vim-elixir'
Plug 'sheerun/vim-polyglot'
Plug 'vim-test/vim-test'       " Run test suites
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}  " We recommend updating the parsers on update

" Code navigation
Plug 'hrsh7th/cmp-nvim-lsp', { 'branch': 'main'}
Plug 'hrsh7th/cmp-buffer', { 'branch': 'main'}
Plug 'hrsh7th/nvim-cmp', { 'branch': 'main'}

" For vsnip user.
Plug 'hrsh7th/cmp-vsnip', { 'branch': 'main'}
Plug 'hrsh7th/vim-vsnip'

" Plug 'wellle/context.vim'
Plug 'kshenoy/vim-signature'

" Knowledge management.
" Plug 'vimwiki/vimwiki'
" Plug 'michal-h21/vim-zettel'

" Neovim specific hotness
Plug 'kassio/neoterm'

call plug#end()

if plug_install
    PlugInstall --sync
endif
unlet plug_install


" -----------------------------------------------------------------------------
" Theming and Aesthetics.
"
" This section gets a little convoluted but don't fret.
" -----------------------------------------------------------------------------

" I've been using nightfly for a while. I also make sure to configure the
" colors in my terminal to use the same basic palette.
"colorscheme nightfly
 " colorscheme dogrun
 colorscheme embark
" colorscheme starrynight


" I don't like the default comment highlighting in nightfly, so this changes
" it
"highlight Comment guifg=#081e2f guibg=#296596

" See 80th column
if (exists('+colorcolumn'))
    set colorcolumn=80
"    highlight ColorColumn guibg=#8b1e3f
    highlight ColorColumn guibg=#000000
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

" -----------------------------------------------------------------------------
" Behaviours.
" ---------------------------------------------------------------------------- If you're in a terminal, you don't want line numbers :)
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

" autocmd CursorHold * lua vim.lsp.diagnostic.show_line_diagnostics({ focusable = false })

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

" Neoterm bindings and config
nnoremap <leader>tm :Ttoggle<cr>
vnoremap <leader>tr :TREPLSendSelection<cr>
nnoremap <leader>tr :TREPLSendFile<cr>
let g:neoterm_default_mod = "vertical"
let g:neoterm_autoscroll = 1

" Vim-test Settings
nnoremap <leader>tt :TestSuite<cr>
nnoremap <leader>tf :TestFile<cr>
let test#strategy = "neoterm"

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
nnoremap <Tab> :b#<CR>

nnoremap <s-Tab> :tabnext<CR>

" Use leader space to get rid of highlighting after a search)
nmap <Leader><space> :nohl<cr>

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

" Sneak config
let g:sneak#label = 1
let g:sneak#use_ic_scs = 1

" -----------------------------------------------------------------------------
" File Management.
" -----------------------------------------------------------------------------

let g:gutentags_exclude_filetypes = ['gitcommit', 'gitconfig', 'gitrebase', 'gitsendemail', 'git']

" Close the currently focused buffer.
nnoremap <leader>bd :bd<cr>

" Navigate between files in a project!
nnoremap <leader>sb :Telescope buffers<cr>
nnoremap <leader>sp :Files<cr>
nnoremap <leader>sm :Telescope oldfiles<cr>
nnoremap <leader>sf :Rg<cr>
nnoremap <leader>co :Telescope tags<cr>
nnoremap <leader>cm :Telescope lsp_document_symbols<cr>
nnoremap <leader>ce :Telescope lsp_document_diagnostics<cr>
nnoremap <leader>cr :Telescope lsp_references<cr>

nnoremap <leader>cv :Vista!!<cr>

" Find word under cursor in project.
nmap <leader>* :Rg <c-r>=expand("<cword>")<cr><cr>

" nmap <leader>* yiw:Telescope live_grep <C-r>"<cr><c-r>=expand("<cword>")<cr><cr>

nnoremap <leader>* :lua require('telescope.builtin').grep_string { search = vim.fn.expand("<cword>"), word_match = "-w", shorten_path = true, only_osrt_text = true}<CR>


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

" Notes taking stuff
nnoremap <leader>n :tab drop tmp/notes.md<CR>

let g:gitgutter_highlight_linenrs=1

let g:vimwiki_list = [{'path':'~/Nextcloud/wiki/', 'syntax': 'markdown', 'ext': '.md'}]
let g:zettel_fzf_command = "rg --column --line-number --ignore-case --no-heading --color=always "

set completeopt=menu,menuone,noselect

" LSP Stuff
" see: https://medium.com/swlh/neovim-lsp-dap-and-fuzzy-finder-60337ef08060
"
" -------------------- LSP ---------------------------------
:lua << EOF
  local telescope = require('telescope')
  require("trouble").setup {
    -- your configuration comes here
    -- or leave it empty to use the default settings
    -- refer to the configuration section below
  }


  telescope.setup {
    extensions = {
      fzf = {
        fuzzy = true,
        override_generic_sorter = true,
        override_file_sorter = true,
        case_mode = "smart_case",
      }
    }
  }

  telescope.load_extension('fzf')

  local nvim_lsp = require('lspconfig')

  local on_attach = function(client, bufnr)
    local function buf_set_keymap(...) vim.api.nvim_buf_set_keymap(bufnr, ...) end
    local function buf_set_option(...) vim.api.nvim_buf_set_option(bufnr, ...) end

    buf_set_option('omnifunc', 'v:lua.vim.lsp.omnifunc')

    -- Mappings
    local opts = { noremap=true, silent=true }
    buf_set_keymap('n', 'gD', '<Cmd>lua vim.lsp.buf.declaration()<CR>', opts)
    buf_set_keymap('n', 'gd', '<Cmd>lua vim.lsp.buf.definition()<CR>', opts)
    buf_set_keymap('n', 'K', '<Cmd>lua vim.lsp.buf.hover()<CR>', opts)
    buf_set_keymap('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)
    buf_set_keymap('n', '<C-s>', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
    buf_set_keymap('n', '<space>wa', '<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>', opts)
    buf_set_keymap('n', '<space>wr', '<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>', opts)
    buf_set_keymap('n', '<space>wl', '<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>', opts)
    buf_set_keymap('n', '<space>D', '<cmd>lua vim.lsp.buf.type_definition()<CR>', opts)
    buf_set_keymap('n', '<space>rn', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
    buf_set_keymap('n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>', opts)
    buf_set_keymap('n', '[d', '<cmd>lua vim.lsp.diagnostic.goto_prev()<CR>', opts)
    buf_set_keymap('n', ']d', '<cmd>lua vim.lsp.diagnostic.goto_next()<CR>', opts)
    buf_set_keymap('n', '<space>q', '<cmd>lua vim.lsp.diagnostic.set_loclist()<CR>', opts)

    -- Set some keybinds conditional on server capabilities
    if client.resolved_capabilities.document_formatting then
        buf_set_keymap("n", "<space>f", "<cmd>lua vim.lsp.buf.formatting()<CR>", opts)
    elseif client.resolved_capabilities.document_range_formatting then
        buf_set_keymap("n", "<space>f", "<cmd>lua vim.lsp.buf.formatting()<CR>", opts)
    end

    -- Set autocommands conditional on server_capabilities
    if client.resolved_capabilities.document_highlight then
        require('lspconfig').util.nvim_multiline_command [[
        :hi LspReferenceRead cterm=bold ctermbg=red guibg=LightYellow
        :hi LspReferenceText cterm=bold ctermbg=red guibg=LightYellow
        :hi LspReferenceWrite cterm=bold ctermbg=red guibg=LightYellow
        augroup lsp_document_highlight
            autocmd!
            autocmd CursorHold <buffer> lua vim.lsp.buf.document_highlight()
            autocmd CursorMoved <buffer> lua vim.lsp.buf.clear_references()
        augroup END
        ]]
    end
  end

  local cmp = require'cmp'

  cmp.setup({
    snippet = {
      expand = function(args)
        -- For `vsnip` user.
        vim.fn["vsnip#anonymous"](args.body)

        -- For `luasnip` user.
        -- require('luasnip').lsp_expand(args.body)

        -- For `ultisnips` user.
        -- vim.fn["UltiSnips#Anon"](args.body)
      end,
    },
    mapping = {
      ['<C-d>'] = cmp.mapping.scroll_docs(-4),
      ['<C-f>'] = cmp.mapping.scroll_docs(4),
      ['<C-Space>'] = cmp.mapping.complete(),
      ['<C-e>'] = cmp.mapping.close(),
      ['<CR>'] = cmp.mapping.confirm({ select = false }),
    },
    sources = {
      { name = 'nvim_lsp' },

      -- For vsnip user.
      { name = 'vsnip' },

      -- For luasnip user.
      -- { name = 'luasnip' },

      -- For ultisnips user.
      -- { name = 'ultisnips' },

      { name = 'buffer' },
    }
  })
  local util = require 'lspconfig/util'

  vim.lsp.set_log_level("debug")

  require'lspconfig'.tsserver.setup{
      cmd = { "typescript-language-server", "--stdio" };
      filetypes = { "javascript", "javascriptreact", "javascript.jsx", "typescript", "typescriptreact", "typescript.tsx" };
      root_dir = util.root_pattern("package.json", "tsconfig.json", "jsconfig.json", ".git");
      on_attach = on_attach,
      capabilities = require('cmp_nvim_lsp').update_capabilities(vim.lsp.protocol.make_client_capabilities()),
  }

  require'lspconfig'.elixirls.setup{
    cmd = { os.getenv("HOME") .. "/Code/languageservers/elixir-ls/language_server.sh" };
    on_attach = on_attach,
    capabilities = require('cmp_nvim_lsp').update_capabilities(vim.lsp.protocol.make_client_capabilities()),
    }
EOF

" Treesitter configuration
lua <<EOF
require'nvim-treesitter.configs'.setup {
  ensure_installed = "maintained", -- one of "all", "maintained" (parsers with maintainers), or a list of languages
  indent = {
    enable = true
  },
  highlight = {
    enable = true,              -- false will disable the whole extension
    -- Setting this to true will run `:h syntax` and tree-sitter at the same time.
    -- Set this to `true` if you depend on 'syntax' being enabled (like for indentation).
    -- Using this option may slow down your editor, and you may see some duplicate highlights.
    -- Instead of true it can also be a list of languages
    additional_vim_regex_highlighting = true,
  },
}
EOF


