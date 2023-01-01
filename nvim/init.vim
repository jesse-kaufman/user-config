let data_dir = has('nvim') ? stdpath('data') : '~/.vim'
if empty(glob(data_dir . '/autoload/plug.vim'))
  silent execute '!curl -fLo '.data_dir.'/autoload/plug.vim --create-dirs  https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

call plug#begin("~/.vim/plugged")
	" Plugin Section
	Plug 'lukas-reineke/indent-blankline.nvim'

	" Custom status line.
	Plug 'nvim-lualine/lualine.nvim'

	" Surround text with quotes/tags/etc.
	Plug 'tpope/vim-surround'

	" Toggle comments quickly
	Plug 'tpope/vim-commentary'

	" Repeat more things (like toggle comments)
	Plug 'tpope/vim-repeat'

	" Highlighting/indents for JavaScript
	Plug 'pangloss/vim-javascript'

	" Highlighting/indent support for HTML5
	Plug 'othree/html5.vim'

	" Add LSP progress to lualine (not working)
	Plug 'arkav/lualine-lsp-progress'

	" Add devicons
	Plug 'nvim-tree/nvim-web-devicons'

	" Use Mason for handling installing/loading language server support.
	Plug 'williamboman/mason.nvim'
	Plug 'williamboman/mason-lspconfig.nvim'

	" Use null-ls for external linters
	Plug 'jose-elias-alvarez/null-ls.nvim'

	" Integrate null-ls with Mason
	Plug 'jay-babu/mason-null-ls.nvim'

	" Required by null-ls
	Plug 'nvim-lua/plenary.nvim'

	" Advanced syntax highlighting.
	Plug 'sheerun/vim-polyglot'

	" Show colors in code.
	Plug 'ap/vim-css-color'

	" Honor .editorconfig files
	Plug 'gpanders/editorconfig.nvim'


	"
	" LSP / Diagnostics
	"

	" LSP configuration helpers -- must load after Mason.
	Plug 'neovim/nvim-lspconfig'

	" Improved LSP interface.
	Plug 'glepnir/lspsaga.nvim', { 'branch': 'main' }

	" Icons for LSP menus/popups
	Plug 'onsails/lspkind.nvim'

	" Colorscheme.
	Plug 'jesse-kaufman/vim-glandix'

	" Improved syntax highlighting.
	Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}

	" Autocomplete menu handler.
	Plug 'hrsh7th/nvim-cmp'      " Autocomplete plugin.
	Plug 'hrsh7th/cmp-nvim-lsp'  " Autocomplete LSP items.
	Plug 'hrsh7th/cmp-buffer'    " Autocomplete buffer items.
	Plug 'hrsh7th/cmp-path'      " Autocomplete filesystem path items
	Plug 'hrsh7th/cmp-cmdline'   " Autocomplete VIM command line items
	Plug 'honza/vim-snippets'    " Autocomplete snippets
	Plug 'windwp/nvim-autopairs' " Autocomplete (), [], and {}
	Plug 'hrsh7th/cmp-nvim-lsp-signature-help' " Autocomplete signatures easily
	Plug 'quangnguyen30192/cmp-nvim-ultisnips' " Add autocomplete support for ultisnips

	" Required for UltiSnips in autocomplete menu
	Plug 'SirVer/ultisnips'

call plug#end()

" -------------------------- "
"      VIM CONFIGURATION     "
" -------------------------- "

set nocompatible        " Use Vim defaults (much better!)
set bs=indent,eol,start " allow backspacing over everything in insert mode
set showcmd             " show the command being typed
set pumheight=10        " popup menu height
set nomodeline          " don't allow config in file comments
set noshowmode          " don't show mode in status line
set filetype=on         " detect filetype
set number              " show line numbers
set scrolloff=5         " offset scroll from edge by 4 lines
set showmatch           " show matching (), [], {}, etc when typing
set whichwrap=          " nothing wraps
set termguicolors       " use full color
set nobackup            " no backups
set nowritebackup       " no backups
set signcolumn=number   " put diagnostic signs in number column to save space
set cursorline          " highlight current line
set timeoutlen=1000
set notimeout
let &showbreak='↪'      " wrap character
let mapleader = " "     " set leader to space
let g:tablineclosebutton=0 " hide close tab button
let g:UltiSnipsExpandTrigger="<c-tab>"

colorscheme glandix     " Set color scheme

" Make cursor blink
set guicursor+=a:blinkwait0-blinkoff400-blinkon250-Cursor/lCursor
" Make command/search use | cursor
set guicursor+=c:ver50

let g:loaded_python_provier=0
let g:loaded_ruby_provider = 0
let g:loaded_perl_provider = 0
let g:python_host_skip_check = 1
"let g:python_host_prog='/usr/bin/python2'
"let g:python3_host_prog='/usr/bin/python3'
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

" Disable indent lines if nolist is set
let g:indent_blankline_disable_with_nolist = v:true

let g:indent_blankline_use_treesitter = v:false



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

" Map alt/command backspace
inoremap <M-BS>  <C-W>
cnoremap <M-BS>  <C-W>

" Map F24 to space in normal mode (for leader key)
nmap <F24> <Space>

" Map Enter to space in normal mode (for leader key)
nmap <Enter> <Space>



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

" change quote from " to ' in normal mode
nmap <Leader>"'   cs'"
" change quote from ' to " in normal mode
nmap <Leader>'"   cs"'

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
" nnoremap <Tab> :tabnext<CR>
" nnoremap <S-Tab> :tabprevious<CR>
nnoremap <Leader><Tab> :tabnext<CR>
nnoremap <Leader><S-Tab> :tabprevious<CR>

" Make indent/outdent keep selection
vmap < <gv
vmap > >gv

" pgup/pgdn
nnoremap <PageUp> <C-u>
nnoremap <PageDown> <C-d>
inoremap <PageUp> <Esc><C-u>
inoremap <PageDown> <Esc><C-d>

" opt + left/right
noremap <A-Left> <S-Left>
noremap <A-Right> <S-Right>
cnoremap <A-Left> <S-Left>
cnoremap <A-Right> <S-Right>
inoremap <A-Left> <Esc><S-Left>
inoremap <A-Right> <Esc><S-Right>

" shift + opt + left/right
nnoremap <S-A-Right> E
nnoremap <S-A-Left> B
inoremap <S-A-Right> <Esc>W
inoremap <S-A-Left> <Esc>B

" home / end
noremap <C-A> <Home>
noremap <C-E> <End>
inoremap <C-A> <Esc><Home>
inoremap <C-E> <Esc><End>
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

augroup RestoreCursorShapeOnExit
    autocmd!
    autocmd VimLeave * set guicursor=a:hor20

		autocmd VimLeave * set guicursor+=a:blinkwait0-blinkoff400-blinkon250-Cursor/lCursor
augroup END

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
" --------------------------

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
lua require('user.init')
