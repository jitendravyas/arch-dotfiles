" Essential {{{
    set nocompatible            " Modernise
    filetype off                " Required by Vundle
    let mapleader=","           " Change mapleader
" }}}

" Runtime Paths {{{
    set runtimepath+=~/.vim/bundle/vundle/
    set runtimepath+=~/.vim/bundle/ctrlp.vim

    if has('gui_running')
        set runtimepath+=~/.vim/bundle/powerline/powerline/bindings/vim
    endif
" }}}

" Plugins {{{
    call vundle#rc()
    Bundle 'gmarik/vundle'
    Bundle 'tpope/vim-surround'
    Bundle 'tpope/vim-repeat'
    Bundle 'tpope/vim-unimpaired'
    Bundle 'tpope/vim-fugitive'
    Bundle 'tpope/vim-commentary'
    Bundle 'Lokaltog/vim-easymotion'
    Bundle 'scrooloose/nerdtree'
    Bundle 'scrooloose/nerdcommenter'
    Bundle 'vim-scripts/Colour-Sampler-Pack'
    Bundle 'mattn/zencoding-vim'
    Bundle 'evanmiller/nginx-vim-syntax'
    Bundle 'kien/ctrlp.vim'
    Bundle 'altercation/vim-colors-solarized'
    Bundle 'Matt-Stevens/Smyck-Color-Scheme'
    Bundle 'klen/python-mode'
    Bundle 'MarcWeber/vim-addon-mw-utils'
    Bundle 'tomtom/tlib_vim'
    Bundle 'garbas/vim-snipmate'
    Bundle 'honza/vim-snippets'

    if has('gui_running')
        Bundle 'Lokaltog/powerline'
    endif
" }}}

" General {{{
    syntax on                   " Syntax highlighting
    filetype plugin indent on   " Enable detection of filetype
    set wildmenu                " Menu completion in command mode on <Tab>
    set wildmode=full           " <Tab> cycles between all matching choices.
    set modeline                " Enable modelines
    set noswapfile              " No messy swap files
    set history=2000            " Remember more Ex-Commands

    " ignore
    set wildignore+=*.swp,*.bak,.svn,.git,*.jpg,*.gif,*.png,*.pyc
" }}}

" Appearance {{{
    set t_Co=256                " Enable full colour within the terminal
    colorscheme smyck           " Other options: molokai, solarized
    set background=dark         " We are using dark background in vim
    set guioptions-=T           " Remove shortcut icons
    set guioptions-=r           " Remove scrollbar
    set guioptions-=L           " Remove left scrollbar
    set guioptions-=m           " Remove top menu
    set showmode                " Indicate what mode we're in in the status bar
    set title                   " Show title in console title bar
    set cursorline              " Display a horizontal line at the cursor position
    set report=0                " Always print changed line count
    set shortmess+=a            " Use [+]/[RO]/[w] for modified/readonly/written
    set laststatus=2            " Always show statusline, even if only 1 window
    set colorcolumn=100         " Add a red line at 100 chars (not quite PEP 8, but it's 2013)
" }}}

" Searching {{{
    set hlsearch                " Highlight search matches
    set incsearch               " Incrementally search while typing a /regex
    set ignorecase              " Default to using case insensitive searches,
    set smartcase               " Unless uppercase letters are used in the regex
    set smarttab                " Handle tabs more intelligently
    set gdefault                " Assume the /g flag on :s substitutions
" }}}

" Moving {{{
    set relativenumber          " Relative line numbers
    set scrolloff=5             " Begin scrolling before cursor hits the top/bottom
    set sidescrolloff=20        " Begin scrolling before cursor hits the right hand side
" }}}

" Git Commit Editing {{{
    " Add a red line at 72 chars, keeping commit messages
    " short n' sweet. Also turn on spell checking
    autocmd Filetype gitcommit setlocal textwidth=72 colorcolumn=72 spell
" }}}

" Editing {{{
    set nowrap                  " Disable text wrapping
    set tabstop=4               " A tab is four spaces, not eight (the default)
    set expandtab               " Convert tabs to tabstop * spaces
    set shiftwidth=4            " How much to indent with '>>'
    set softtabstop=4           " Should be the same as 'tabstop'
    set confirm                 " Y-N-C prompt if closing with unsaved changes
    set showcmd                 " Show incomplete normal mode commands as I type
    set spelllang=en_gb         " Set region to British English
" }}}

" Folding  {{{
    set foldmethod=indent       " Allow us to fold on indents
    set foldlevelstart=20       " Don't fold by default

    " Automatically fold vim configuration files
    autocmd Syntax vim setlocal foldmethod=marker
    autocmd Syntax vim normal zM
" }}}

" Disable {{{
    " Only use the hjkl keys for movement
    map <Up>    <Nop>
    map <Down>  <Nop>
    map <Left>  <Nop>
    map <Right> <Nop>

    " The same applies to insert mode
    imap <Up>    <Nop>
    imap <Down>  <Nop>
    imap <Left>  <Nop>
    imap <Right> <Nop>

    " Use 'jk' or 'jj' instead of Escape
    inoremap <Esc> <Nop>

    " Never need undo in visual mode, always accidentally hitting it though
    vnoremap u <Nop>
" }}}

" No GUI {{{
    if ! has('gui_running')
        set statusline=[%l,%v\ %P%M]\ %f\ %r%h%w\ (%{&ff})\ %{fugitive#statusline()}
        colorscheme molokai
        let g:NERDTreeDirArrows=0

        " Move Powerline out of insert mode, fast
        augroup FastEscape
            autocmd!
            au InsertEnter * set ttimeoutlen=1
            au InsertLeave * set ttimeoutlen=-1
        augroup END
    endif
" }}}

" Remappings and Shortcuts {{{
    " Quickly get out of insert mode (either use 'jj' or 'jk')
    inoremap jj <Esc>
    inoremap jk <Esc>

    " Phat fingers yo'
    noremap ` <Esc>
    noremap <F1> <Esc>

    " Improve movement on wrapped lines
    nnoremap j gj
    nnoremap k gk

    " Quick yanking to the end of the line
    nnoremap Y y$

    " Toggle paste (pastetoggle doesn't redraw the screen)
    nnoremap <F2> :set paste!<CR>

    " F5 strips trailing whitespace
    nnoremap <silent> <F5> :call StripTrailingWhitespace()<CR>

    " Allow backspace over everything in insert mode
    set backspace=eol,start,indent

    " Ctrl+[jklm] to navigate splits
    map <C-j> <C-w>j
    map <C-k> <C-w>k
    map <C-l> <C-w>l
    map <C-h> <C-w>h

    " Clear the search buffer when ./ is pressed
    nmap <silent> ,/ :nohlsearch<CR>

    " Ctrlp fuzzy file and buffer search
    map <C-p> <Esc>:ctrlp<CR>
    map <C-o> <Esc>:ctrlpbuffer<CR>

    " Reselect visual block after indent/outdent
    vnoremap < <gv
    vnoremap > >gv

    " Sort (alphabetical, not numerical)
    vnoremap <Leader>s :!sort<CR>

    " Turn off Vim's default regular expression handling and use Perl's
    nnoremap / /\v
    vnoremap / /\v

    " Paste from the Linux clipboard
    map <C-Q> "+gP

    " Safe aliases the capital Q and W
    cnoreabbrev <expr> Q ((getcmdtype() is# ':' && getcmdline() is# 'Q')?('q'):('Q'))
    cnoreabbrev <expr> W ((getcmdtype() is# ':' && getcmdline() is# 'W')?('w'):('W'))

    " Keep search matches in the middle of the window
    nnoremap n nzzzv
    nnoremap N Nzzzv

   " Space to toggle folds
    nnoremap <Space> za
    vnoremap <Space> za

    " Easy filetype switching
    nnoremap _md :set ft=markdown<CR>
    nnoremap _hd :set ft=htmldjango<CR>
    nnoremap _js :set ft=javascript<CR>
    nnoremap _pd :set ft=python.django<CR>
    nnoremap _d  :set ft=diff<CR>

    " Select current line excluding indentation
    nnoremap vv ^vg_

    " Backwards and forwards through command and search history
    cnoremap <C-p> <Up>
    cnoremap <C-n> <Down>

    " Toggle spell checking on and off
    nnoremap <silent> <F4> :set spell!<CR>
" }}}

" Behaviour {{{
    set noerrorbells            " Shut those bells up
    set novisualbell            " The same goes for visual bells
" }}}

" NERD Tree {{{
    " Change to the directory of the file being opened
    autocmd BufEnter ?* silent! lcd %:p:h

    " Ignore Python binaries
    let NERDTreeIgnore = ['\.pyc$']

    " Close Vim if NERD Tree is the only window open
    autocmd WinEnter * call s:CloseIfOnlyNerdTreeLeft()

    " Start NERD Tree on startup
    autocmd VimEnter * NERDTree

    " Enter the right window on startup
    autocmd VimEnter * wincmd p

    function! s:CloseIfOnlyNerdTreeLeft()
        if tabpagenr('$') == 1 && winnr('$') == 1
            q
        endif
    endfunction
" }}}

" Trailing Whitespace {{{
    " Run this when saving files with these extensions
    autocmd BufWritePre *.py,*.js,*.css,*.scss,*.sass :call StripTrailingWhitespace()

    " Highlight trailing whitespace
    highlight ExtraWhitespace ctermbg=red guibg=red
    match ExtraWhitespace /\s\+$/
    autocmd BufWinEnter ?* match ExtraWhitespace /\s\+$/
    autocmd InsertEnter ?* match ExtraWhitespace /\s\+\%#\@<!$/
    autocmd InsertLeave ?* match ExtraWhitespace /\s\+$/
    autocmd BufWinLeave ?* call clearmatches()

    " Remove trailing whitespace
    function! StripTrailingWhitespace()
        let _s=@/
        let l = line(".")
        let c = col(".")
        %s/\s\+$//e
        let @/=_s
        call cursor(l, c)
    endfunction
" }}}

" Cursorline {{{
    " Only show the cursor line within the active window
    augroup CursorLine
        autocmd!
        autocmd WinLeave * set nocursorline
        autocmd VimEnter,WinEnter * set cursorline
    augroup END
" }}}

" Remember Information {{{
    " Remember previous folds (the conditional is necessary due to a bug in Vundle)
    au BufWinLeave ?* if &modifiable | silent mkview | endif
    au BufWinEnter ?* if &modifiable | silent loadview | endif

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
      autocmd BufWinEnter ?* call ResCur()
    augroup END
" }}}
