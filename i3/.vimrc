set number          " Linenumbers
set relativenumber  " Relative linenumbers 
syntax enable       " Syntax highlighting
set tabstop=4       " Number of visual spaces per tab
set softtabstop=4   " Number of spaces created when editing in a tab
"set expandtab       " Tabs are spaces
set showcmd         " Commandline in bottom right
" set cursorline      " Line where cursor is located
set wildmenu        " Visual autocomplete for command menu
set showmatch       " Hightlight matching { } 
set incsearch       " Incremental search, searches as characters are entered
set hlsearch        " Highlights matches in search
set clipboard=unnamedplus " Sets the clipboard to system clipboard
set smartindent     " 
set shiftwidth=4    "
colorscheme gruvbox "
set background=dark "

" Get vim-plug
if empty(glob('~/.vim/autoload/plug.vim'))
	silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
	      \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
	autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

" vim-plug plugins
call plug#begin('~/.vim/plugged')
Plug 'tpope/vim-sensible'
Plug 'junegunn/goyo.vim'
Plug 'junegunn/limelight.vim'
Plug 'junegunn/seoul256.vim'
call plug#end()

" Goyo and Limelight integration
autocmd! User GoyoEnter Limelight
autocmd! User GoyoLeave Limelight!

" Limelight grey
let g:limelight_conceal_ctermfg = 243

