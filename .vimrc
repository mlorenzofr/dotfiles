" Files
set hidden          " Hide buffers instead of close them
set noswapfile      " Don't use swap files when editing
set nobackup        " Don't use backup files when editing
set history=250     " Increase command history
set undolevels=250  " Increase undo levels
scriptencoding utf-8
set encoding=utf-8

" UI
" Set colors
colorscheme desert
set t_Co=256
"
syntax on                           " Enable syntax colors
set number                          " Show line numbers
set laststatus=2                    " Show status line
set colorcolumn=81                  " Highlight column 81
set cursorline                      " Highlight the cursor line
set showmatch                       " Highlight matching parenthesis
set visualbell                      " don't beep
set noerrorbells                    " don't beep
set list                            " mark eols
set listchars=tab:→\ ,eol:↲,trail:• " Set symbols for whitespaces

" Spaces & Tabs
set tabstop=2       " spaces inserted with a tab keystroke
set shiftwidth=2    " spaces inserted for indentation
set softtabstop=-1  " use tabstop value when needed
set shiftround      " round indent to multiple of 'shiftwidth'
set noautoindent    " align the new line indent with the previous line
set expandtab       " insert spaces instead of tabs

" Search
set hlsearch        " highlight search terms
set incsearch       " show search matches as you type

" Highlight configuration
highlight LineNr ctermfg=cyan ctermbg=0
highlight ColorColumn ctermfg=7 ctermbg=8
highlight IncSearch cterm=NONE ctermfg=16 ctermbg=10
highlight Search cterm=NONE ctermfg=18 ctermbg=11
highlight CursorLine cterm=NONE ctermbg=233
highlight CursorNumber ctermfg=11 ctermbg=16
highlight SpecialKey cterm=bold ctermfg=11
highlight NonText cterm=bold ctermfg=21

" Enable puppet syntax
au BufRead,BufNewFile *.pp set filetype=puppet

" HCL (HashiCorp Configuration Language)
au BufNewFile,BufRead *.hcl set filetype=hcl

" Nomad
autocmd BufNewFile,BufRead *.nomad set filetype=hcl

" Terraform
autocmd BufNewFile,BufRead *.tf     set filetype=hcl
autocmd BufNewFile,BufRead *.tfvars set filetype=hcl

" vim-plug configuration
call plug#begin()

" Additional Plugins
Plug 'nvie/vim-flake8'
Plug 'scrooloose/syntastic'
Plug 'scrooloose/nerdtree'
Plug 'tpope/vim-fugitive'
Plug 'bling/vim-airline'
Plug 'Yggdroot/indentLine'
Plug 'rodjek/vim-puppet'
Plug 'pearofducks/ansible-vim'

call plug#end()
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
let g:syntastic_ansible_checkers = ['ansible_lint']
let g:syntastic_yaml_checkers = ['yamllint']
let g:syntastic_go_checkers = ['golangci_lint']

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
nnoremap <leader>x :bd!<CR>
" Splits
nnoremap <leader>1 :vsp<CR>
nnoremap <leader>- :sp<CR>
nnoremap <leader><Tab> <C-W>w
" Enable visual block mode with leader-v
nnoremap <leader>v <C-V>
" Save files using sudo with w!!
cnoremap w!! w !sudo tee > /dev/null %

" airline configuration
let g:airline_powerline_fonts = 1
let g:airline#extensions#tabline#enabled = 1

" indentLine configuration
let g:indentLine_char = '¦'
let g:indentLine_enabled = 1

" ansible-vim
let g:ansible_name_highlight = 'd'

" Set specific settings depending on filetype
if has('autocmd')
  autocmd FileType html,xml setlocal listchars-=tab:>.
  autocmd FileType make setlocal nolist noexpandtab
  autocmd FileType go setlocal ts=2 sw=2 nolist noexpandtab
  autocmd FileType python setlocal ts=4 sw=4 et tw=79 fo=croqlt
  autocmd FileType puppet setlocal ts=2 sw=2 et
  autocmd FileType json setlocal ts=2 sw=2 et fo=tcq2l
  autocmd FileType json let g:indentLine_enabled = 0
  autocmd FileType yaml setlocal ts=2 sw=2 et
  autocmd FileType hcl setlocal ts=2 sw=2 et
endif

if exists('$TMUX')
  map [1;5D B
  map [1;5C W
  nnoremap <C-E> $
  nnoremap <C-A> 0
endif
