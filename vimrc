set nocompatible


" // ===== Plugins ===== //
" -- Add support for Python plugins-- 
if has('nvim')
  let g:python_host_prog = $HOME.'/.pyenv/versions/neovim2/bin/python'
  let g:python2_host_prog = $HOME.'/.pyenv/versions/neovim2/bin/python'
  let g:python3_host_prog = $HOME.'/.pyenv/versions/neovim3/bin/python'
endif

call plug#begin()

" -- General editor plugins --
Plug 'tpope/vim-surround'
Plug 'tpope/vim-commentary'
Plug 'junegunn/fzf', { 'do': './install --bin' }
Plug 'junegunn/fzf.vim'
Plug 'scrooloose/nerdtree', { 'on': 'NERDTreeToggle' }
Plug 'Xuyuanp/nerdtree-git-plugin'
Plug 'tpope/vim-repeat'
Plug 'jiangmiao/auto-pairs'
Plug 'airblade/vim-gitgutter'
Plug 'nathanaelkane/vim-indent-guides'
Plug 'itchyny/lightline.vim'
Plug 'editorconfig/editorconfig-vim'
Plug 'christoomey/vim-tmux-navigator'
Plug 'altercation/vim-colors-solarized'

" -- Automcomplete plugins --
Plug 'ervandew/supertab'
Plug 'Shougo/neocomplete'
Plug 'flowtype/vim-flow', { 'for': 'javascipt' }

" -- JavaScript syntax highlighting
Plug 'othree/yajs.vim', { 'for': 'javascript' }
Plug 'othree/es.next.syntax.vim', { 'for': 'javascript' }
Plug 'mxw/vim-jsx', { 'for': 'javascript' }

" -- CSS syntax highlighting --
Plug 'ap/vim-css-color'
if v:version < 704
  Plug 'JulesWang/css.vim', { 'for': 'css' }
endif

" -- JavaScript tooling integration
Plug 'w0rp/ale'

" -- Elm integration
Plug 'ElmCast/elm-vim', { 'for': 'elm' }

call plug#end()

filetype plugin indent on
syntax enable
set background=dark
colorscheme solarized
set number
set ts=2 sw=2 et
set backspace=indent,eol,start

function! ShouldLint()
  return filereadable('.eslintrc') || filereadable('.eslintrc.json') ? 1 : 0
endfunction

function! ShouldTypeCheck()
  return filereadable('.flowconfig') ? 1 : 0
endfunction

function! StrTrim(txt)
  return substitute(a:txt, '^\n*\s*\(.\{-}\)\n*\s*$', '\1', '')
endfunction

" // ===== Configure NeoMake ===== //
let g:flow#enable = 0
let g:flow#omnifunc = ShouldTypeCheck()
let g:flow_path = StrTrim(system('PATH=$(npm bin):$PATH && which flow'))

" // ===== Plugin settings ===== //

" == w0rp/ale ==
let javascript_linters = []
if ShouldLint()
  call add(javascript_linters, 'eslint')
endif
if ShouldTypeCheck()
  call add(javascript_linters, 'flow')
endif
let g:ale_linters = { 'javascipt': javascript_linters }
let g:ale_sign_column_always = 1

" == pangloss/vim-javascript ==
let g:javascript_plugin_flow = ShouldTypeCheck()

" -- mxw/vim-jsx --
let g:jsx_ext_required = 0

" == Shougo/neocomplete ==
" == ervandew/supertab ==
let g:neocomplete#enable_at_startup = 1
let g:SuperTabDefaultCompletionType = "<C-n>"

" -- ElmCast/elm-vim
let g:elm_format_autosave = 1

" // ===== Editor configuration ===== //
" Toggling and subtle highlighting of spaces, tabstops and EOLs
set listchars=tab:▸\ ,eol:¬,space:·
highlight NonText ctermfg=233 guifg=#121212 "rgb=18,18,18
highlight SpecialKey ctermfg=233 guifg=#121212 "rgb=18,18,18

" // ===== Keybindings ===== //
let mapleader = "\<Space>"
" == christoomey/vim-tmux-navigator
let g:tmux_navigator_no_mappings = 1
nnoremap <silent> <C-h> :TmuxNavigateLeft<CR>
nnoremap <silent> <C-j> :TmuxNavigateDown<CR>
nnoremap <silent> <C-k> :TmuxNavigateUp<CR>
nnoremap <silent> <C-l> :TmuxNavigateRight<CR>

nmap <leader>vr :sp $MYVIMRC<CR>
nmap <leader>so :source $MYVIMRC<CR>
nmap <leader>l :set list!<CR> " toggle whitespace chars
nmap <leader>n :set rnu!<CR> " toggle relative line numbers

" Edit another file in the same directory as the current file
" uses expression to extract path from current file's path
map <Leader>e :e <C-R>=escape(expand("%:p:h"),' ') . '/'<CR>
map <Leader>sp :split <C-R>=escape(expand("%:p:h"), ' ') . '/'<CR>
map <Leader>vsp :vsplit <C-R>=escape(expand("%:p:h"), ' ') . '/'<CR>

" -- junegunn/fzf --
" -- junegunn/fzf.vim --
nnoremap <C-T> :Files<CR>
inoremap <C-T> <ESC>:Files<CR>i
nnoremap <C-F> :Ag<CR>
inoremap <C-F> <ESC>:Ag<CR>i

" == scrooloose/nerdtree ==
let NERDTreeShowHidden=1
nnoremap <C-\> :NERDTreeToggle<CR>
inoremap <C-\> <ESC>:NERDTreeToggle<CR>
