" vimconf is not vi-compatible
set nocompatible
""" vundle Plugin Manager
    """ Initiallize vundle
        filetype off
        set rtp+=~/.vim/bundle/vundle/
        call vundle#rc()
    """ new functionality repos, uncomment to disable a plugin
        " recursive vundle update
        Bundle 'gmarik/vundle'

        " much much nicer status line
        Bundle 'bling/vim-airline'

        " show git tree in airline
        Bundle 'tpope/vim-fugitive'

        " powerfull comment engine
        Bundle 'vim-scripts/tComment'

        " automatic closing of parenthesis,brackets
        Bundle 'Raimondi/delimitMate'

        " zen mode
        Bundle 'mikewest/vimroom'

        " easy table generation and text line ups
        Bundle 'godlygeek/tabular'

        " make a tasklist from FIXME, TODO comments
        Bundle 'tasklist.vim'

        " show indendation level
        Bundle 'Yggdroot/indentLine'

        " python IDE support
        Bundle 'klen/python-mode'

        " Snippets like textmate
        " REQUIREMENTS: vim-addon-mw-utils, tlib_vim, vim-snippets
        Bundle 'MarcWeber/vim-addon-mw-utils'
        Bundle 'tomtom/tlib_vim'
        Bundle 'garbas/vim-snipmate'

        " Ledger bindings for vim
        Bundle 'ledger/vim-ledger'

        " nice stuff for csv files
        Bundle 'chrisbra/csv.vim'

        " better access to buffers
        Bundle 'jlanzarotta/bufexplorer'

        " per project settings
        Bundle 'Ralt/psettings'

        " pandoc syntax plus sugar
        Bundle 'vim-pandoc/vim-pandoc'

        " american abbreviations
        Bundle 'tpope/vim-abolish'
        Bundle 'nelstrom/vim-americanize'

        " trailing whitespace function
        Bundle 'bronson/vim-trailing-whitespace'
    """ Syntax files
        Bundle 'rainux/vim-vala'
        Bundle 'vim-scripts/gnuplot.vim'
        Bundle 'smancill/conky-syntax.vim'
        Bundle 'tejr/vim-tmux'
        Bundle 'vim-scripts/scons.vim'
    """ Colorschemes
        Bundle 'mayansmoke'
        Bundle 'nanotech/jellybeans.vim'
        Bundle 'gregsexton/Atom'
        Bundle 'bwyrosdick/vim-blackboard'
        Bundle 'altercation/vim-colors-solarized'
""" User interface
    """ Syntax highlighting
        filetype plugin indent on                   " detect file plugin+indent
        syntax on                                   " syntax highlighting
        set t_Co=16                                " 256-colors
        " set term=xterm-256-color
        au BufRead, BufNewFile *.txt set ft=sh      " opens .txt with highlighting
        """ Solarized Color scheme
            set background=light                          " light background
            colors solarized
        """ Jellybeans color scheme
            " set background=dark                         " dark background
            " colors jellybeans                           " select colorscheme
            " highlight Normal ctermbg=NONE               " use terminal bg
            " highlight nonText ctermbg=NONE              " use terminal bg
    """ Interface general
        set number                                  " line numbers
        set scrolloff=4                             " lines above/below cursor
        set showcmd                                 " show cmds being typed
        set title                                   " window title
        set vb t_vb=                                " disable visual bell
        set wildignore=.bak,.pyc,.o,.ojb,.,a,       " ignore said files
                   \.pdf,.jpg,.gif,.png,
                   \.avi,.mkv,.so
        set wildmenu                                " better auto complete
        set wildmode=longest,list                   " bash like autocompletion
        "show marker after 80 chars and another after 120
        let &colorcolumn="80,".join(range(120,999),",")
    """ Gvim
        set guifont=Inconsolata\ for\ Powerline\ Medium\ 10
        set guioptions-=m                       " remove menubar
        " set guioptions-=T                       " remove toolbar
        set guioptions-=r                       " remove right scrollbar"
""" General Settings
    set hidden                                      " buffer change, more undo
    set history=1000                                " default 20
    set laststatus=2                                " always show statusline
    set linebreak                                   " don't cut words oz wrap
    set list                                        " displaying listchars
    set listchars=tab:>.,trail:.,extends:#,nbsp:.   " > to highlight <tab>
    set noshowmode                                  " hide mode, got powerline
    set nostartofline                               " keep cursor column pos
    set wrap                                        " wrap lines
    set shortmess+=I                                " disable startup message
    set splitbelow                                  " splits go below w/focus
    set splitright                                  " vsplits go right w/focus
    set mouse=a                                     " use mouse in all modes
    """ Folding
        set foldcolumn=0                            " hide folding column
        set foldmethod=indent                       " folds using indent
        set foldnestmax=10                          " max 10 nested folds
        """ adopt foldlevel to file loaded, see http://superuser.com/questions/567352/how-can-i-set-foldlevelstart-in-vim-to-just-fold-nothing-initially-still-allow
        autocmd BufWinEnter * let &foldlevel = max(map(range(1, line('$')), 'foldlevel(v:val)'))
    """ Search and replace
        set incsearch                               " "live"-search
        set hlsearch                                " highlight search
        set showmatch                               " tmpjump to match-bracket
        set ignorecase                              " by default ignore case
    """ Return to last edit position when opening files
        augroup opening
            autocmd!
            autocmd BufReadPost *
                \ if line("'\"") > 0 && line("'\"") <= line("$") |
                \     exe "normal! g`\"" |
                \ endif
        augroup END
""" Files
    set encoding=utf8                               " Have utf8 encoding
    set autochdir                                   " always use curr. dir.
    set updatecount=50                              " update swp after 50chars
    set nobackup
    set nowritebackup
    """ Persistent undo. Requires Vim 7.3
        if has('persistent_undo') && exists("&undodir")
            set undodir=$HOME/.vim/undo/            " where to store undofiles
            set undofile                            " enable undofile
            set undolevels=500                      " max undos stored
            set undoreload=10000                    " buffer stored undos
        endif
    """ add filetype detection for some filetypes
    augroup filetypes
        autocmd!
        au BufNewFile,BufRead *.ldg,*.ledger setf ledger | comp ledger
        au BufNewFile,BufRead *.plt,*.plot setf gnuplot
        au BufNewFile,BufRead *.md setf markdown
        au BufNewFile,BufRead *.rst set shiftwidth=3
        " mccabe and flake8 don't work with cython files
        au BufNewFile,BufRead *.tex call SetLatexOptions()
        au BufNewFile,BufRead COMMIT_EDITMSG setlocal spell
    augroup END
    let g:tex_conceal=''                            " fix make vim-indent and latex live in peace
""" Functions
    function SetLatexOptions()
        set filetype=tex
        set foldmethod=marker
        set spell
        syntax spell toplevel                       " this is needed for spellchecking to for on the whole file
    endfunction
""" Text formatting
    set autoindent                                  " preserve indentation
    set backspace=indent,eol,start                  " smart backspace
    set cinkeys-=0#                                 " don't force # indentation
    set expandtab                                   " no real tabs
    set shiftround                                  " be clever with tabs
    set shiftwidth=4                                " default 8
    set smartcase                                   " sensitive with uppercase
    set smarttab                                    " tab to 0,4,8 etc.
    set softtabstop=4                               " "tab" feels like <tab>
    set tabstop=4                                   " replace <TAB> w/4 spaces
""" plugins
    """ python-mode
        let g:pymode = 1                            " enable everything
        let g:pymode_trim_whitespaces = 1
        let g:pymode_folding = 0                    " use global folding setting
        let g:pymode_doc = 0
        let g:pymode_doc_bind = '<leader>d'         " bind normal mode for docs
        nnoremap <leader>pep :PymodeLintAuto<CR>
        let g:pymode_lint_on_write = 1              " lint check on every save
        " for cython files only check pep8
        au BufNewFile,BufRead *.pxd,*.pyx let g:pymode_lint_checkers = ['pep8']
        let g:pymode_syntax_all = 1
        let g:pymode_syntax_print_as_function = 1
    """ VimRoom
        let g:vimroom_width=120
        let g:vimroom_clear_line_numbers=0
    """ airline options
        let g:airline_powerline_fonts = 1       " needs powerline patched fonts
        let g:airline_theme = 'solarized'
        let g:airline_mode_map = {
            \ '__' : '-',
            \ 'n'  : 'N',
            \ 'i'  : 'I',
            \ 'R'  : 'R',
            \ 'c'  : 'C',
            \ 'v'  : 'V',
            \ 'V'  : 'V',
            \ '' : 'V',
            \ 's'  : 'S',
            \ 'S'  : 'S',
            \ '' : 'S',
            \ }
""" Keybindings
    """ General
        " Yank{copy) to system clipboard
        noremap <leader>y "+y
        " Treat wrapped lines as normal lines
        nnoremap j gj
        nnoremap k gk
        " easy shfiting of lines
        nnoremap - ddp
        nnoremap _ ddkP
        " disable ex-mode for good
        nnoremap Q <nop>
        " map noh to <leader>l
        nnoremap <leader>l :nohlsearch<CR>
        " make Y consistend with D and C
        nnoremap Y y$
        " easy window navigation
        noremap <C-h> <C-w>h
        noremap <C-j> <C-w>j
        noremap <C-k> <C-w>k
        noremap <C-l> <C-w>l
        " close buffer for good
        noremap Q :bd<cr>
        " open vimrc in vsplit window
        nnoremap <leader>ev :vsplit $MYVIMRC<cr>
        " source vimrc
        nnoremap <leader>sv :source $MYVIMRC<cr>
        " better jumps to line start and end
        nnoremap H 0
        nnoremap L $
        " close buffers :b
        " remove trailing whitespaces
        nnoremap <leader>dw :FixWhitespace<cr>
        " use <leader>rp to reformat a paragraph
        nnoremap <leader>rp gqap
        vnoremap <leader>rp gp
        " save file with CTRL-S only if there are changes
        nnoremap <C-s> :update<cr>
        inoremap <C-s> <esc>:update<cr>a
        " visual mode pressing * or # searches for current selection
        vnoremap <silent> * :call VisualSelection('f')<CR>
        vnoremap <silent> # :call VisualSelection('b')<CR>
        nnoremap <F5> :update<cr>:make<cr>
        " short cut to paragraph reformating
        nnoremap <leader>p vipgq$
        vnoremap <leader>p ipgq$v
        " tasklist buttons
        nnoremap T :Tasklist<CR>
        " Insert a table headers separator line below the current line,
        " -- adjusted to the current line as headers line
        nnoremap <F4>t yyp:s/\v\S.{-}\ze(\s{2}\S\|$)/\=substitute(submatch(0),'.','-','g')/g<CR>
    """ Learn vim scripting the Hard way examples
        " put single quotes around visual marked text and exit to normal-mode
        vnoremap <leader>' <esc>`<i'<esc>`>a'<esc>
        " deavtivate arrow key in normal mode
        nnoremap <up> <nop>
        nnoremap <down> <nop>
        nnoremap <left> <nop>
        nnoremap <right> <nop>
        inoremap <up> <nop>
        inoremap <down> <nop>
        inoremap <left> <nop>
        inoremap <right> <nop>
