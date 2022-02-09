set nocompatible

"" ----------------------------------------
""  Plugin
"" ----------------------------------------
let s:vimdir   = has('nvim') ? '~/.config/nvim/' : '~/.vim/'
let s:plugdir  = s:vimdir . 'plugged'
let s:plugfile = s:vimdir . 'autoload/plug.vim'
let s:plugurl  = 'https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
if empty(glob(s:plugfile))
  silent execute '!mkdir -p ' . s:vimdir . 'autoload'
  if executable('curl')
    silent execute '!curl -sLo ' . s:plugfile ' ' . s:plugurl
  else
    silent !echo 'vim-plug failed: you need curl to install' | cquit
  endif
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif
call plug#begin(s:plugdir)
Plug 'sheerun/vim-polyglot'
Plug 'Chiel92/vim-autoformat'
Plug 'SirVer/ultisnips'
Plug 'andrewstuart/vim-kubernetes'
Plug 'dense-analysis/ale'
Plug 'ekalinin/Dockerfile.vim'
Plug 'ervandew/supertab'
Plug 'farmergreg/vim-lastplace'
Plug 'flw-cn/vim-nerdtree-l-open-h-close'
Plug 'guns/xterm-color-table.vim'
Plug 'jiangmiao/auto-pairs'
Plug 'joshdick/onedark.vim'
Plug 'junegunn/fzf.vim'
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'ntpeters/vim-better-whitespace'
Plug 'pedrohdz/vim-yaml-folds'
Plug 'preservim/nerdtree'
Plug 'rrethy/vim-illuminate'
Plug 'shougo/context_filetype.vim'
Plug 'sickill/vim-pasta'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-repeat'
Plug 'tyru/caw.vim'
Plug 'valloric/matchtagalways'
Plug 'valloric/youcompleteme'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'yggdroot/indentline'
Plug 'ap/vim-css-color'
call plug#end()

" General
filetype plugin indent on
set autoindent
set autoread
set backspace=indent,eol,start
set belloff=all
set colorcolumn=80
set conceallevel=0
set encoding=utf-8
set expandtab
set foldlevel=2
set foldmethod=syntax
set foldnestmax=10
set hlsearch incsearch
set ignorecase
set lazyredraw
set nofoldenable
set noswapfile
set number norelativenumber
set ruler showcmd
set shiftwidth=4
set signcolumn=yes
set tabstop=4
set termguicolors
set ttyfast
set tw=80
set whichwrap=b,s,h,l,<,>,[,]
set wildmenu
sy on

syntax enable
syntax on

" Styling
colorscheme onedark
let g:onedark_hide_endofbuffer = 1
let g:onedark_terminal_italics = 1
let g:airline_theme='onedark'
let g:airline_powerline_fonts = 1
let g:airline#extensions#tmuxline#enabled = 0
let g:indentLine_char = '⦙'
" Cursors
let &t_EI = "\<Esc>[2 q"
let &t_SI = "\<Esc>[6 q"
let &t_SR = "\<Esc>[4 q"
" Unfuck cursor on exit for Zsh prompt
autocmd VimLeave * call system('printf "\e[5 q" > $TTY')

" fzf
let FZF_DEFAULT_COMMAND = 'rg --files --no-ignore --hidden --follow --glob "!.git/*"'
" Always enable preview window on the right with 60% width
let g:fzf_preview_window = 'right:60%'

" Use ripgrep instead of GNU grep
if executable('rg')
    set grepprg=rg\ --vimgrep\ --no-heading\ --smart-case
    set grepformat=%f:%l:%c:%m,%f:%l:%m
endif

" Define Find command with fzf and rg
" --column: Show column number
" --line-number: Show line number
" --no-heading: Do not show file headings in results
" --fixed-strings: Search term as a literal string
" --ignore-case: Case insensitive search
" --no-ignore: Do not respect .gitignore, etc...
" --hidden: Search hidden files and folders
" --follow: Follow symlinks
" --glob: Additional conditions for search (in this case ignore everything in the .git/ folder)
" --color: Search color options
command! -bang -nargs=* Find call fzf#vim#grep('rg --column --line-number --no-heading --fixed-strings --ignore-case --no-ignore --hidden --follow --glob "!.git/*" --color "always" '.shellescape(<q-args>), 1, <bang>0)

" NerdTree
let g:NERDTreeShowHidden=1
let g:nerdtree_sync_cursorline = 1
" Exit Vim if NERDTree is the only window left.
autocmd BufEnter * if tabpagenr('$') == 1 && winnr('$') == 1 &&
            \exists('b:NERDTree') && b:NERDTree.isTabTree() | quit | endif

" Whitespace handling
let g:better_whitespace_enabled=1
let g:strip_whitespace_on_save = 1
let g:strip_whitespace_confirm=0

" Ale
let g:ale_linters = { 'yml': ['yamllint'] }
let g:ale_echo_msg_format = '[%linter%] %s [%severity%]'
let g:ale_sign_error = '✘'
let g:ale_sign_warning = '⚠'
let g:airline#extensions#ale#enabled = 1

" Autoformat
autocmd FileType vim,tex,yaml,zsh,Dockerfile,markdown,conf let b:autoformat_autoindent=0
let g:formatdef_my_c_formatter = '"astyle --style=1tbs"'
let g:formatters_c = ['my_c_formatter']
" au BufWrite * :Autoformat

" Unfuck YAML
autocmd FileType yaml setlocal ts=2 sts=2 sw=2 expandtab

" Make YCM compatible with UltiSnips (using supertab)
let g:ycm_key_list_select_completion = ['<C-n>', '<Down>']
let g:ycm_key_list_previous_completion = ['<C-p>', '<Up>']
let g:SuperTabDefaultCompletionType = '<C-n>'

" Better key bindings for UltiSnipsExpandTrigger
let g:UltiSnipsExpandTrigger = "<tab>"
let g:UltiSnipsJumpForwardTrigger = "<tab>"
let g:UltiSnipsJumpBackwardTrigger = "<s-tab>"

" Spellcheck Markdown files
autocmd BufRead,BufNewFile *.md setlocal spell

" KEYBINDS
nnoremap Y y$
inoremap jk <esc>
inoremap kj <esc>
"This unsets the "last search pattern" register by hitting return
nnoremap <CR> :noh<CR>
" NerdTree
map <C-n> :NERDTreeToggle<CR>
map <C-p> :GFiles<CR>
map <C-f> :Files<CR>
" Auto indent
" ^[[25~ == F13 see
" http://aperiodic.net/phil/archives/Geekery/term-function-keys.html
noremap ^[[25~ :Autoformat<CR>
inoremap ^[[25~ <esc>:Autoformat<CR>
" Navigate Tabs
map <C-t><up> :tabr<CR>
map <C-t><down> :tabl<CR>
map <C-t><left> :tabp<CR>
map <C-t><right> :tabn<CR>
