" ======================
" VIM CONFIGURATION FILE
" ----------------------

" ----------------------
" VUNDLE PLUGINS MANAGER
" ----------------------
set nocompatible              " be iMproved, required
filetype off                  " required

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
" alternatively, pass a path where Vundle should install plugins
"call vundle#begin('~/some/path/here')

" let Vundle manage Vundle, required
Plugin 'VundleVim/Vundle.vim'

" Keep Plugin commands between vundle#begin/end.
Plugin 'tpope/vim-fugitive' " git wrapper
Plugin 'tpope/vim-surround' " use commands to change surrounding of texts
Plugin 'godlygeek/tabular' " dependencies for vim-markdown plugin
Plugin 'preservim/nerdtree' " file explorer tree style
Plugin 'vim-airline/vim-airline' " status line at the bottom
Plugin 'ycm-core/YouCompleteMe' " autocomplete for VIM
Plugin 'mg979/vim-visual-multi' " multi cursor support
Plugin 'vim-python/python-syntax' " syntax highlight for python
Plugin 'vim-syntastic/syntastic' " check file for syntax errors
Plugin 'preservim/vim-markdown' " syntax highlight for markdown

" All of your Plugins must be added before the following line
call vundle#end()            " required
filetype plugin indent on    " required

" Brief help
" :PluginList       - lists configured plugins
" :PluginInstall    - installs plugins; append `!` to update or just :PluginUpdate
" :PluginSearch foo - searches for foo; append `!` to refresh local cache
" :PluginClean      - confirms removal of unused plugins; append `!` to auto-approve removal
"
" see :h vundle for more details or wiki for FAQ
" Put your non-Plugin stuff after this line

" ------------
" VIM SETTINGS
" ------------
set nu "enable line number
set cul "highlight current line
set incsearch "enable incremental search
set hlsearch "enable highlight search
set autoindent "auto indentation
set smartindent "smart indentation
set spell "highlight misspelled words
set spelllang=en,fr " set spelling
let g:python_highlight_all = 1 " enable all highlight for python plugin
let g:vim_markdown_folding_disabled = 1 " disable folding for markdown plugin
