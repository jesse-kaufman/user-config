if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync
endif

call plug#begin("~/.vim/plugged")
	" Plugin Section
	Plug 'lukas-reineke/indent-blankline.nvim'
	Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
	Plug 'neoclide/coc.nvim', {'branch': 'release', 'do': 'yarn install --frozen-lockfile'}

	Plug 'vim-airline/vim-airline'
	Plug 'sheerun/vim-polyglot'
	Plug 'tpope/vim-commentary'
	Plug 'ap/vim-css-color'
	Plug 'editorconfig/editorconfig-vim'
	Plug 'rafi/awesome-vim-colorschemes'
	Plug 'pangloss/vim-javascript'
	Plug 'othree/html5.vim'
	Plug 'hlissner/vim-ultisnips-snippets'
	Plug 'jesse-kaufman/vim-glandix'

	let g:coc_global_extensions = [ 'coc-diagnostic', 'coc-css', 'coc-highlight', 'coc-html', 'coc-json', 'coc-prettier', 'coc-tsserver', 'coc-phpls', 'coc-syntax', 'coc-eslint', 'coc-snippets', '@yaegassy/coc-intelephense' ]
call plug#end()


"Config Section


set ts=5
set nocompatible    " Use Vim defaults (much better!)
set bs=indent,eol,start     " allow backspacing over everything in insert mode
set ruler       " show the cursor position all the time
let &showbreak = '» ' " wrap character
set showcmd " show the command being typed
set pumheight=10 " popup menu height
set nomodeline
set filetype=on
set number " show line numbers
set scrolloff=4
vmap < <gv
vmap > >gv
set showmatch
set noswapfile
set cmdheight=1
set whichwrap=


autocmd FileType scss setl iskeyword+=@-@


" Tab / Shift Tab to switch between tabs (:tabe <file>)
nnoremap <Tab> :tabnext<CR>
nnoremap <S-Tab> :tabprevious<CR>


colorscheme glandix

noremap <PageUp> <C-u>
noremap <PageDown> <C-d>
inoremap <PageUp> <C-o><C-u>
inoremap <PageDown> <C-o><C-d>
cnoremap <PageUp> <C-u>
cnoremap <PageDown> <C-d>

noremap <ESC>b b
noremap <ESC>f e
inoremap <ESC>b <C-o>b
inoremap <ESC>f <C-o>w
cnoremap <ESC>f e
noremap <S-M-Right> E
noremap <S-M-Left> B
inoremap <S-M-Right> <C-o>W
inoremap <S-M-Left> <C-o>B
cnoremap <S-M-Right> E
cnoremap <S-M-Left> B

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


let s:my_noCharsState=1

map Nc NC
" START NC
command! NC call MyToggleNoChars()
function! MyToggleNoChars()
	if s:my_noCharsState
  		set nonumber
  		set nolist
		set scl=no
		let &showbreak = ''
	else
		set number
		set list
		set scl=auto
		let &showbreak = '» '
	endif
	let s:my_noCharsState = !s:my_noCharsState
endfunction
" END NC

" Retab spaced file, but only indentation
command! Retab call RetabIndents()

" Retab spaced file, but only indentation
func! RetabIndents()
    let saved_view = winsaveview()
    execute '%s@^\( \{'.&ts.'}\)\+@\=repeat("\t", len(submatch(0))/'.&ts.')@'
    call winrestview(saved_view)
endfunc

" add a column limit line
if exists('+colorcolumn') && 0
  set colorcolumn=81
end

" statusline
set statusline=\ \|\ %t " tail of the filename
set statusline+=%m " modified flag
set statusline+=\ [%{strlen(&fenc)?&fenc.',':''} " file encoding
set statusline+=%{&ff}] " file format
set statusline+=\ %y " filetype
set statusline+=\ %r " read only flag
set statusline+=%= " left/right separator
set statusline+=%c " cursor column
set statusline+=\ %l/%L " cursor line/total lines
set statusline+=\ %p%% " percent through file


if 0
  set statusline= laststatus=0 ruler
  set rulerformat=%l,%c
  set rulerformat+=\ %m
  set rulerformat+=%=
  set rulerformat+=%p%%
end

" remember cursor position
if has("autocmd")
	autocmd BufReadPost * if line("'\"") > 0 && line("'\"") <= line("$") | exe "normal! g'\"" | endif
	autocmd BufRead,BufNewFile *.md,*.txt setlocal wrap " DO wrap on markdown files
endif

set list listchars=tab:▸\ ,nbsp:␣,eol:↴,space:·,extends:#,trail:@

let g:indent_blankline_show_current_context = v:true
let g:indent_blankline_show_current_context_start = v:false
let g:indent_blankline_show_trailing_blankline_indent = v:false
let g:indent_blankline_use_treesitter = v:true
let g:indent_blankline_show_end_of_line = v:false
let g:indent_blankline_disable_with_nolist = v:true
"let g:impact_transbg=v:true
"let g:colors_enable=v:true


"if !exists('g:loaded_color')
"  let g:loaded_color = 1
set termguicolors
set background=dark

"endif

if !exists('g:syntax_on')
  syntax on
endif


" Some servers have issues with backup files, see #649.
set nobackup
set nowritebackup

set updatetime=300

set signcolumn=number

" NOTE: Use command ':verbose imap <tab>' to make sure tab is not mapped by
" other plugin before putting this into your config.
" Make <CR> to accept selected completion item or notify coc.nvim to format
" <C-g>u breaks current undo, please make your own choice.
inoremap <silent><expr> <CR> coc#pum#visible() ? coc#pum#confirm() : "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"

" Use <c-space> to trigger completion.
if has('nvim')
  inoremap <silent><expr> <c-space> coc#refresh()
else
  inoremap <silent><expr> <c-@> coc#refresh()
endif

" Use `[g` and `]g` to navigate diagnostics
" Use `:CocDiagnostics` to get all diagnostics of current buffer in location list.
nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)

" GoTo code navigation.
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" Use K to show documentation in preview window.
nnoremap <silent> K :call ShowDocumentation()<CR>

function! ShowDocumentation()
  if CocAction('hasProvider', 'hover')
    call CocActionAsync('doHover')
  else
    call feedkeys('K', 'in')
  endif
endfunction

" Highlight the symbol and its references when holding the cursor.
autocmd CursorHold * silent call CocActionAsync('highlight')

" Symbol renaming.
nmap <leader>rn <Plug>(coc-rename)

" Formatting selected code.
xmap <leader>f  <Plug>(coc-format-selected)
nmap <leader>f  <Plug>(coc-format-selected)

augroup mygroup
  autocmd!
  " Setup formatexpr specified filetype(s).
  autocmd FileType typescript,json setl formatexpr=CocAction('formatSelected')
  " Update signature help on jump placeholder.
  autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
augroup end

" Applying codeAction to the selected region.
" Example: `<leader>aap` for current paragraph
xmap <leader>a  <Plug>(coc-codeaction-selected)
nmap <leader>a  <Plug>(coc-codeaction-selected)

" Remap keys for applying codeAction to the current buffer.
nmap <leader>ac  <Plug>(coc-codeaction)
" Apply AutoFix to problem on the current line.
nmap <leader>qf  <Plug>(coc-fix-current)

" Run the Code Lens action on the current line.
nmap <leader>cl  <Plug>(coc-codelens-action)

" Map function and class text objects
" NOTE: Requires 'textDocument.documentSymbol' support from the language server.
xmap if <Plug>(coc-funcobj-i)
omap if <Plug>(coc-funcobj-i)
xmap af <Plug>(coc-funcobj-a)
omap af <Plug>(coc-funcobj-a)
xmap ic <Plug>(coc-classobj-i)
omap ic <Plug>(coc-classobj-i)
xmap ac <Plug>(coc-classobj-a)
omap ac <Plug>(coc-classobj-a)

" Remap <C-f> and <C-b> for scroll float windows/popups.
if has('nvim-0.4.0') || has('patch-8.2.0750')
  nnoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? coc#float#scroll(1) : "\<C-f>"
  nnoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? coc#float#scroll(0) : "\<C-b>"
  inoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(1)\<cr>" : "\<Right>"
  inoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(0)\<cr>" : "\<Left>"
  vnoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? coc#float#scroll(1) : "\<C-f>"
  vnoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? coc#float#scroll(0) : "\<C-b>"
endif

" Use CTRL-S for selections ranges.
" Requires 'textDocument/selectionRange' support of language server.
nmap <silent> <C-s> <Plug>(coc-range-select)
xmap <silent> <C-s> <Plug>(coc-range-select)

" Add `:Format` command to format current buffer.
command! -nargs=0 Format :call CocActionAsync('format')

" Add `:Fold` command to fold current buffer.
command! -nargs=? Fold :call     CocAction('fold', <f-args>)

" Add `:OR` command for organize imports of the current buffer.
command! -nargs=0 OR   :call     CocActionAsync('runCommand', 'editor.action.organizeImport')

" Add (Neo)Vim's native statusline support.
" NOTE: Please see `:h coc-status` for integrations with external plugins that
" provide custom statusline: lightline.vim, vim-airline.
set statusline^=%{coc#status()}%{get(b:,'coc_current_function','')}

" Mappings for CoCList
" Show all diagnostics.
nnoremap <silent><nowait> <space>a  :<C-u>CocList diagnostics<cr>
" Manage extensions.
nnoremap <silent><nowait> <space>e  :<C-u>CocList extensions<cr>
" Show commands.
nnoremap <silent><nowait> <space>c  :<C-u>CocList commands<cr>
" Find symbol of current document.
nnoremap <silent><nowait> <space>o  :<C-u>CocList outline<cr>
" Search workspace symbols.
nnoremap <silent><nowait> <space>s  :<C-u>CocList -I symbols<cr>
" Do default action for next item.
nnoremap <silent><nowait> <space>j  :<C-u>CocNext<CR>
" Do default action for previous item.
nnoremap <silent><nowait> <space>k  :<C-u>CocPrev<CR>
" Resume latest coc list.
nnoremap <silent><nowait> <space>p  :<C-u>CocListResume<CR>
