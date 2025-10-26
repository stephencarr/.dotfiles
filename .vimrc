" Enable true color support (24-bit)
if has('termguicolors')
  set termguicolors
endif
set relativenumber                          " Show line numbers relative to each other
set number                                  " Show the current lines number w/ relative numbers around it
set ruler                                   " Show ruler
set listchars=trail:.,tab:>-,eol:¬          " Change the invisible characters
set noswapfile                              " Don't create annoying *.swp files
set scrolloff=5                             " Start scrolling the file 5 lines before the end of the window
set spelllang=en_us                         " Set default spelling language to English
set hidden                                  " Allow hiding buffers with unsaved changes
set wildmenu                                " Make tab completion act more like bash
set wildmode=list:longest                   " Tab complete to longest common string, like bash
set showcmd                                 " Display an incomplete command in the lower right corner
set showmode                                " Show current mode down the bottom
set laststatus=2                            " Always show the status line
set history=10000
set autoread
set noerrorbells visualbell t_vb=           " No more error bells
set iskeyword+=\-                           " Auto complete words with dashes

autocmd FileType gitcommit set spell        " Turn on spell check in Git commits

" Treat dashed words as whole words in stylesheets
autocmd Filetype css,scss,sass setlocal iskeyword+=-

" Searching
set hlsearch                                " Highlight searches
set incsearch                               " Highlight search results instantly
set ignorecase                              " Ignore case
set smartcase                               " Override 'ignorecase' option if the search contains upper case characters.

" Indentation
set shiftwidth=2                            " Number of spaces to use in each autoindent step
set tabstop=2                               " Two tab spaces
set softtabstop=2                           " Number of spaces to skip or insert when <BS>ing or <Tab>ing
set expandtab                               " Spaces instead of tabs for better cross-editor compatibility
set autoindent                              " Keep the indent when creating a new line
set smarttab                                " Use shiftwidth and softtabstop to insert or delete (on <BS>) blanks
set cindent                                 " Recommended seting for automatic C-style indentation

" Color column at 110 characters
set colorcolumn=110
set textwidth=110

" Undo
if !isdirectory(expand("~/.vim/.undo/"))
  silent !mkdir -p ~/.vim/.undo/
endif
set undodir=$HOME/.vim/.undo
set undofile
set undolevels=1000
set undoreload=10000

" Colorscheme - try gruvbox first, fall back to others
syntax enable
set background=dark

" Try modern colorschemes, fall back gracefully
if !exists('g:colors_name')
  try
    colorscheme gruvbox
  catch
    try
      colorscheme onedark
    catch
      try
        colorscheme solarized
      catch
        " Use default if nothing else available
      endtry
    endtry
  endtry
endif

" Set wildcard ignore for file searches
set wildignore+=*/tmp/*,vendor/bundle/*,*/build/*,*/Resources/*,*.so,*.swp,*.zip,*.png,*.jpg,*.jpeg,*.gif,.gitkeep
set wildignore+=*/node_modules/*,*/.git/*,*/dist/*,*/target/*,*.pyc,*/__pycache__/*

" Plugins
call plug#begin('~/.vim/plugged')

" Essential Tim Pope plugins
Plug 'tpope/vim-sensible'
Plug 'tpope/vim-fugitive'           " Git integration
Plug 'tpope/vim-surround'           " Surround text objects
Plug 'tpope/vim-commentary'         " Comment stuff out
Plug 'tpope/vim-repeat'             " Repeat plugin maps

" File navigation - fzf is the modern standard
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'

" UI improvements
Plug 'itchyny/lightline.vim'        " Lightweight status line
Plug 'airblade/vim-gitgutter'       " Git diff in gutter

" Language support
Plug 'sheerun/vim-polyglot'         " Language pack (better than individual plugins)
Plug 'jiangmiao/auto-pairs'         " Auto close brackets

" Color schemes
Plug 'morhetz/gruvbox'              " Popular modern colorscheme
Plug 'joshdick/onedark.vim'         " Atom's One Dark theme
Plug 'altercation/vim-colors-solarized'  " Keep solarized as option

call plug#end()

" FZF keybindings
nnoremap <C-p> :Files<CR>
nnoremap <C-b> :Buffers<CR>
nnoremap <C-f> :Rg<CR>
nnoremap <leader>c :Commands<CR>

" Lightline configuration
let g:lightline = {
      \ 'active': {
      \   'left': [ [ 'mode', 'paste' ],
      \             [ 'gitbranch', 'readonly', 'filename', 'modified' ] ]
      \ },
      \ 'component_function': {
      \   'gitbranch': 'FugitiveHead'
      \ },
      \ }

" Hide default mode indicator (lightline shows it)
set noshowmode
