"───────────────────────────────────────────────────────────────────────────────
" Vim
set nocompatible            " Modernise
filetype off                " Required by Vundle
let mapleader=","           " Change mapleader
set ttyfast                 " Optimize for fast terminal connections
"───────────────────────────────────────────────────────────────────────────────


"───────────────────────────────────────────────────────────────────────────────
" Start Vundle (with a list of Vim plugins)
set rtp+=~/.vim/bundle/vundle/
call vundle#rc()

Bundle 'gmarik/vundle'
Bundle 'tpope/vim-surround'
Bundle 'Lokaltog/vim-easymotion'
Bundle 'scrooloose/nerdtree'
Bundle 'scrooloose/nerdcommenter'
Bundle 'tpope/vim-fugitive'
Bundle 'Color-Sampler-Pack'
Bundle 'mattn/zencoding-vim'
Bundle 'nvie/vim-flake8'
Bundle 'evanmiller/nginx-vim-syntax'
"───────────────────────────────────────────────────────────────────────────────


"───────────────────────────────────────────────────────────────────────────────
" Basic configuration
syntax on                   " syntax highlighing
filetype plugin on          " enable detection of filetype
colorscheme fnaqevan        " others: wombat, desert, evening and peaksea
set encoding=utf-8          " default to UTF-8 encoding
set numberwidth=1           " using only 1 column (and 1 space) while possible
set background=dark         " We are using dark background in vim
set title                   " show title in console title bar
set wildmenu                " Menu completion in command mode on <Tab>
set wildmode=full           " <Tab> cycles between all matching choices.
set nowrap                  " disable text wrapping
set cursorline              " display a horizontal line at the cursor position
set tabstop=4               " a tab is four spaces, not eight (the default)
set expandtab               " convert tabs to tabstop * spaces
set shiftwidth=4            " how much to indent with '>>'
set softtabstop=4           " should be the same as 'tabstop'
set scrolloff=3             " beging scrolling before cursor hits the top/bottom
set hlsearch                " highlight search matches
set incsearch               " Incrementally search while typing a /regex
set showmode                " indicate what mode we're in in the status bar
set foldmethod=indent       " allow us to fold on indents
set foldlevel=99            " don't fold by default
set relativenumber          " relative line numbers
set modeline                " enable modelines

" Add Git status to statusline
set statusline=[%l,%v\ %P%M]\ %f\ %r%h%w\ (%{&ff})\ %{fugitive#statusline()}
"───────────────────────────────────────────────────────────────────────────────


"───────────────────────────────────────────────────────────────────────────────
" Keyboard

" Only use the hjkl keys for movement
map <up> <nop>
map <down> <nop>
map <left> <nop>
map <right> <nop>

" Quickly get out of insert mode with no cursor movement (either use 'jj' or 'jk')
inoremap jj <Esc>`^
inoremap jk <Esc>`^

" Improve movement on wrapped lines
nnoremap j gj
nnoremap k gk

" Clear the search buffer when ./ is pressed
nmap <silent> ,/ :nohlsearch<CR>

" F5 strips trailing whitespace
nnoremap <silent> <F5> :call <SID>StripTrailingWhitespaces()<CR>

" Ctrl+[jklm] to navigate splits
map <c-j> <c-w>j
map <c-k> <c-w>k
map <c-l> <c-w>l
map <c-h> <c-w>h

" Swapover mark jumping keys
nnoremap ' `
nnoremap ` '

" Turn off Vim's default regular expression handling and use Perl's
nnoremap / /\v
vnoremap / /\v

" I never mean to hit F1 intentionally, I always mean to hit Esc
inoremap <F1> <ESC>
nnoremap <F1> <ESC>
vnoremap <F1> <ESC>

" Go to command mode with one less keystroke
nnoremap ; :
"───────────────────────────────────────────────────────────────────────────────


"───────────────────────────────────────────────────────────────────────────────
" Reading and Writing
set ruler                   " Show some info, even without statuslines
set noautowrite             " Never write a file unless I request it,
set noautowriteall          " never
set noautoread              " Don't automatically re-read changed files
set confirm                 " Y-N-C prompt if closing with unsaved changes
set showcmd                 " Show incomplete normal mode commands as I type
set report=0                " : commands always print changed line count
set shortmess+=a            " Use [+]/[RO]/[w] for modified/readonly/written
set laststatus=2            " Always show statusline, even if only 1 window
set autoindent              " Continue the same level of indentation for newline
set colorcolumn=100         " Add a red line at 100 chars (not quite PEP 8)
"───────────────────────────────────────────────────────────────────────────────


"───────────────────────────────────────────────────────────────────────────────
" Searching and Patterns
set ignorecase              " Default to using case insensitive searches,
set smartcase               " unless uppercase letters are used in the regex
set smarttab                " Handle tabs more intelligently
set gdefault                " assume the /g flag on :s substitutions
"───────────────────────────────────────────────────────────────────────────────


"───────────────────────────────────────────────────────────────────────────────
" Shut those bells up
set noerrorbells
set vb t_vb=
"───────────────────────────────────────────────────────────────────────────────


"───────────────────────────────────────────────────────────────────────────────
" Python
let g:flake8_max_line_length=100
"───────────────────────────────────────────────────────────────────────────────


"───────────────────────────────────────────────────────────────────────────────
" NERD Tree
function! s:CloseIfOnlyNerdTreeLeft()
  if exists("t:NERDTreeBufName")
    if bufwinnr(t:NERDTreeBufName) != -1
      if winnr("$") == 1
        q
      endif
    endif
  endif
endfunction
autocmd WinEnter * call s:CloseIfOnlyNerdTreeLeft()
autocmd vimenter * NERDTree
autocmd vimenter * wincmd p

let NERDTreeIgnore = ['\.pyc$']
"───────────────────────────────────────────────────────────────────────────────


"───────────────────────────────────────────────────────────────────────────────
" highlight trailing whitespace
highlight ExtraWhitespace ctermbg=red guibg=red
match ExtraWhitespace /\s\+$/
autocmd BufWinEnter * match ExtraWhitespace /\s\+$/
autocmd InsertEnter * match ExtraWhitespace /\s\+\%#\@<!$/
autocmd InsertLeave * match ExtraWhitespace /\s\+$/
autocmd BufWinLeave * call clearmatches()
"───────────────────────────────────────────────────────────────────────────────


"───────────────────────────────────────────────────────────────────────────────
" Remove trailing whitespace
function! <SID>StripTrailingWhitespaces()
    let _s=@/
    let l = line(".")
    let c = col(".")
    %s/\s\+$//e
    let @/=_s
    call cursor(l, c)
endfunction

" Run this when saving .py and .js files
autocmd BufWritePre *.py,*.js :call <SID>StripTrailingWhitespaces()
"───────────────────────────────────────────────────────────────────────────────


"───────────────────────────────────────────────────────────────────────────────
" Remember cursor position
set viminfo='10,\"100,:20,%,n~/.viminfo

function! ResCur()
  if line("'\"") <= line("$")
    normal! g`"
    return 1
  endif
endfunction

augroup resCur
  autocmd!
  autocmd BufWinEnter * call ResCur()
augroup END
"───────────────────────────────────────────────────────────────────────────────
