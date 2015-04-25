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

" Mappings non-recursive for <normal> mode
" Navigation through buffers and tabs
let mapleader = ","
nnoremap <S-Tab> :NERDTreeToggle<CR>
nnoremap <S-x> :tabclose!<CR>
nnoremap <S-Left> :tabp<CR>
nnoremap <S-Right> :tabn<CR>
" Buffers
nnoremap <S-Up> :bn<CR>
nnoremap <S-Down> :bp<CR>
nnoremap <S-X> :bd!<CR>
" Splits
nnoremap <leader><Bar> :vsp<CR>
nnoremap <leader>s :sp<CR>
nnoremap <leader><Tab> <C-W>w
nnoremap <leader>x <C-w>q

" airline configuration
let g:airline_powerline_fonts = 1
let g:airline#extensions#tabline#enabled = 1
