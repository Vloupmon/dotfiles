" Specify a directory for plugins
" - For Neovim: stdpath('data') . '/plugged'
" - Avoid using standard Vim directory names like 'plugin'
call plug#begin('~/.vim/plugged')

" Plugins start here
"Plug 'dense-analysis/ale'
Plug 'Chiel92/vim-autoformat'
Plug 'ervandew/supertab'
Plug 'valloric/youcompleteme'
Plug 'SirVer/ultisnips'
Plug 'andrewstuart/vim-kubernetes'
Plug 'ekalinin/Dockerfile.vim'
Plug 'flw-cn/vim-nerdtree-l-open-h-close'
Plug 'guns/xterm-color-table.vim'
Plug 'jiangmiao/auto-pairs'
Plug 'joshdick/onedark.vim'
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
Plug 'lifepillar/vim-solarized8'
Plug 'pedrohdz/vim-yaml-folds'
Plug 'preservim/nerdtree'
Plug 'puremourning/vimspector'
Plug 'rrethy/vim-illuminate'
Plug 'shougo/context_filetype.vim'
Plug 'sickill/vim-pasta'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-repeat'
Plug 'tyru/caw.vim'
Plug 'valloric/matchtagalways'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'yggdroot/indentline'

" Initialize plugin system
call plug#end()

:" General
set autoindent
set colorcolumn=80
set tw=80
set shiftwidth=4
set tabstop=4
set expandtab
set foldlevel=2
set foldmethod=syntax
set foldnestmax=10
set hlsearch
set ignorecase
set incsearch
set nofoldenable
set noswapfile
set number norelativenumber
set termguicolors
set encoding=utf-8
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

" Vimspector
let g:vimspector_enable_mappings = 'HUMAN'

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

" Ale
"let g:ale_linters = { 'cs': ['OmniSharp'] }
"let g:ale_linters = {
"            \'yml': ['yamllint'],
"            \}
"let g:ale_echo_msg_format = '[%linter%] %s [%severity%]'
"let g:ale_sign_error = '✘'
"let g:ale_sign_warning = '⚠'
"let g:ale_lint_on_text_changed = 'never'

" Autoformat
autocmd FileType vim,tex,yaml,zsh,Dockerfile,DOCKERFILE,markdown,conf let b:autoformat_autoindent=0
let g:formatdef_my_c_formatter = '"astyle --style=1tbs"'
let g:formatters_c = ['my_c_formatter']
" au BufWrite * :Autoformat

" Unfuck YAML
autocmd FileType yaml setlocal ts=2 sts=2 sw=2 expandtab

" Spellcheck Markdown files
autocmd BufRead,BufNewFile *.md setlocal spell

" Make YCM compatible with UltiSnips (using supertab)
let g:ycm_key_list_select_completion = ['<C-n>', '<Down>']
let g:ycm_key_list_previous_completion = ['<C-p>', '<Up>']
let g:SuperTabDefaultCompletionType = '<C-n>'

" Better key bindings for UltiSnipsExpandTrigger
let g:UltiSnipsExpandTrigger = "<tab>"
let g:UltiSnipsJumpForwardTrigger = "<tab>"
let g:UltiSnipsJumpBackwardTrigger = "<s-tab>"

" KEYBINDS
nnoremap Y y$
inoremap jk <esc>
inoremap kj <esc>
"This unsets the "last search pattern" register by hitting return
nnoremap <CR> :noh<CR><CR>
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
" Vimspector
" mnemonic 'di' = 'debug inspect' (pick your own, if you prefer!)
" for normal mode - the word under the cursor
nmap <Leader>di <Plug>VimspectorBalloonEval
" for visual mode, the visually selected text
xmap <Leader>di <Plug>VimspectorBalloonEval
nmap <LocalLeader><F11> <Plug>VimspectorUpFrame
nmap <LocalLeader><F12> <Plug>VimspectorDownFrame
