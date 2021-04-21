"PLUGINS

call plug#begin('~/.vim/plugged')
" vim airline
Plug 'vim-airline/vim-airline'
" colorscheme
Plug 'sonph/onehalf', { 'rtp': 'vim' }
Plug 'rakr/vim-one'
Plug 'tyrannicaltoucan/vim-quantum'
Plug 'joshdick/onedark.vim'
call plug#end()

"---------------------------------------------------------------------------------------

"MAPPINGS

"Ctr-D to switch from vim to terminal and from terminal to vim
noremap <C-d> :sh<CR>
"Move through tabs with ctrl-l and ctrl-h
nnoremap <C-h> :tabprevious<CR>
nnoremap <C-l> :tabnext<CR>
" TagBar, show code functions and variables, really nice
nmap <F8> :TagbarToggle<CR>
" TAB in general mode will move to text buffer
nnoremap <TAB> :bnext<CR>
" " SHIFT-TAB will go back
nnoremap <S-TAB> :bprevious<CR>

" autocompletions
inoremap ( ()<Esc>i
inoremap { {}<Esc>i
inoremap {<CR> {<CR>}<Esc>O
inoremap [ []<Esc>i
inoremap ' ''<Esc>i
inoremap " ""<Esc>i

"---------------------------------------------------------------------------------------

"SETTINGS

set mouse=a
set nu " Turn on line numbers
syntax on
set background=dark
syntax enable
" In insert mode, change cursor
let &t_SI = "\e[6 q"
let &t_EI = "\e[2 q"
" Set indentation (Tab space) lenght, comment line for default
set softtabstop=4 shiftwidth=4 noexpandtab
set smartindent
set autoindent


"---------------------------------------------------------------------------------------

" THEME

if (has("autocmd") && !has("gui_running"))
  augroup colorset
    autocmd!
    let s:white = { "gui": "#ABB2BF", "cterm": "145", "cterm16" : "7" }
    autocmd ColorScheme * call onedark#set_highlight("Normal", { "fg": s:white }) " `bg` will not be styled since there is no `bg` setting
  augroup END
endif
hi Comment cterm=italic
let g:onedark_hide_endofbuffer=1
let g:onedark_terminal_italics=1
let g:onedark_termcolors=256

syntax on
colorscheme onedark

set t_Co=256
set cursorline
let g:lightline = { 'colorscheme': 'onehalfdark' }

if exists('+termguicolors')
    let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
    let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"
    set termguicolors
endif


" enable tabline
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#left_sep = ''
let g:airline#extensions#tabline#left_alt_sep = ''
let g:airline#extensions#tabline#right_sep = ''
let g:airline#extensions#tabline#right_alt_sep = ''

" enable powerline fonts
let g:airline_powerline_fonts = 1
let g:airline_left_sep = ''
let g:airline_right_sep = ''
" Switch to your current theme
let g:airline_theme = 'onedark'
" Always show tabs
set showtabline=2
" We don't need to see things like -- INSERT -- anymore
set noshowmode

"---------------------------------------------------------------------------------------
