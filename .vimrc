" Essential {{{
    set nocompatible            " Modernise
    filetype off                " Required by Vundle
    let mapleader=","           " Change mapleader
" }}}

" Runtime Paths {{{
    set runtimepath+=~/.vim/bundle/vundle/
    set runtimepath+=~/.vim/bundle/ctrlp.vim
    set runtimepath+=~/.vim/bundle/powerline/powerline/bindings/vim
" }}}

" Plugins {{{
    call vundle#rc()
    Bundle 'gmarik/vundle'
    Bundle 'tpope/vim-surround'
    Bundle 'tpope/vim-repeat'
    Bundle 'tpope/vim-unimpaired'
    Bundle 'tpope/vim-fugitive'
    Bundle 'Lokaltog/vim-easymotion'
    Bundle 'Lokaltog/powerline'
    Bundle 'scrooloose/nerdtree'
    Bundle 'scrooloose/nerdcommenter'
    Bundle 'Color-Sampler-Pack'
    Bundle 'mattn/zencoding-vim'
    Bundle 'evanmiller/nginx-vim-syntax'
    Bundle 'kien/ctrlp.vim'
    Bundle 'altercation/vim-colors-solarized'
" }}}

" General {{{
    syntax on                   " syntax highlighing
    filetype plugin indent on   " enable detection of filetype
    set wildmenu                " Menu completion in command mode on <Tab>
    set wildmode=full           " <Tab> cycles between all matching choices.
    set modeline                " enable modelines

    " ignore
    set wildignore+=*.swp,*.bak,.svn,.git,*.jpg,*.gif,*.png,*.pyc
" }}}

" Appearance {{{
    set t_Co=256                " enable full colour within the terminal
    colorscheme smyck           " other options: molokai, solarized
    set background=dark         " We are using dark background in vim
    set guioptions-=T           " remove shortcut icons
    set guioptions-=r           " remove scrollbar
    set guioptions-=L           " remove left scrollbar
    set guioptions-=m           " remove top menu
    set showmode                " indicate what mode we're in in the status bar
    set title                   " show title in console title bar
    set cursorline              " display a horizontal line at the cursor position
    set report=0                " Always print changed line count
    set shortmess+=a            " Use [+]/[RO]/[w] for modified/readonly/written
    set laststatus=2            " Always show statusline, even if only 1 window
    set colorcolumn=100         " Add a red line at 100 chars (not quite PEP 8, but it's 2013)
" }}}

" Searching {{{
    set hlsearch                " highlight search matches
    set incsearch               " Incrementally search while typing a /regex
    set ignorecase              " Default to using case insensitive searches,
    set smartcase               " unless uppercase letters are used in the regex
    set smarttab                " Handle tabs more intelligently
    set gdefault                " assume the /g flag on :s substitutions
" }}}

" Moving {{{
    set relativenumber          " relative line numbers
    set scrolloff=5             " beging scrolling before cursor hits the top/bottom
" }}}

" Editing {{{
    set nowrap                  " disable text wrapping
    set tabstop=4               " a tab is four spaces, not eight (the default)
    set expandtab               " convert tabs to tabstop * spaces
    set shiftwidth=4            " how much to indent with '>>'
    set softtabstop=4           " should be the same as 'tabstop'
    set confirm                 " Y-N-C prompt if closing with unsaved changes
    set showcmd                 " Show incomplete normal mode commands as I type
" }}}

" Folding  {{{
    set foldmethod=indent       " allow us to fold on indents
    set foldlevelstart=20       " don't fold by default

    " Automatically fold vim configuration files
    autocmd Syntax vim setlocal foldmethod=marker
    autocmd Syntax vim normal zM
" }}}

" Disable {{{
    " Only use the hjkl keys for movement
    map <up> <nop>
    map <down> <nop>
    map <left> <nop>
    map <right> <nop>

    " Use 'jk' or 'jj' instead of Escape
    inoremap <esc> <nop>
" }}}

" No GUI {{{
    if ! has('gui_running')
        set statusline=[%l,%v\ %P%M]\ %f\ %r%h%w\ (%{&ff})\ %{fugitive#statusline()}

        augroup FastEscape
            autocmd!
            au InsertEnter * set ttimeoutlen=1
            au InsertLeave * set ttimeoutlen=-1
        augroup END
    endif
" }}}

" Remappings and Shortcuts {{{
    " Quickly get out of insert mode with no cursor movement (either use 'jj' or 'jk')
    inoremap jj <Esc>`^
    inoremap jk <Esc>`^

    " Improve movement on wrapped lines
    nnoremap j gj
    nnoremap k gk

    " Quick yanking to the end of the line
    nnoremap Y y$

    " Toggle paste
    set pastetoggle=<F2>

    " F5 strips trailing whitespace
    nnoremap <silent> <F5> :call <SID>StripTrailingWhitespaces()<CR>

    " Allow backspace over everything in insert mode
    set backspace=eol,start,indent

    " Ctrl+[jklm] to navigate splits
    map <c-j> <c-w>j
    map <c-k> <c-w>k
    map <c-l> <c-w>l
    map <c-h> <c-w>h

    " Clear the search buffer when ./ is pressed
    nmap <silent> ,/ :nohlsearch<CR>

    " Swapover mark jumping keys
    nnoremap ' `
    nnoremap ` '

    " CtrlP fuzzy file and buffer search
    map <c-p> <ESC>:CtrlP<CR>
    map <c-o> <ESC>:CtrlPBuffer<CR>

    " Reselect visual block after indent/outdent
    vnoremap < <gv
    vnoremap > >gv

    " Turn off Vim's default regular expression handling and use Perl's
    nnoremap / /\v
    vnoremap / /\v
" }}}

" Behaviour {{{
    set noerrorbells            " shut those bells up
    set novb                    " the same goes for visual bells
" }}}

" NERD Tree {{{
    " close Vim if NERD Tree is the only window open
    autocmd WinEnter * call s:CloseIfOnlyNerdTreeLeft()

    " start NERD Tree on startup
    autocmd vimenter * NERDTree

    " enter the right window on startup
    autocmd vimenter * wincmd p

    let NERDTreeIgnore = ['\.pyc$']
    function! s:CloseIfOnlyNerdTreeLeft()
      if exists("t:NERDTreeBufName")
        if bufwinnr(t:NERDTreeBufName) != -1
          if winnr("$") == 1
            q
          endif
        endif
      endif
    endfunction
" }}}

" Trailing Whitespace {{{
    " Run this when saving files with these extensions
    autocmd BufWritePre *.py,*.js,*.css,*.scss,*.sass :call <SID>StripTrailingWhitespaces()

    " Highlight trailing whitespace
    highlight ExtraWhitespace ctermbg=red guibg=red
    match ExtraWhitespace /\s\+$/
    autocmd BufWinEnter * match ExtraWhitespace /\s\+$/
    autocmd InsertEnter * match ExtraWhitespace /\s\+\%#\@<!$/
    autocmd InsertLeave * match ExtraWhitespace /\s\+$/
    autocmd BufWinLeave * call clearmatches()

    " Remove trailing whitespace
    function! <SID>StripTrailingWhitespaces()
        let _s=@/
        let l = line(".")
        let c = col(".")
        %s/\s\+$//e
        let @/=_s
        call cursor(l, c)
    endfunction
" }}}

" Cursor Position {{{
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
" }}}
