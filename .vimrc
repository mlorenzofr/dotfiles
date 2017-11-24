syntax on
set t_Co=256
colorscheme desert

" line numbers
set number
highlight LineNr ctermfg=cyan ctermbg=0

set hidden
set noswapfile      " Don't use swap files when editing
set nobackup        " Don't use backup files when editing
set laststatus=2
set colorcolumn=81  " Print a line in column 81
highlight ColorColumn ctermfg=7 ctermbg=8

" Enable puppet syntax
au BufRead,BufNewFile *.pp set filetype=puppet

" PEP-8 spec
set textwidth=79   " lines longer than 79 columns will be broken
set softtabstop=-1 " insert/delete 4 spaces when hitting a TAB/BACKSPACE
set shiftround     " round indent to multiple of 'shiftwidth'
set noautoindent   " align the new line indent with the previous line
set hlsearch       " highlight search terms
set incsearch      " show search matches as you type
set visualbell     " don't beep
set noerrorbells   " don't beep
set list           " mark eols
highlight IncSearch cterm=NONE ctermfg=16 ctermbg=10
highlight Search cterm=NONE ctermfg=18 ctermbg=11

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
let g:syntastic_aggregate_errors = 1
let g:syntastic_error_symbol = '✗'
let g:syntastic_warning_symbol = '⚠'
let g:syntastic_style_error_symbol = '!'
let g:syntastic_style_warning_symbol = '-'
let g:syntastic_python_checkers = ['pyflakes', 'flake8']

" Mappings non-recursive for <normal> mode
" Navigation through buffers and tabs
let mapleader = ","
" Syntastic
nnoremap <F5> :SyntasticCheck<CR>
nnoremap <F5><Esc> :SyntasticReset<CR>
" Tabs
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
" Enable visual block mode with leader-v
nnoremap <leader>v <C-V>

" airline configuration
let g:airline_powerline_fonts = 1
let g:airline#extensions#tabline#enabled = 1

" Set specific settings depending on filetype
if has('autocmd')
  autocmd FileType html,xml setlocal listchars-=tab:>.
  autocmd FileType go setlocal nolist
  autocmd FileType make setlocal nolist
  autocmd FileType go setlocal ts=2 sw=2
  autocmd FileType python setlocal ts=4 sw=4 et fo=croql
  autocmd FileType puppet setlocal ts=2 sw=2 et
endif
