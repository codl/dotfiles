set encoding=utf-8
scriptencoding utf-8

call plug#begin('~/.local/share/nvim/plugged')

Plug 'farmergreg/vim-lastplace'
Plug 'tpope/vim-sleuth' " autodetects tab settings

Plug 'ctrlpvim/ctrlp.vim' " fuzzy finder
Plug 'tpope/vim-vinegar' " netrw make good

Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-rhubarb' " github support for :GBrowse

Plug 'godlygeek/tabular', { 'on': 'Tabularize' }
Plug 'mileszs/ack.vim', { 'on': 'Ack' }
Plug 'airblade/vim-gitgutter'
set updatetime=500 " updates gitgutters more often

Plug 'ap/vim-css-color'

Plug 'dag/vim-fish'

"Plug 'glacambre/firenvim', { 'do': { _ -> firenvim#install(0) } }

"Plug 'simnalamburt/vim-mundo'

"Plug 'jkramer/vim-checkbox'
"Plug 'w0rp/ale'
"Plug 'tpope/vim-obsession'
"Plug 'tpope/vim-dispatch'
"Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
"Plug 'zchee/deoplete-jedi'
"Plug 'mhinz/vim-signify'

call plug#end()

set nocompatible

set mouse=a

let mapleader = ","
let maplocalleader = ","

set linebreak " ⚠ only takes effect when list is disabled

" indentation crap
set shiftwidth=4 " indent 4 spaces
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

set colorcolumn=81 " hilight 81st column
set textwidth=0

set undofile " save undo steps to disk

if !exists('g:wildignore_was_set')
    set wildignore+=*.bak,*.pyc,*.class,*.o,*.d
    set wildignore+=*/venv/*,*/.git/*,*/node_modules/*,*/vendor/bundle/*
    let g:wildignore_was_set=1
endif

set pastetoggle=<F2> " press f2 in insert mode to disable paste-harmful features

set wildmenu " show a sexy menu when tab-completing

set scrolloff=2 " start scrolling 3 lines before window border

colorscheme default
set background=light

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

set listchars=nbsp:␣,tab:\|\ ,trail:␣,extends:»,precedes:«
set list

set winwidth=80    " soft limit for width of current window
set winminwidth=16 " hard limit for other windows

if has("autocmd")
    augroup Filetypes
        autocmd!
        autocmd BufNewFile,BufRead *.p8 set noexpandtab
        autocmd FileType python nnoremap <buffer> <Leader>k :%!pipx run black -
    augroup END
    augroup FixFugitive
        autocmd!
        autocmd QuickFixCmdPost *grep* cwindow
        " opens the quickfix window after :Ggrep
    augroup END
endif

let g:ctrlp_map = ';;'
nnoremap ;, :CtrlPMRUFiles<CR>
let g:ctrlp_show_hidden = 1
let g:ctrlp_max_files = 100000
" let g:ctrlp_user_command = ['.git', 'cd %s; git ls-files']
let g:ctrlp_root_markers = ['.stfolder']
let g:ctrlp_mruf_exclude = '/tmp/psql\.edit.*|/var/tmp/.*'

let g:ackprg = 'ag --vimgrep'
command! -nargs=* Ag Ack <args>

let g:deoplete#enable_at_startup = 1

" use tab key for navigating completions
inoremap <expr> <Tab> pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"

let g:netrw_sort_by = 'time'
let g:netrw_sort_direction = 'reverse'

" Alt-e returns to normal mode from a terminal
tnoremap <A-e> <C-\><C-n>
" ^W^W out of a terminal
tnoremap <C-w><C-w> <C-\><C-n><C-w><C-w>

function! TermReminder()
    if mode() == 't'
        return "<Alt-E> for Normal mode"
    else
        return ""
    endif
endfunction

augroup Terminal
    autocmd!
    autocmd TermOpen * setlocal statusline=%{b:term_title}%=%{TermReminder()}
augroup END


let g:ale_fixers = {
\   'python': ['black'],
\}

if exists('g:started_by_firenvim')
    let g:firenvim_config = {'localSettings': {'.*': {'takeover': 'never'}}}
    set laststatus=0
    let g:ctrlp_mruf_exclude = '.*'
endif

if exists('g:loaded_fugitive')
    function! GitStatus()
        let [a,m,r] = GitGutterGetHunkSummary()
        if a > 0 || m > 0 || r > 0
            return printf('+%d~%d-%d', a, m, r)
        else
            return ""
        endif
    endfunction

    set statusline=%<%q%f%(@%{FugitiveHead(7)}\%{GitStatus()}%)%h%m%r%=%y\ %-9.(%l,%c%V%)\ %P
endif

set diffopt+=vertical
