let data_dir = has('nvim') ? stdpath('data') : '~/.vim'
if empty(glob(data_dir . '/autoload/plug.vim'))
  silent execute '!curl -fLo '.data_dir.'/autoload/plug.vim --create-dirs  https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

call plug#begin("~/.vim/plugged")
	" Plugin Section
	Plug 'lukas-reineke/indent-blankline.nvim'

	Plug 'nvim-lualine/lualine.nvim'
	Plug 'tpope/vim-surround'
	Plug 'tpope/vim-commentary'
	Plug 'tpope/vim-repeat'
	Plug 'editorconfig/editorconfig-vim'
	Plug 'pangloss/vim-javascript'
	Plug 'othree/html5.vim'
	Plug 'arkav/lualine-lsp-progress'
	Plug 'nvim-tree/nvim-web-devicons'

	" Load Mason for handling language servers
	Plug 'williamboman/mason.nvim'
	Plug 'williamboman/mason-lspconfig.nvim'

	Plug 'sheerun/vim-polyglot'
	Plug 'jesse-kaufman/vim-glandix'

	" Improved syntax highlighting
	Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}

	Plug 'ap/vim-css-color'

	" LSP configuration helpers -- must load after Mason
	Plug 'neovim/nvim-lspconfig'
	" Improved LSP interface
	Plug 'glepnir/lspsaga.nvim', { 'branch': 'main' }

	" Autocomplete menu handler
	Plug 'hrsh7th/cmp-nvim-lsp'
	Plug 'hrsh7th/cmp-buffer'
	Plug 'hrsh7th/cmp-path'
	Plug 'hrsh7th/cmp-cmdline'
	Plug 'hrsh7th/cmp-nvim-lsp-signature-help'
	Plug 'hrsh7th/nvim-cmp'
	Plug 'honza/vim-snippets'
	Plug 'windwp/nvim-autopairs'


	" Add support for UltiSnips in autocomplete menu
	Plug 'SirVer/ultisnips'
	Plug 'quangnguyen30192/cmp-nvim-ultisnips'

	" Formatter integration
	Plug 'mhartington/formatter.nvim'
	" Plug 'phpactor/phpactor', {'for': 'php', 'tag': '*', 'do': 'composer install --no-dev -o'}


	" Icons for LSP menus/popups
	Plug 'onsails/lspkind.nvim'
call plug#end()

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
set scrolloff=5         " offset scroll from edge by 4 lines
set noshowmatch         " show matching (), [], {}, etc
set whichwrap=          " nothing wraps
set termguicolors       " use full color
set nobackup            " no backups
set nowritebackup       " no backups
set signcolumn=number   " put diagnostic signs in number column to save space
set cursorline          " highlight current line
set timeoutlen=1000
set timeout
set nottimeout
let &showbreak='↪'      " wrap character
let mapleader = " "     " set leader to space
let g:tablineclosebutton=0 " hide close tab button
let g:UltiSnipsExpandTrigger="<c-tab>"

augroup RestoreCursorShapeOnExit
    autocmd!
    autocmd VimLeave * set guicursor=a:hor20
augroup END
    set guicursor=a:hor100-iCursor,i-ci-ve:ver50-Cursor,r-cr:hor20,o:hor50
                  \,a:blinkwait700-blinkoff400-blinkon250-Cursor/lCursor
                  \,sm:block-blinkwait175-blinkoff150-blinkon175

" supposedly help startup time
let g:loaded_python_provier=1
let g:python_host_skip_check = 1
let g:python_host_prog='/usr/bin/python2'
let g:python3_host_prog='/usr/bin/python3'
set pyxversion=3

set list listchars=tab:‣\ ,nbsp:␣,eol:¬,space:·,trail:,precedes:,extends: " special characters

" -------------------------- "
"      INDENT BLANKLINE      "
" -------------------------- "

" Highlight current context indent line.
let g:indent_blankline_show_current_context = v:true

" Highlight start of current contect.
let g:indent_blankline_show_current_context_start = v:false

" Hide trailing virtual spaces in indent lines.
let g:indent_blankline_show_trailing_blankline_indent = v:false

" Hide EOL on blank lines (and draw indent line instead)
let g:indent_blankline_show_end_of_line = v:false

" Enable indent lines even if nolist is set
let g:indent_blankline_disable_with_nolist = v:false

"let g:indent_blankline_use_treesitter = v:true



" -------------------------- "
"    NUMBER COLUMN SIGNS     "
" -------------------------- "
sign define LspSagaLightBulb text= texthl=LspSagaLightBulb
sign define DiagnosticSignError text=  texthl=DiagnosticSignError
sign define DiagnosticSignWarn text=  texthl=DiagnosticSignWarn
sign define DiagnosticSignInfo text=  texthl=DiagnosticSignInfo
sign define DiagnosticSignHint text=  texthl=DiagnosticSignHint

nmap <F24> <Space>
nmap <Enter> <Space>

" -------------------------- "
"        KEY MAPPINGS        "
" -------------------------- "

" Map alt/command backspace
inoremap <M-BS>  <C-W>
cnoremap <M-BS>  <C-W>



"
" Make surround easier to use
"

" core 'quote' command in normal mode
nmap <Leader>"   ysiw
" quote current word with '' in normal mode
nmap <Leader>'   ysiw'
" quote current word with HTML tag in normal mode
nmap <Leader><   ysiw<
" quote current word with <> in normal mode
nmap <Leader>>   ysiw>
" quote current word with (<Space><Space>) in normal mode
nmap <Leader>(   ysiw(
" quote current word with () in normal mode
nmap <Leader>)   ysiw)
" remove/delete quote in normal mode
nmap <Leader>"r  ds
nmap <Leader>"d  ds
" change quote in normal mode
nmap <Leader>"c  cs

" core 'quote' command in visual mode
vmap <Leader>"   S
" quote current word with '' in visual mode
vmap <Leader>'   S'
" quote current word with (<Space><Space>) in visual mode
vmap <Leader>(   S(
" quote current word with () in visual mode
vmap <Leader>)   S)

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
nnoremap <PageUp> <C-u>
nnoremap <PageDown> <C-d>
inoremap <PageUp> <C-o><C-u>
inoremap <PageDown> <C-o><C-d>

" opt + left/right
noremap <A-Left> <S-Left>
noremap <A-Right> <S-Right>

" shift + opt + left/right
nnoremap <S-M-Right> E
nnoremap <S-M-Left> B
inoremap <S-M-Right> <C-o>W
inoremap <S-M-Left> <C-o>B

" home / end
noremap <C-A> <Home>
noremap <C-E> <End>
inoremap <C-A> <Home>
inoremap <C-E> <End>
cnoremap <C-A> <Home>
cnoremap <C-E> <End>

" shift+up/dn select by line
nnoremap <S-Up> V<Up>
nnoremap <S-Down> V<Down>
nnoremap <S-Up> V<Up>
nnoremap <S-Down> V<Down>

" shift+left/right select by character
nnoremap <S-Left> v<Left>
nnoremap <S-Right> v<Right>
inoremap <S-Left> <Esc>v<Left>
inoremap <S-Right> <Esc>v<Right>

" shift+arrow works normally in visual mode
vnoremap <S-Up> <Up>
vnoremap <S-Down> <Down>
vnoremap <S-Left> <Left>
vnoremap <S-Right> <Right>


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

autocmd CursorHold Lspsaga show_line_diagnostics

" Automatically equalize splits when resizing window
autocmd VimResized * wincmd =

" -------------------------- "
"          FUNCTIONS         "
" -------------------------- "

" Make <Leader>n run MyToggleNoChars()
map <Leader>n :call MyToggleNoChars()<cr>

" Toggle showing extra characters and number/sign column with :NC
let s:my_noCharsState=1
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
		let &showbreak = '↪'
	endif
	let s:my_noCharsState = !s:my_noCharsState
endfunction

" Retab spaced file, but only indentation
command! Retab call RetabIndents()
func! RetabIndents()
    let saved_view = winsaveview()
    execute '%s@^\( \{'.&ts.'}\)\+@\=repeat("\t", len(submatch(0))/'.&ts.')@'
    call winrestview(saved_view)
endfunc



" -------------------------- "
"     REQUIRED LUA FILES     "
" -------------------------- "
lua << EOF
-- Load Mason
require("mason").setup({
	ui = {
		icons = {
			-- The list icon to use for installed packages.
			package_installed = "",
			-- The list icon to use for packages that are installing, or queued for installation.
			package_pending = "",
			-- The list icon to use for packages that are not installed.
			package_uninstalled = "",
		},
	}
})
require("mason-lspconfig").setup({
	automatic_installation = true,
})

-- Load LSP config -- must happen after Mason above
require('lsp-config')
require('lspsaga-config')

-- Load formatting config
require('formatter-config')

-- Load treesitter settings
require('treesitter-config')

-- Load lualine theme
require('evil_lualine')

-- Load cmp
require('cmp-config')
EOF
