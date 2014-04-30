if !isdirectory($HOME. "/.vim/bundle/pathogen")
    ! $HOME/.vim/bundle/fetch.sh
endif
runtime bundle/pathogen/autoload/pathogen.vim
execute pathogen#infect()

set nocompatible

set mouse=a
set ttymouse=xterm2 " screen sucks

filetype plugin indent on
syntax on

let mapleader = ","

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
set undodir=~/.vim/undo " persistent undo
set undofile            " ^

set wildignore=*.bak,*.pyc,*.class,*.o,*.d
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

"colorscheme desert256
set background=dark

" I never use gvim, but who knows?
set guioptions=aFi
set guicursor+=a:blinkon0 " disable cursor blinking
set guifont=Droid\ Sans\ Mono\ 9

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
nnoremap à 10k
nnoremap ç 10j

set listchars=nbsp:␣,tab:\|\ ,trail:␣,extends:>,precedes:<
set list

set winwidth=80
set winheight=6
set winminheight=6
set winheight=999

" fast escape out of insert mode
set ttimeoutlen=10

if has("autocmd")
    augroup Dispatch
        au!
        autocmd BufNewFile,BufRead *.md set filetype=markdown
        autocmd FileType go let b:dispatch = 'go build'
        au FileType scss let b:dispatch = 'sass --update %'
        au FileType ruby let b:dispatch = 'rake'
        au BufWritePost *.scss Dispatch!
    augroup END
    augroup Stuff
        au!
        autocmd BufNewFile,BufRead /home/codl/dnd/notes/* set sw=2 fdm=indent fml=1 fdl=0
        autocmd BufWritePost /home/codl{/dotfiles,}/.vimrc source /home/codl/.vimrc
        " jump to last position when opening a file
        autocmd BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g`\"" | endif
    augroup END
endif

nnoremap <leader>k :Dispatch<CR>
nnoremap <leader>K :Dispatch 

let g:ctrlp_map = ';;'
nnoremap ;, :CtrlPMRUFiles<CR>

let g:airline_powerline_fonts = 1
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#show_buffers = 0
