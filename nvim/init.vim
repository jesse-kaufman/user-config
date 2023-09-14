scriptencoding uft-8

let data_dir = has('nvim') ? stdpath('data') : '~/.vim'
let config_dir = has('nvim') ? stdpath('config') : '~/.vim'

augroup VimPlug
    autocmd!
    if empty(glob(config_dir . '/autoload/plug.vim'))
        silent execute '!curl -fLo '.config_dir.'/autoload/plug.vim --create-dirs  https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
        autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
    endif
augroup END

call plug#begin('~/.vim/plugged')

    " Plugin Section
    Plug 'godlygeek/tabular'
    Plug 'preservim/vim-markdown'

    " Colorscheme.
    Plug 'jesse-kaufman/vim-glandix'

    " Show context/indent lines.
    Plug 'lukas-reineke/indent-blankline.nvim'

    " Custom status line.
    Plug 'nvim-lualine/lualine.nvim'

    " Surround text with quotes/tags/etc.
    Plug 'tpope/vim-surround'

    " Toggle comments quickly
    Plug 'tpope/vim-commentary'

    " Repeat more things (like toggle comments)
    Plug 'tpope/vim-repeat'

    " Highlighting/indent support
    " Plug 'pangloss/vim-javascript'    " JavaScript
    " Plug 'othree/html5.vim'           " HTML5
    " Plug '2072/PHP-Indenting-for-VIm' " PHP
    " Plug 'StanAngeloff/php.vim'         " PHP
    " Plug 'lepture/vim-jinja'
    " Plug 'chase/vim-ansible-yaml'
    Plug 'pearofducks/ansible-vim'

    Plug 'nvim-lua/lsp-status.nvim'

    " Add devicons
    Plug 'nvim-tree/nvim-web-devicons'

    " Advanced syntax highlighting.
    Plug 'sheerun/vim-polyglot'

    " Show colors in code.
    Plug 'ap/vim-css-color'

    " Better GIT commit message screen
    Plug 'rhysd/committia.vim'

    " Better colorcolumn.
    Plug 'xiyaowong/virtcolumn.nvim'

    " Icons for LSP menus/popups
    Plug 'onsails/lspkind.nvim'

    " Improved syntax highlighting.
    Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}

    " Autocomplete plugins
    Plug 'hrsh7th/cmp-nvim-lsp'                " Autocomplete LSP items.
    Plug 'hrsh7th/cmp-buffer'                  " Autocomplete buffer items.
    Plug 'hrsh7th/cmp-path'                    " Autocomplete filesystem path items
    Plug 'hrsh7th/cmp-cmdline'                 " Autocomplete VIM command line items
    Plug 'hrsh7th/cmp-nvim-lsp-signature-help' " Autocomplete signatures easily
    Plug 'SirVer/ultisnips'                    " UltiSnips snippets
    Plug 'quangnguyen30192/cmp-nvim-ultisnips' " Add autocomplete support for ultisnips
    Plug 'honza/vim-snippets'                  " Autocomplete snippets
    Plug 'windwp/nvim-autopairs'               " Autocomplete (), [], and {}
    Plug 'hrsh7th/nvim-cmp'                    " Autocomplete plugin.

    Plug 'kevinhwang91/nvim-hlslens'  " Show better info when searching

    "
    " LSP / Diagnostics
    "

    " Required by null-ls
    Plug 'nvim-lua/plenary.nvim'

    " Use Mason for handling installing/loading language server support.
    Plug 'williamboman/mason.nvim'
    Plug 'williamboman/mason-lspconfig.nvim'
    " LSP configuration helpers -- must load after Mason.
    Plug 'neovim/nvim-lspconfig'
    " Use null-ls for external linters
    Plug 'jose-elias-alvarez/null-ls.nvim'
    " Integrate null-ls with Mason
    Plug 'jay-babu/mason-null-ls.nvim'


    " Add LSP progress to lualine
    Plug 'WhoIsSethDaniel/lualine-lsp-progress.nvim'

    " Improved LSP interface.
    Plug 'folke/trouble.nvim'

    Plug 'Maan2003/lsp_lines.nvim'
    Plug 'WhoIsSethDaniel/toggle-lsp-diagnostics.nvim'
    Plug 'j-hui/fidget.nvim', { 'tag': 'legacy' }
call plug#end()

colorscheme glandix     " Set color scheme

" -------------------------- "
"      VIM CONFIGURATION     "
" -------------------------- "

set nocompatible        " Use Vim defaults (much better!)
set backspace=indent,eol,start " allow backspacing over everything in insert mode
set showcmd             " show the command being typed
set pumheight=12        " popup menu height
set nomodeline          " don't allow config in file comments
set noshowmode          " don't show mode in status line
set formatoptions+=c    " auto-wrap comments
set formatoptions+=r    " insert comment leader on enter in insert mode
set formatoptions-=o    " do not insert comment leader on 'o'/'O' in normal mode
set formatoptions+=q    " allow formatting of comments with "gq"
set formatoptions+=w    " trailing whitespace indicates paragraph continues
set formatoptions+=n    " recognize numbered lists
set formatoptions+=1    " do not break after 1-character words
set formatoptions+=l    " if line is longer before insert, don't reformat during insert
set formatoptions+=b    " only break line you have entered during current insert
set formatoptions+=j    " remove comment leader when joining comment lines

" set nowildmenu

set number              " show line numbers
set scrolloff=5         " offset scroll from edge by 4 lines
set showmatch           " show matching (), [], {}, etc when typing
set whichwrap=          " nothing wraps
set termguicolors       " use full color
set nobackup            " no backups
set nowritebackup       " no backups
" set noautoread          " don't read changed files
set signcolumn=yes:1    " 1-char sign column
set cursorline          " highlight current line
" set timeoutlen=1000
set notimeout           " don't timeout on leader key

setlocal autoindent
setlocal smartindent



" set color column to [textwidth], 80, and 120 by default
let g:my_colorcolumn='+0,80,120'
let g:is_bash=1
let g:sh_no_error= 1
execute 'setlocal colorcolumn=' . g:my_colorcolumn

let &showbreak='↪'      " wrap character
let g:mapleader=' '       " set leader to space
let g:tablineclosebutton=0 " hide close tab button

let g:vim_markdown_folding_disabled = 1



set laststatus=2

" Make cursor blink
set guicursor+=a:blinkwait0-blinkoff400-blinkon250-Cursor/lCursor
" Make command/search use | cursor
set guicursor+=c:ver50

" UltiSnips Configuration
let g:UltiSnipsSnippetDirectories=[data_dir.'/plugged/vim-snippets/UltiSnips',config_dir.'/ultisnips']
let g:UltiSnipsJumpForwardTrigger='<Tab>' " Alt+Tab
let g:UltiSnipsJumpBackwardTrigger='<S-Tab>' " Alt+Shift+Tab
"let g:UltiSnipsExpandTrigger='<A-Tab>'
let g:UltiSnipsListSnippets='<A-Tab>'

" If you want :UltiSnipsEdit to split your window.
let g:UltiSnipsEditSplit='vertical'

let g:loaded_python_provier=0
let g:loaded_ruby_provider = 0
let g:loaded_perl_provider = 0

let g:highlightedyank_highlight_duration = 1000

let g:php_html_load = 1


set list listchars=tab:‣\ ,nbsp:␣
set list listchars+=eol:¬
set list listchars+=space:·
set list listchars+=trail:
set list listchars+=precedes:
set list listchars+=extends:

augroup FixPhp
    autocmd!
    autocmd BufRead,BufNewFile   *.php set commentstring=//\ %s
augroup END

" let g:committia_min_window_width = 100
let g:committia_edit_window_width = 72
let g:committia_use_singlecolumn = 'always'

let g:committia_hooks = {}
function! g:committia_hooks.edit_open(info)
    setlocal spell

    " If no commit message, start with insert mode
    if a:info.vcs ==# 'git' && getline(1) ==# ''
        startinsert
    endif

    setlocal nonumber
    setlocal nolist
    setlocal signcolumn=no

    setlocal textwidth=72
    let g:my_colorcolumn='50,+0'
    execute 'setlocal colorcolumn=' . g:my_colorcolumn

    " Scroll the diff window from insert mode
    " Map <C-n> and <C-p>
    imap <buffer><PageDown> <Plug>(committia-scroll-diff-down-half)
    imap <buffer><PageUp> <Plug>(committia-scroll-diff-up-half)
endfunction



function! g:committia_hooks.diff_open(info)
    setlocal winhighlight=Normal:glxLtGrayFG
endfunction


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
"          NEOVIDE           "
" -------------------------- "
if exists('g:neovide')
    set guifont=Hack\ Nerd\ Font:h16:#h-none
    let g:neovide_transparency = 0.95
    " let g:transparency = 0.8
    " let g:neovide_background_color = '#151515'.printf('%x', float2nr(255 * g:transparency))
    let g:neovide_floating_blur_amount_x = 60.0

    let g:neovide_floating_blur_amount_y = 30.0
    let g:neovide_cursor_trail_size = 0.3
    let g:neovide_cursor_animation_length=0.05
    let g:neovide_input_macos_alt_is_meta = v:true
    let g:neovide_cursor_unfocused_outline_width = 0.05

    let g:neovide_cursor_vfx_mode = 'ripple'
    let g:neovide_remember_window_size = v:false
    let g:neovide_underline_automatic_scaling = v:true


    inoremap <D-v> <C-R>*
    execute 'highlight Normal guibg=' . g:glx_c_black

    let g:neovide_underline_automatic_scaling = v:false
    let g:neovide_input_use_logo = v:true  " v:true on macOS
endif



" -------------------------- "
"    NUMBER COLUMN SIGNS     "
" -------------------------- "
sign define LspSagaLightBulb text=󰌵 texthl=LspSagaLightBulb
sign define DiagnosticSignError text=  texthl=DiagnosticSignError
sign define DiagnosticSignWarn text=  texthl=DiagnosticSignWarn
sign define DiagnosticSignInfo text=  texthl=DiagnosticSignInfo
sign define DiagnosticSignHint text=󰌵  texthl=DiagnosticSignHint



" -------------------------- "
"        KEY MAPPINGS        "
" -------------------------- "

" Map alt/command backspace
inoremap <M-BS>  <C-W>
cnoremap <M-BS>  <C-W>

" Map F24 to ^w (for window controls)
nmap <F24> <C-W>

" ====================================
" LEADERS COMMANDS
" ====================================

" toggle comments
map <Leader>c gcc

" Make <Leader>n toggle extra characters so copying text highlighted with the
" mouse in terminal makes sense
map <Leader>n :call ToggleNoChars()<cr>

" Tab / Shift Tab to switch between tabs (:tabe <file>)
" nnoremap <Tab> :tabnext<CR>
" nnoremap <S-Tab> :tabprevious<CR>
nnoremap <Leader><Tab> :tabnext<CR>
nnoremap <Leader><S-Tab> :tabprevious<CR>
nnoremap <Leader>t :tabnew<CR>:Explore<CR>
nnoremap <Leader>o :tabnew<CR>:Explore<CR>
nnoremap <Leader>e :Explore<CR>
" Make surround easier to use

" change quote from " to ' in normal mode
nmap <Leader>""'   cs"'
" change quote from ' to " in normal mode
nmap <Leader>'""   cs'"
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

autocmd TextYankPost * silent! lua vim.highlight.on_yank {higroup="YankHighlight", timeout=250}

augroup RestoreCursorShapeOnExit
    autocmd!
    autocmd VimLeave * set guicursor=a:hor20

    autocmd VimLeave * set guicursor+=a:blinkwait0-blinkoff400-blinkon250-Cursor/lCursor
    " remember cursor position
    autocmd BufReadPost * if line("'\"") > 0 && line("'\"") <= line("$") | exe "normal! g'\"" | endif
augroup END

function! DisableMatchesOnFloat()
    call clearmatches()
endfunction

augroup DisableMatchesOnFloatGroup
    autocmd!
    autocmd User FloatPreviewWinOpen call DisableMatchesOnFloat()
augroup END

function! DisableExtrasOnFloats()
    call nvim_win_set_option(g:float_preview#win, 'cursorline', v:false)
    call nvim_win_set_option(g:float_preview#win, 'textwidth', '0')
endfunctio

augroup DisableExtrasGroup
    autocmd User FloatPreviewWinOpen call DisableExtrasOnFloats()
augroup END


augroup ResizeWindowGroup
    autocmd!
    " Automatically equalize splits when resizing window
    autocmd VimResized * wincmd =
augroup END


" --------------------------
"          FUNCTIONS
" --------------------------


" Toggle showing extra characters and number/sign column with :NC
let s:my_noCharsState=1
function! ToggleNoChars()
    if s:my_noCharsState
        set nonumber
        setlocal nolist
        set signcolumn=no
        set colorcolumn=0
        let &showbreak = ''
        call clearmatches()
        lua require('toggle_lsp_diagnostics').turn_off_diagnostics()
        lua require('trouble').close()
        set nohlsearch
    else
        set number
        set list
        setlocal signcolumn=yes:1
        let &showbreak = '↪'
        lua require('user.config.trouble').show_trouble()
        set hlsearch
    endif
    let s:my_noCharsState = !s:my_noCharsState
endfunction

" Retab spaced file, but only indentation
command! Retab call RetabIndents()
func! RetabIndents()
    let saved_view = winsaveview()
    execute '%s@^\( \{'.&tabstop.'}\)\+@\=repeat("\t", len(submatch(0))/'.&tabstop.')@'
    call winrestview(saved_view)
endfunc

function! ColorizeHiFile()
    let i = 1
    while i <= line('$')
        if strlen(getline(i)) > 0 && len(split(getline(i))) > 2
            let w = split(getline(i))[0]
            exe 'syn match ' . w . " /\\(" . w . "\\s\\+\\)\\@<=xxx/"
        endif
        let i += 1
    endwhile
endfunction

function! GetHiGroup()
    let l:s = synID(line('.'), col('.'), 1)
    echo synIDattr(l:s, 'name') . ' -> ' . synIDattr(synIDtrans(l:s), 'name')
endfun


" Statusline
function! LspStatus() abort
  if luaeval('#vim.lsp.buf_get_clients() > 0')
    return luaeval("require('lsp-status').status()")
  endif

  return ''
endfunction

" Use yaml.jinja2 syntax for yaml files (from ansible-vim plugin)
augroup yaml_ft
  au!
  autocmd BufNewFile,BufRead *.yaml   set syntax=yaml.jinja2
augroup END


" -------------------------- "
"     REQUIRED LUA FILES     "
" -------------------------- "
lua require('user.init')
