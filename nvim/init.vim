let data_dir = has('nvim') ? '~/.config/nvim' : '~/.vim'
if empty(glob(data_dir . '/autoload/plug.vim'))
  silent execute '!curl -fLo '.data_dir.'/autoload/plug.vim --create-dirs  https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

call plug#begin("~/.vim/plugged")
	" Plugin Section
	Plug 'lukas-reineke/indent-blankline.nvim'
"	Plug 'neoclide/coc.nvim', {'branch': 'release', 'do': 'yarn install --frozen-lockfile'}

	Plug 'nvim-lualine/lualine.nvim'
	" Plug 'sheerun/vim-polyglot'
	Plug 'tpope/vim-surround'
	Plug 'tpope/vim-commentary'
	Plug 'tpope/vim-repeat'
	Plug 'ap/vim-css-color'
	Plug 'editorconfig/editorconfig-vim'
	Plug 'pangloss/vim-javascript'
	Plug 'othree/html5.vim'
	Plug 'arkav/lualine-lsp-progress'
	Plug 'nvim-tree/nvim-web-devicons'

	Plug 'jesse-kaufman/vim-glandix'

	" Improved syntax highlighting
	Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}

	" LSP configuration helpers
	Plug 'neovim/nvim-lspconfig'
	" Improved LSP interface
	Plug 'glepnir/lspsaga.nvim', { 'branch': 'main' }
	" Autocomplete menus
	Plug 'hrsh7th/cmp-nvim-lsp'
	Plug 'hrsh7th/cmp-buffer'
	Plug 'hrsh7th/cmp-path'
	Plug 'hrsh7th/cmp-cmdline'
	Plug 'hrsh7th/nvim-cmp'
	" For ultisnips users.
	Plug 'SirVer/ultisnips'
	Plug 'quangnguyen30192/cmp-nvim-ultisnips'
	" Formatter integration
	Plug 'mhartington/formatter.nvim'
	" Icons for diagnostics popups
	Plug 'onsails/lspkind.nvim'

	let g:coc_global_extensions = [ 'coc-css', 'coc-highlight', 'coc-html', 'coc-json', 'coc-prettier', 'coc-tsserver', 'coc-syntax', 'coc-eslint' ]
call plug#end()

" -------------------------- "
"     REQUIRED LUA FILES     "
" -------------------------- "


" -------------------------- "
"      VIM CONFIGURATION     "
" -------------------------- "

colorscheme glandix     " Set color scheme
set nocompatible        " Use Vim defaults (much better!)
set bs=indent,eol,start " allow backspacing over everything in insert mode
set showcmd             " show the command being typed
set pumheight=10        " popup menu height
set nomodeline          " don't allow config in file comments
set filetype=on         " detect filetype
set number              " show line numbers
set scrolloff=4         " offset scroll from edge by 4 lines
set showmatch           " show matching (), [], {}, etc
set whichwrap=          " nothing wraps
set termguicolors       " use full color
set noswapfile          " no swap files
set nobackup            " no backups
set nowritebackup       " no backups
set signcolumn=number   " put diagnostic signs in number column to save space
set timeoutlen=1000
set timeout
set nottimeout
set ttimeoutlen=1       " wait up to 0ms after Esc for special key
let &showbreak='↪'      " wrap character
let mapleader = " "     " set leader to space
let g:tablineclosebutton=0 " hide close tab button

set guicursor=n-v-c:block-Cursor
set guicursor+=i:ver100-iCursor
set guicursor+=n-v-c:blinkon0
set guicursor+=i:blinkwait10

" supposedly help startup time
let g:loaded_python_provier=1
let g:python_host_skip_check = 1
let g:python_host_prog='/usr/bin/python2'
let g:python3_host_prog='/usr/bin/python3'
set pyxversion=3

" set list listchars=tab:‣\ ,nbsp:␣,eol:¬,space:·,trail:,precedes:,extends: " special characters
set list listchars=tab:‣\ ,nbsp:␣,eol:¬,space:·,trail:,precedes:,extends: " special characters
set list listchars=tab:‣\ ,nbsp:␣,eol:¬,space:·,trail:,precedes:,extends: " special characters

" Indent blankline (shows indent lines and context) settings.
let g:indent_blankline_show_current_context = v:true
let g:indent_blankline_show_current_context_start = v:false
let g:indent_blankline_show_trailing_blankline_indent = v:false
let g:indent_blankline_use_treesitter = v:true
let g:indent_blankline_show_end_of_line = v:false
let g:indent_blankline_disable_with_nolist = v:true


" -------------------------- "
"    NUMBER COLUMN SIGNS     "
" -------------------------- "
sign define LspSagaLightBulb text= texthl=LspSagaLightBulb
sign define DiagnosticSignError text=  texthl=DiagnosticSignError
sign define DiagnosticSignWarn text=  texthl=DiagnosticSignWarn
sign define DiagnosticSignInfo text=  texthl=DiagnosticSignInfo
sign define DiagnosticSignHint text=  texthl=DiagnosticSignHint


" -------------------------- "
"        KEY MAPPINGS        "
" -------------------------- "
"
" Make surround easier to use
nmap <Leader>"   ysiw"
nmap <Leader>'   ysiw'
nmap <Leader>s   ysiw
nmap <Leader>sr  ds
nmap <Leader>sc  cs
nmap <Leader>st  ysiw
nmap <Leader>srt ds
nmap <Leader>sct cs

" toggle comments
map <Leader>c gcc


" Tab / Shift Tab to switch between tabs (:tabe <file>)
nnoremap <Tab> :tabnext<CR>
nnoremap <S-Tab> :tabprevious<CR>
nnoremap <Leader><Tab> :tabnext<CR>
nnoremap <Leader><S-Tab> :tabprevious<CR>

" Make indent/outdent keep selection
vmap < <gv
vmap > >gv

" pgup/pgdn
noremap <PageUp> <C-u>
noremap <PageDown> <C-d>
inoremap <PageUp> <C-o><C-u>
inoremap <PageDown> <C-o><C-d>
cnoremap <PageUp> <C-u>
cnoremap <PageDown> <C-d>

" opt + left/right
"map f e
noremap <A-Left> b
noremap <A-Right> e
inoremap <A-Left> <C-o>b
inoremap <A-Right> <C-o>w
cnoremap <A-Right> e

" shift + opt + left/right
noremap <S-M-Right> E
noremap <S-M-Left> B
inoremap <S-M-Right> <C-o>W
inoremap <S-M-Left> <C-o>B
cnoremap <S-M-Right> E
cnoremap <S-M-Left> B

" home / end
noremap <C-A> <Home>
noremap <C-E> <End>
inoremap <C-A> <Home>
inoremap <C-E> <End>
cnoremap <C-A> <Home>
cnoremap <C-E> <End>

" shift+arrow selection
nmap <S-Up> v<Up>
nmap <S-Down> v<Down>
nmap <S-Left> v<Left>
nmap <S-Right> v<Right>
vmap <S-Up> <Up>
vmap <S-Down> <Down>
vmap <S-Left> <Left>
vmap <S-Right> <Right>
imap <S-Up> <Esc>v<Up>
imap <S-Down> <Esc>v<Down>
imap <S-Left> <Esc>v<Left>
imap <S-Right> <Esc>v<Right>


" -------------------------- "
"           AUTOCMD          "
" -------------------------- "

" remember cursor position
autocmd BufReadPost * if line("'\"") > 0 && line("'\"") <= line("$") | exe "normal! g'\"" | endif

" Show trailing spaces, but only when in normal mode
autocmd BufWinEnter * match ErrorMsg /\s\+$/
autocmd InsertEnter * match ErrorMsg /\s\+\%#\@<!$/
autocmd InsertLeave * match ErrorMsg /\s\+$/
autocmd InsertLeave * match ErrorMsg /\s\+$/

" Show spaces intermixed with tabs in insert and normal mode
autocmd BufWinEnter * match ErrorMsg /\( \+\ze\t\)\+\ze/
autocmd InsertEnter * match ErrorMsg /\( \+\ze\t\)\+\ze/
autocmd InsertLeave * match ErrorMsg /\( \+\ze\t\)\+\ze/

" Clear matches when exiting
autocmd BufWinLeave * call clearmatches()

" autocmd CursorHold Lspsaga show_line_diagnostics



" -------------------------- "
"          FUNCTIONS         "
" -------------------------- "

"
" Toggle showing extra characters and number/sign column with :NC
"
let s:my_noCharsState=1
map <Leader>n :call MyToggleNoChars()<cr>
" END NC
function! MyToggleNoChars()
	if s:my_noCharsState
		set nonumber
		set nolist
		set signcolumn=no
		let &showbreak = ''
	else
		set number
		set list
		set signcolumn=number
		let &showbreak = '» '
	endif
	let s:my_noCharsState = !s:my_noCharsState
endfunction
" END NC



" Retab spaced file, but only indentation
command! Retab call RetabIndents()
func! RetabIndents()
    let saved_view = winsaveview()
    execute '%s@^\( \{'.&ts.'}\)\+@\=repeat("\t", len(submatch(0))/'.&ts.')@'
    call winrestview(saved_view)
endfunc

" Load Lua LSP config
lua require('lsp-config')

" Load Lua formatting config
lua require('formatting')

" Load lualine theme
lua require('evil_lualine')

