" ===                           PLUGIN SETUP                               === "

" Get vim-plug
if empty(glob('~/.local/share/nvim/site/autoload/plug.vim'))
	silent !curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs
	      \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
	autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

" vim-plug plugins
call plug#begin('~/.vim/plugged')
Plug 'gruvbox-community/gruvbox'
Plug 'junegunn/goyo.vim'
Plug 'junegunn/limelight.vim'
Plug 'neoclide/coc.nvim', {'do': 'yarn install --frozen-lockfile'}
Plug 'neoclide/coc.nvim', {'do': { -> coc#util#install()}}
Plug 'junegunn/fzf', { 'dir': '~/.config/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'
Plug 'liuchengxu/vista.vim'
Plug 'scrooloose/nerdcommenter'
Plug 'itchyny/lightline.vim'
Plug 'tpope/vim-fugitive'
Plug 'Shougo/echodoc.vim'
call plug#end()

" == GOYO AND LIMELIGHT == "
" Goyo and Limelight integration
autocmd! User GoyoEnter Limelight
autocmd! User GoyoLeave Limelight!

" Set Limelight grey
let g:limelight_conceal_ctermfg = 243
 
" Set Goyo hotkey
nmap <silent> <leader>g :Goyo<CR>

" Start echodoc on startup & use floating windows
let g:echodoc_enable_at_startup = 1
let g:echodoc#type = 'floating'
highlight link EchoDocFloat Pmenu

" ===                           EDITING OPTIONS                            === "

" Disable shada 
set shada="NONE"

" General vim settings
set number          " Linenumbers
"set relativenumber  " Relative linenumbers 
syntax enable       " Syntax highlighting
set wildmenu        " Visual autocomplete for command menu
set showmatch       " Hightlight matching { } 
set clipboard=unnamedplus " Sets the clipboard to system clipboard
set smartindent     " 
set tabstop=4       " Number of visual spaces per tab
set softtabstop=4   " Number of spaces created when editing in a tab
set shiftwidth=4    
set expandtab       " Insert spaces when tab is pressed
set smarttab
set nowrap          " Dont wrap text
set scrolloff=8     " Screen boundary padding
set cmdheight=1     " Commandline height
"set termguicolors   " Enable true color support
set confirm         " Confirm before leaving unwritten buffer
colorscheme gruvbox "

" Map leader to space
nnoremap <space> <Nop>
map <space> <leader>

" Move lines up or down
nmap <leader>k :m .-2<CR>==
nmap <leader>j :m .+1<CR>==
vmap <leader>k :m-2<CR>gv=gv
vmap <leader>j :m'>+<CR>gv=gv

" Switch between buffers
nmap <silent> <leader>ä :bnext<CR>
nmap <silent> <leader>ö :bprev<CR>
nmap <silent> <leader>' :Buffers<CR>

" Vista sidebar settings
nmap <silent> å :Vista!!<CR>
let g:vista_sidebar_width = 30
let g:vista_close_on_jump = 1
let g:vista#renderer#enable_icon = 0

" Ripgrep search
map <leader>e :Rg<CR>
"map <leader>e :GFiles<CR>

" --- coc plugin config --- "
" if hidden is not set, TextEdit might fail.
set hidden   " Allows hiding buffers 

" coc has issues with backups
set nobackup
set nowritebackup

" Smaller updatetime for CursorHold & CursorHoldI
set updatetime=250

" don't give |ins-completion-menu| messages.
set shortmess+=c

" always show signcolumns
set signcolumn=yes

" Use tab for trigger completion with characters ahead and navigate.
" Use command ':verbose imap <tab>' to make sure tab is not mapped by other plugin.
inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" Use <c-space> for trigger completion.
inoremap <silent><expr> <c-space> coc#refresh()

" Use <cr> for confirm completion, `<C-g>u` means break undo chain at current position.
" Coc only does snippet and additional edit on confirm.
inoremap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"

" Use `[c` and `]c` for navigate diagnostics
nmap <silent> [c <Plug>(coc-diagnostic-prev)
nmap <silent> ]c <Plug>(coc-diagnostic-next)

" Remap keys for gotos
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" Use K for show documentation in preview window
nnoremap <silent> K :call <SID>show_documentation()<CR>

function! s:show_documentation()
  if &filetype == 'vim'
    execute 'h '.expand('<cword>')
  else
    call CocAction('doHover')
  endif
endfunction

" Highlight symbol under cursor on CursorHold
autocmd CursorHold * silent call CocActionAsync('highlight')

" Remap for rename current word
nmap <leader>r  <Plug>(coc-rename)

" Remap for format selected region
vmap <leader>f  <Plug>(coc-format-selected)
nmap <leader>f  <Plug>(coc-format-selected)

augroup mygroup
  autocmd!
  " Setup formatexpr specified filetype(s).
  autocmd FileType typescript,json setl formatexpr=CocAction('formatSelected')
  " Update signature help on jump placeholder
  autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
augroup end

" Remap for do codeAction of selected region, ex: `<leader>aap` for current paragraph
vmap <leader>a  <Plug>(coc-codeaction-selected)
nmap <leader>a  <Plug>(coc-codeaction-selected)

" Remap for do codeAction of current line
nmap <leader>ac  <Plug>(coc-codeaction)
" Fix autofix problem of current line
nmap <leader>qf  <Plug>(coc-fix-current)

" Use `:Format` for format current buffer
command! -nargs=0 Format :call CocAction('format')

" Use `:Fold` for fold current buffer
command! -nargs=? Fold :call     CocAction('fold', <f-args>)

" Using CocList
" Show all diagnostics
nnoremap <silent> <leader>z  :<C-u>CocList diagnostics<cr>
" Manage extensions
"nnoremap <silent> <leader>e  :<C-u>CocList extensions<cr>
" Show commands
"nnoremap <silent> <leader>c  :<C-u>CocList commands<cr>
" Find symbol of current document
nnoremap <silent> <leader>o  :<C-u>CocList outline<cr>
" Search workspace symbols
"nnoremap <silent> <leader>s  :<C-u>CocList -I symbols<cr>
" Do default action for next item.
"nnoremap <silent> <leader>j  :<C-u>CocNext<CR>
" Do default action for previous item.
"nnoremap <silent> <leader>k  :<C-u>CocPrev<CR>
" Resume latest coc list
"nnoremap <silent> <leader>p  :<C-u>CocListResume<CR>

" Lightline config
set noshowmode " Removes standard --INSERT-- 
let g:lightline = {
      \ 'colorscheme': 'gruvbox',
	  \ 'active': {
      \   'left': [ [ 'mode', 'paste' ],
      \             [ 'gitbranch', 'cocstatus', 'readonly', 'filename', 'modified'] ]
	  \ },
	  \ 'component_function': {
      \   'gitbranch': 'fugitive#head',
      \   'cocstatus': 'coc#status'
      \ },
      \ }
