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
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'
Plug 'scrooloose/nerdtree'
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
if has('nvim')
  Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins'  }
  Plug 'carlitux/deoplete-ternjs', { 'do': 'npm install -g tern' }
  Plug 'steelsojka/deoplete-flow'
else
  Plug 'Valloric/YouCompleteMe', { 'do': './install.py --tern-completer' }
endif

" -- JavaScript syntax highlighting
Plug 'othree/yajs.vim'
Plug 'othree/es.next.syntax.vim'
Plug 'mxw/vim-jsx'
Plug 'othree/javascript-libraries-syntax.vim'

" -- CSS syntax highlighting --
if v:version < 704
  Plug 'JulesWang/css.vim'
endif

" -- JavaScript tooling integration
if has('nvim')
  Plug 'neomake/neomake'
else
  Plug 'scrooloose/syntastic'
  Plug 'flowtype/vim-flow'
endif

call plug#end()

syntax enable
set background=dark
colorscheme solarized
set number

" // ===== Configure NeoMake ===== //
function! StrTrim(txt)
  return substitute(a:txt, '^\n*\s*\(.\{-}\)\n*\s*$', '\1', '')
endfunction

let g:flow_path = StrTrim(system('PATH=$(npm bin):$PATH && which flow'))

" // ===== Plugin settings ===== //
if has('nvim')
  " -- Shougo/deoplete.nvim --
  " -- carlitux/deoplete-ternjs --
  let g:deoplete#enable_at_startup = 1
  let g:SuperTabDefaultCompletionType = "<c-n>" " -- completion menu from top to bottom
  let g:deoplete#sources#flow#flow_bin = g:flow_path
  let g:tern_request_timeout = 1
  let g:tern_show_signature_in_pum = 0
  set completeopt-=preview " -- remove preview from completion menu

  " -- neomake/neomake --
  let g:neomake_warning_sign = {
  \ 'text': 'W',
  \ 'texthl': 'WarningMsg',
  \ }
  let g:neomake_error_sign = {
  \ 'text': 'E',
  \ 'texthl': 'ErrorMsg',
  \ }
  let g:neomake_javascript_enabled_makers = ['eslint', 'flow']
  let g:neomake_jsx_enabled_makers = ['eslint', 'flow']

  let g:neomake_javascript_flow_exe = g:flow_path
  let g:neomake_jsx_flow_exe = g:flow_path

  autocmd! BufWritePost * Neomake
else
  " -- scrooloose/syntastic --
  set statusline+=%#warningmsg#
  set statusline+=%{SyntasticStatuslineFlag()}
  set statusline+=%*
  let g:syntastic_always_populate_loc_list = 0
  let g:syntastic_auto_jump = 0
  let g:syntastic_auto_loc_list = 0
  let g:syntastic_check_on_open = 0
  let g:syntastic_check_on_wq = 1
  let g:syntastic_javascript_checkers = ['eslint']
endif

" -- mxw/vim-jsx --
let g:jsx_ext_required = 0

" // ===== Editor configuration ===== //
" Toggling and subtle highlighting of spaces, tabstops and EOLs
set listchars=tab:▸\ ,eol:¬,space:·
highlight NonText ctermfg=233 guifg=#121212 "rgb=18,18,18
highlight SpecialKey ctermfg=233 guifg=#121212 "rgb=18,18,18

" // ===== Keybindings ===== //
let mapleader = "\<Space>"

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
nnoremap <C-T> :FZF<CR>
inoremap <C-T> <ESC>:FZF<CR>i

" == scrooloose/nerdtree ==
let NERDTreeShowHidden=1
nnoremap <C-\> :NERDTreeToggle<CR>
inoremap <C-\> <ESC>:NERDTreeToggle<CR>
