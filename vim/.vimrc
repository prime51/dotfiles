" Comments in Vimscript start with a `"`.

" If you open this file in Vim, it'll be syntax highlighted for you.

" Automatically install vim-plug
let data_dir = has('nvim') ? stdpath('data') . '/site' : '~/.vim'
if empty(glob(data_dir . '/autoload/plug.vim'))
  silent execute '!curl -fLo '.data_dir.'/autoload/plug.vim --create-dirs  https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

" Specify a directory for plugins
" - For Neovim: stdpath('data') . '/plugged'
" - Avoid using standard Vim directory names like 'plugin'
call plug#begin('~/.vim/plugged')

" Make sure you use single quotes

Plug 'vim-scripts/indentpython.vim'
Plug 'ycm-core/YouCompleteMe'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'tpope/vim-fugitive'
Plug 'vim-syntastic/syntastic'
Plug 'dhruvasagar/vim-zoom'
Plug 'iamcco/markdown-preview.nvim'
Plug 'wakatime/vim-wakatime'
Plug 'bkad/CamelCaseMotion'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-surround'
Plug 'kien/ctrlp.vim'
Plug 'preservim/nerdtree'

" Initialize plugin system
call plug#end()


" Vim is based on Vi. Setting `nocompatible` switches from the default
" Vi-compatibility mode and enables useful Vim functionality. This
" configuration option turns out not to be necessary for the file named
" '~/.vimrc', because Vim automatically enters nocompatible mode if that file
" is present. But we're including it here just in case this config file is
" loaded some other way (e.g. saved as `foo`, and then Vim started with
" `vim -u foo`).
set nocompatible

" Turn on syntax highlighting.
syntax on

" Disable the default Vim startup message.
set shortmess+=I

" Show line numbers.
set number

" This enables relative line numbering mode. With both number and
" relativenumber enabled, the current line shows the true line number, while
" all other lines (above and below) are numbered relative to the current line.
" This is useful because you can tell, at a glance, what count is needed to
" jump up or down to a particular line, by {count}k to go up or {count}j to go
" down.
set relativenumber

" Always show the status line at the bottom, even if you only have one window open.
set laststatus=2

" The backspace key has slightly unintuitive behavior by default. For example,
" by default, you can't backspace before the insertion point set with 'i'.
" This configuration makes backspace behave more reasonably, in that you can
" backspace over anything.
set backspace=indent,eol,start

" By default, Vim doesn't let you hide a buffer (i.e. have a buffer that isn't
" shown in any window) that has unsaved changes. This is to prevent you from "
" forgetting about unsaved changes and then quitting e.g. via `:qa!`. We find
" hidden buffers helpful enough to disable this protection. See `:help hidden`
" for more information on this.
set hidden

" This setting makes search case-insensitive when all characters in the string
" being searched are lowercase. However, the search becomes case-sensitive if
" it contains any capital letters. This makes searching more convenient.
set ignorecase
set smartcase

" Enable searching as you type, rather than waiting till you press enter.
set incsearch

" Unbind some useless/annoying default key bindings.
nmap Q <Nop> " 'Q' in normal mode enters Ex mode. You almost never want this.

" Disable audible bell because it's annoying.
set noerrorbells visualbell t_vb=

" Enable mouse support. You should avoid relying on this too much, but it can
" sometimes be convenient.
set mouse+=a

" Auto refresh the vim buffer
set autoread
set autowrite

" Try to prevent bad habits like using the arrow keys for movement. This is
" not the only possible bad habit. For example, holding down the h/j/k/l keys
" for movement, rather than using more efficient movement commands, is also a
" bad habit. The former is enforceable through a .vimrc, while we don't know
" how to prevent the latter.
" Do this in normal mode...
nnoremap <Left>  :echoe "Use h"<CR>
nnoremap <Right> :echoe "Use l"<CR>
nnoremap <Up>    :echoe "Use k"<CR>
nnoremap <Down>  :echoe "Use j"<CR>
" ...and in insert mode
inoremap <Left>  <ESC>:echoe "Use h"<CR>
inoremap <Right> <ESC>:echoe "Use l"<CR>
inoremap <Up>    <ESC>:echoe "Use k"<CR>
inoremap <Down>  <ESC>:echoe "Use j"<CR>
" ...and in visual mode
vnoremap <Left>  <ESC>:echoe "Use h"<CR>
vnoremap <Right> <ESC>:echoe "Use l"<CR>
vnoremap <Up>    <ESC>:echoe "Use k"<CR>
vnoremap <Down>  <ESC>:echoe "Use j"<CR>

" Remap 'jj' as '<Esc>' in insert mode
inoremap jj <ESC>

" Switch between tabs
nnoremap <C-h>    :tabp<CR>
nnoremap <C-l>    :tabn<CR>

" Spaces & Tabs
set tabstop=4       " number of visual spaces per TAB
set softtabstop=4   " number of spaces in tab when editing
set shiftwidth=4    " Insert 4 spaces on a tab
set expandtab       " tabs are spaces, mainly because of python

" Other UI Configs
set wildmenu
set showmatch
set cursorline
set linebreak
set hlsearch
set scrolloff=12
set listchars=tab:>-,trail:-

" Jump to start and end of line using the home row keys
map H ^
map L $

" yank to clipboard
if has("clipboard")
    set clipboard=unnamedplus " copy to the system clipboard
endif

" (Shift)Tab (de)indents code
vnoremap <Tab> >
vnoremap <S-Tab> <

" Use actual TAB in Makefile
autocmd FileType make setlocal noexpandtab

" Spot and remove possible extraneous whitespaces
highlight BadWhitespace ctermbg=red guibg=darkred
au BufRead,BufNewFile *.py,*.pyw,*.c,*.h match BadWhitespace /\s\+$/
au BufNewFile,BufRead *.js,*.html,*.css,*.vue
\ set tabstop=2 |
\ set softtabstop=2 |
\ set shiftwidth=2
autocmd BufWritePre *.py,*.pyw,*.c,*.h,*.js,*.html,*.css,*.vue :%s/\s\+$//

" Open terminal in new tab
nnoremap <Leader>t  :tab term ++close<CR>


" Plugin settings
"

" ctrlp plugin
let g:ctrlp_map = '<c-p>'
let g:ctrlp_cmd = 'CtrlP'

" NERDTree plugin
nnoremap <Leader>n :NERDTreeToggle<CR>
nnoremap <Leader>f :NERDTreeFind<CR>

" vim-commentary plugin
autocmd FileType python setlocal commentstring=#\ %s

" CamelCaseMotion plugin
let g:camelcasemotion_key = '<leader>'

" vim-airline plugin
let g:airline_theme='wombat'
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#left_sep = ' '
let g:airline#extensions#tabline#left_alt_sep = '|'
let g:airline#extensions#tabline#formatter = 'default'

" YouCompleteMe plugin
let g:ycm_autoclose_preview_window_after_insertion = 1
let g:ycm_goto_buffer_command = 'split-or-existing-window'
nnoremap <F5>           :YcmForceCompileAndDiagnostics<CR>
nnoremap <leader>gic    :YcmCompleter GoToInclude<CR>
nnoremap <leader>gdc    :YcmCompleter GoToDeclaration<CR>
nnoremap <leader>gdf    :YcmCompleter GoToDefinition<CR>
nnoremap <leader>gip    :YcmCompleter GoToImprecise<CR>
nnoremap <leader>f      :YcmCompleter FixIt<CR>

let g:ycm_python_interpreter_path = ''
let g:ycm_python_sys_path = []
let g:ycm_extra_conf_vim_data = [
  \  'g:ycm_python_interpreter_path',
  \  'g:ycm_python_sys_path'
  \]
let g:ycm_global_ycm_extra_conf = '~/.ycm/global_extra_conf.py'

" syntastic plugin
" set statusline+=%#warningmsg#
" set statusline+=%{SyntasticStatuslineFlag()}
" set statusline+=%*

let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0
