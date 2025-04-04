" Download with:
" wget -O ~/.vimrc https://raw.githubusercontent.com/landennguyen/dotfiles/.vimrc

filetype plugin indent on
set autoindent
set timeoutlen=300 " http://stackoverflow.com/questions/2158516/delay-before-o-opens-a-new-line
set encoding=utf-8
set scrolloff=2
set noshowmode
set hidden
set nowrap
set nojoinspaces

" Always draw sign column. Prevent buffer moving when adding/deleting sign.
set signcolumn=yes

" Permanent undo
set undodir=~/.vimdid
set undofile

set shiftwidth=4
set softtabstop=4
set tabstop=4
set expandtab

" Search results centered please
nnoremap <silent> n nzz
nnoremap <silent> N Nzz
nnoremap <silent> * *zz
nnoremap <silent> # #zz
nnoremap <silent> g* g*zz

set relativenumber " Relative line numbers
set number " Also show current absolute line
