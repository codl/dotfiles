set encoding=utf-8
scriptencoding utf-8

call plug#begin('~/.local/share/nvim/plugged')

Plug 'dietsche/vim-lastplace'
Plug 'tpope/vim-sleuth'

Plug 'ctrlpvim/ctrlp.vim'
Plug 'tpope/vim-vinegar'

Plug 'tpope/vim-fugitive'
Plug 'airblade/vim-gitgutter'

Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
Plug 'zchee/deoplete-jedi'

Plug 'godlygeek/tabular', { 'on': 'Tabularize' }
Plug 'mileszs/ack.vim', { 'on': 'Ack' }

Plug 'ap/vim-css-color'

Plug 'dag/vim-fish'

Plug 'jkramer/vim-checkbox'

Plug 'freitass/todo.txt-vim'

Plug 'w0rp/ale'

Plug 'tpope/vim-obsession'

call plug#end()

set nocompatible

set mouse=a

filetype plugin indent on
syntax on

let mapleader = ","
let maplocalleader = ","

set showcmd " show the command currently being typed
set showmode " yep, show the mode. how exciting.
set laststatus=2 " always show filename

set wrap
set linebreak " ⚠ only takes effect when list is disabled

" indentation crap
set shiftwidth=4 " autoindent 4 spaces
set shiftround " when indenting / deleting indentation, round to shiftwidth
set smarttab   " ^ same thing with <Tab>
set tabstop=4 " a tab is as wide as 4 spaces
set expandtab " <Tab> inserts spaces
set autoindent " keep indentation on carriage return
set copyindent " ^ use previous line's indentation

set backspace=indent,eol,start " fuck you I backspace what I want

set incsearch
set hlsearch " highlight search matches
set ignorecase " ignore case in search string
set smartcase  " ^ unless there is at least one uppercase character

set nobackup " backups are annoying
set writebackup " backup file during write

set colorcolumn=+1 " hilight 81st column
set tw=0

set history=100
set undolevels=1000
set undodir=~/.local/share/nvim/undo " persistent undo
set undofile                         " ^

set wildignore=*.bak,*.pyc,*.class,*.o,*.d
set wildignore+=*/venv/*,*/.git/*,*/node_modules/*
set pastetoggle=<F2> " press f2 in insert mode to disable paste-harmful features

set wildmenu " show a sexy menu when tab-completing

" Folding
set foldmethod=indent " use indentation to specify folds
" fold/unfold with space
nnoremap <space> za
set foldminlines=3 " a fold must be at least 3 lines
set foldnestmax=8
set foldlevel=100 " start with all folds open
set foldignore=\"#/; " ignore comment characters when folding

set scrolloff=2 " start scrolling 3 lines before window border

set diffopt+=vertical " why the fuck would you want horizontal diff

colorscheme default
set background=light

" I never use gvim, but who knows?
set guioptions=aFi
set guicursor+=a:blinkon0 " disable cursor blinking
set guifont=DejaVu\ Sans\ Mono\ for\ Powerline\ 9

" split to the right, not to the left
set splitright

" fuck arrow keys
map <up> <nop>
map <down> <nop>
map <left> <nop>
map <right> <nop>

" quick file switch with ,;
nnoremap <leader>; <C-^>

" quick scroll
noremap à 10k
noremap ç 10j

set listchars=nbsp:␣,tab:\|\ ,trail:␣,extends:>,precedes:<
set list

set winwidth=80

" fast escape out of insert mode
set ttimeoutlen=10

if has("autocmd")
    augroup Dispatch
        autocmd!
        autocmd BufNewFile,BufRead *.md set filetype=markdown
        autocmd FileType go let b:dispatch = 'go build'
        autocmd FileType ruby let b:dispatch = 'rake'
        autocmd FileType * if !empty(glob("nanoc.yaml"))  | let b:dispatch = 'nanoc' | endif
        autocmd FileType * if !empty(glob("../nanoc.yaml"))  | let b:dispatch = 'cd ..; nanoc' | endif
    augroup END
    augroup Filetypes
        autocmd!
        autocmd BufNewFile,BufRead *.p8 set noexpandtab
    augroup END
endif

nnoremap <leader>k :Dispatch<CR>
nnoremap <leader>j :Dispatch!<CR>
nnoremap <leader>K :Dispatch

let g:ctrlp_map = ';;'
nnoremap ;, :CtrlPMRUFiles<CR>
let g:ctrlp_show_hidden = 1
let g:ctrlp_max_files = 100000
" let g:ctrlp_user_command = ['.git', 'cd %s; git ls-files']
let g:ctrlp_root_markers = ['.stfolder']

let g:syntastic_javascript_checkers = ['eslint']

set updatetime=1000

let g:ackprg = 'ag --vimgrep'
command -nargs=* Ag Ack <args>

let g:deoplete#enable_at_startup = 1

" use tab key for navigating completions
inoremap <expr> <Tab> pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"

let g:netrw_sort_by = 'time'
let g:netrw_sort_direction = 'reverse'

tnoremap <A-e> <C-\><C-n>
tnoremap <C-w><C-w> <C-\><C-n><C-w><C-w>

let g:ale_fixers = {
\   'python': ['yapf'],
\}
