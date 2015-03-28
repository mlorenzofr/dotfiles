syntax on
set number
set hidden
set noswapfile
set nobackup
set laststatus=2
colorscheme desert

" Enable puppet syntax
au BufRead,BufNewFile *.pp set filetype=puppet

" PEP-8 spec
set textwidth=79  " lines longer than 79 columns will be broken
set shiftwidth=4  " operation >> indents 4 columns; << unindents 4 columns
set tabstop=4     " a hard TAB displays as 4 columns
set expandtab     " insert spaces when hitting TABs
set softtabstop=4 " insert/delete 4 spaces when hitting a TAB/BACKSPACE
set shiftround    " round indent to multiple of 'shiftwidth'
set noautoindent  " align the new line indent with the previous line

" Vundle configuration
set nocompatible
filetype off


set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

Plugin 'gmarik/Vundle.vim'

" Additional Plugins
Plugin 'nvie/vim-flake8'
Plugin 'scrooloose/syntastic'
Plugin 'scrooloose/nerdtree'
Plugin 'tpope/vim-fugitive'
Plugin 'Valloric/YouCompleteMe'
Plugin 'bling/vim-airline'

call vundle#end()
filetype plugin indent on

" Syntastic configuration
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*

let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0

" NerdTree configuration
map <S-Tab> :NERDTreeToggle<CR>
map <S-Left> :tabp<CR>
map <S-Right> :tabn<CR>
map <S-x> :tabclose!<CR>
map <S-Up> :bn<CR>
map <S-Down> :bp<CR>

" airline configuration
let g:airline_powerline_fonts = 1
let g:airline#extensions#tabline#enabled = 1
