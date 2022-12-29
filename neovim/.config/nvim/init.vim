set cmdheight=0
set laststatus=2
set noshowmode
set number relativenumber
set ruler
set showmatch
set smartcase
set undolevels=1000
set tabstop=4
set shiftwidth=4
set splitbelow
set splitright
set mouse=a
set mouse=v
set cursorline
set autoindent
set expandtab
set termguicolors

" Vim-plug
call plug#begin()
Plug 'itchyny/lightline.vim'
Plug 'ap/vim-css-color'
Plug 'ayu-theme/ayu-vim'
Plug 'ggandor/leap.nvim'
"Plug 'vimwiki/vimwiki'
call plug#end()

filetype indent on
filetype plugin indent on
syntax on

" Colorscheme config
let ayucolor = "dark"
colorscheme ayu

" Lightline config
let g:lightline = {
      \ 'colorscheme': 'ayu_dark',
      \ 'active': {
      \   'left': [ [ 'mode', 'paste' ],
      \             [ 'readonly', 'filename', 'modified' ] ],
      \   'right': [ [ 'lineinfo' ],
      \              [ 'percent' ],
      \              [ 'filetype' ] ]
      \ },
      \ }

" VimWiki config
"let g:vimwiki_list = [{'path': '~/Sync/vimwiki'}]

" Leap config
lua require('leap').add_default_mappings()
