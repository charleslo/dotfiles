set nocompatible
filetype off
call plug#begin()

" Misc
"Plug 'tpope/vim-unimpaired'

"Plug 'google/vim-maktaba'
"Plug 'google/vim-codefmt'
"Plug 'google/vim-glaive'

Plug 'junegunn/vim-easy-align'
Plug 'dpc/vim-smarttabs'
"
"" Aesthetic
Plug 'morhetz/gruvbox'
Plug 'rykka/riv.vim'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'

"" git
Plug 'tpope/vim-fugitive'
Plug 'airblade/vim-gitgutter'

"Plug 'ervandew/supertab'
"Plug 'SirVer/ultisnips'
"Plug 'honza/vim-snippets'

"" Programming
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'tpope/vim-surround'
Plug 'scrooloose/syntastic'

"" File Search
Plug 'junegunn/fzf.vim'
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }

"" Python Related
"Plug 'davidhalter/jedi-vim'
"Plug 'klen/python-mode'
"Plug 'python-rope/ropevim'
" rope?

" Writing
Plug 'charleslo/vim-markdown-preview'

" Files
Plug 'scrooloose/nerdtree'
Plug 'Xuyuanp/nerdtree-git-plugin'
call plug#end()

""""""""""""""""""""""""""""""""""""""""""""""""""
" General
""""""""""""""""""""""""""""""""""""""""""""""""""

filetype plugin indent on
set expandtab
set autoindent
set tabstop=2
set softtabstop=2
set shiftwidth=2
set showtabline=2
set number
set showmatch
set background=dark
syntax on

""""""""""""""""""""""""""""""""""""""""""""""""""
" Aesthetic
""""""""""""""""""""""""""""""""""""""""""""""""""

colorscheme gruvbox
let g:airline_theme='bubblegum'
set guifont="Inconsolata"

""""""""""""""""""""""""""""""""""""""""""""""""""
" Spelling
""""""""""""""""""""""""""""""""""""""""""""""""""

set spellfile=~/.vim/spellfile.add
setlocal spell spelllang=en_ca
set nospell
hi SpellBad cterm=underline ctermfg=red

set colorcolumn=80
highlight ColorColumn ctermbg=0 guibg=lightgrey

""""""""""""""""""""""""""""""""""""""""""""""""""
" Easy Align
""""""""""""""""""""""""""""""""""""""""""""""""""

xmap ga <Plug>(EasyAlign)
nmap ga <Plug>(EasyAlign)

""""""""""""""""""""""""""""""""""""""""""""""""""
" Search
""""""""""""""""""""""""""""""""""""""""""""""""""

set hlsearch
set noincsearch
set ignorecase

""""""""""""""""""""""""""""""""""""""""""""""""""
" Tabbing
""""""""""""""""""""""""""""""""""""""""""""""""""

nnoremap <silent> <C-n> :tabnext <CR>
nnoremap <silent> <C-p> :tabprevious <CR>
nmap <silent> <C-k> :silent noh <CR>


""""""""""""""""""""""""""""""""""""""""""""""""""
" Window status
""""""""""""""""""""""""""""""""""""""""""""""""""

set titlestring=%t%(\ %M%)%(\ (%{expand(\"%:p:h\")})%)%(\ %a%)\ -\ %{v:servername}
if &term == "screen-256color-bce"
  set t_ts=k
  set t_fs=\
endif
set title
set mouse=a
set laststatus=2

""""""""""""""""""""""""""""""""""""""""""""""""""
" clipboard
""""""""""""""""""""""""""""""""""""""""""""""""""

nnoremap y "+y
vnoremap y "+y
set clipboard=unnamedplus

""""""""""""""""""""""""""""""""""""""""""""""""""
" GitGutter
""""""""""""""""""""""""""""""""""""""""""""""""""

set updatetime=750
autocmd BufWritePost * GitGutter

""""""""""""""""""""""""""""""""""""""""""""""""""
" NERDTree
""""""""""""""""""""""""""""""""""""""""""""""""""

silent! nmap <F3> :NERDTreeToggle<CR>

""""""""""""""""""""""""""""""""""""""""""""""""""
" Syntastic
""""""""""""""""""""""""""""""""""""""""""""""""""

nnoremap <silent> <C-l> :SyntasticCheck <CR>
let g:syntastic_always_populate_loc_list = 1
let g:syntastic_mode_map = {
  \ "mode": "passive",
  \ "active_filetypes": [],
  \ "passive_filetypes": [] }
let g:syntastic_python_checkers = ['flake8', 'pylint']
"let g:syntastic_python_checkers = ['pylint', 'flake8']
"let g:syntastic_aggregate_errors = 1
"let g:syntastic_auto_loc_list = 1
let g:syntastic_filetype_map = {
    \ "systemverilog": "verilog"}

""""""""""""""""""""""""""""""""""""""""""""""""""
" coc
""""""""""""""""""""""""""""""""""""""""""""""""""

if has("patch-8.1.1564")
  " Recently vim can merge signcolumn and number column into one
  set signcolumn=number
else
  set signcolumn=yes
endif

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction


" Use <c-space> to trigger completion.
if has('nvim')
  inoremap <silent><expr> <c-space> coc#refresh()
else
  inoremap <silent><expr> <c-@> coc#refresh()
endif

" Use <cr> to confirm completion, `<C-g>u` means break undo chain at current
" position. Coc only does snippet and additional edit on confirm.
" <cr> could be remapped by other vim plugin, try `:verbose imap <CR>`.
if exists('*complete_info')
  inoremap <expr> <cr> complete_info()["selected"] != "-1" ? "\<C-y>" : "\<C-g>u\<CR>"
else
  inoremap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"
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
nnoremap <silent> K :call <SID>show_documentation()<CR>

function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  else
    call CocAction('doHover')
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

" Use CTRL-S for selections ranges.
" Requires 'textDocument/selectionRange' support of LS, ex: coc-tsserver
nmap <silent> <C-s> <Plug>(coc-range-select)
xmap <silent> <C-s> <Plug>(coc-range-select)

" Add `:Format` command to format current buffer.
command! -nargs=0 Format :call CocAction('format')

" Add `:Fold` command to fold current buffer.
command! -nargs=? Fold :call     CocAction('fold', <f-args>)

" Add `:OR` command for organize imports of the current buffer.
command! -nargs=0 OR   :call     CocAction('runCommand', 'editor.action.organizeImport')

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

""""""""""""""""""""""""""""""""""""""""""""""""""
" fzf
" https://dev.to/iggredible/how-to-search-faster-in-vim-with-fzf-vim-36ko
""""""""""""""""""""""""""""""""""""""""""""""""""

nnoremap <silent> <Leader>b :Buffers<CR>
nnoremap <silent> <C-f> :Files<CR>
nnoremap <silent> <Leader>f :Rg<CR>
nnoremap <silent> <Leader>/ :BLines<CR>
nnoremap <silent> <Leader>' :Marks<CR>
nnoremap <silent> <Leader>g :Commits<CR>
nnoremap <silent> <Leader>H :Helptags<CR>
nnoremap <silent> <Leader>hh :History<CR>
nnoremap <silent> <Leader>h: :History:<CR>
nnoremap <silent> <Leader>h/ :History/<CR> 
command! -bang -nargs=* Rg call fzf#vim#grep("rg --column --line-number --no-heading --color=always --smart-case ".shellescape(<q-args>), 1, {'options': '--delimiter : --nth 4..'}, <bang>0)

""""""""""""""""""""""""""""""""""""""""""""""""""
" Markdown Writing
""""""""""""""""""""""""""""""""""""""""""""""""""

" Set browser.link.open_newwindow.override.external;1
" Set .config/mimeapps.list to point to firefox
" let vim_markdown_preview_browser='Google Chrome'
"let vim_markdown_preview_pandoc=1
"let vim_markdown_preview_use_xdg_open=1
"let vim_markdown_preview_compile_hotkey='<C-l>'
"let vim_markdown_preview_hotkey='<s-l>'
 
" better key bindings for UltiSnipsExpandTrigger
"let g:UltiSnipsExpandTrigger="<tab>"
"let g:UltiSnipsJumpForwardTrigger="<tab>"
"let g:UltiSnipsJumpBackwardTrigger="<s-tab>"
"let g:vimwiki_table_mappings = 0

"let g:UltiSnipsSnippetDirectories = ['/home/charles/.vim/ultisnips']
"let g:UltiSnipsExpandTrigger="<c-h>"
"let g:UltiSnipsJumpForwardTrigger="<c-j>"
"let g:UltiSnipsJumpBackwardTrigger="<c-k>"

""""""""""""""""""""""""""""""""""""""""""""""""""
" vimtex
""""""""""""""""""""""""""""""""""""""""""""""""""
let g:tex_flavor='latex'
let g:vimtex_view_method='zathura'
let g:vimtex_fold_enable=0
let g:vimtex_quickfix_ignore_all_warnings=0 
let g:vimtex_quickfix_ignored_warnings = [ 'Underfull', 'Overfull', 'specifier changed to',] 
let g:vimtex_quickfix=2
let g:vimtex_quickfix_mode=0 
let g:tex_fast = "bMpr"
"set conceallevel=1
"let g:tex_conceal='abdmg'
let g:tex_conceal=""

""""""""""""""""""""""""""""""""""""""""""""""""""
" Retab
""""""""""""""""""""""""""""""""""""""""""""""""""

" Retab spaced file, but only indentation
command! RetabIndents call RetabIndents()

" Retab spaced file, but only indentation
func! RetabIndents()
		let saved_view = winsaveview()
		execute '%s@^\( \{'.&ts.'}\)\+@\=repeat("\t",len(submatch(0))/'.&ts.')@'
		call winrestview(saved_view)
endfunc
