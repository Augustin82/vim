let vimDir = $HOME.'/.vim'
let &runtimepath.=','.vimDir
set undolevels=1000
set undoreload=10000
" let $NVIM_TUI_ENABLE_CURSOR_SHAPE = 0
" Keep undo history across sessions by storing it in a file
if has('persistent_undo')
    let myUndoDir = expand(vimDir . '/undodir')
    " Create dirs
    call system('mkdir ' . vimDir)
    call system('mkdir ' . myUndoDir)
    let &undodir = myUndoDir
    set undofile
endif
if has('python3')
    let g:gundo_prefer_python3 = 1 " anything else breaks on Ubuntu 16.04+
endif
set nocompatible " be iMproved, required
set autoread
au CursorHold *.* checktime
set cursorline
set showcmd
set hidden
set list
set title
set modelines=0
set ruler
set wrap
" set textwidth=99
set formatoptions=qrn1
" set colorcolumn=105
set scrolloff=3
set ignorecase
set smartcase
set gdefault
set incsearch
set showmatch
set hlsearch
set visualbell
set number
set relativenumber
set noerrorbells
set noswapfile
set completeopt=longest,menuone
set backspace=indent,eol,start
set mouse=a
set clipboard+=unnamedplus
set foldmethod=indent
set nofoldenable
filetype off " required
set t_Co=256
set background=dark
set termguicolors
syntax enable
autocmd BufWinEnter * if line2byte(line("$") + 1) > 1000000 | syntax clear | endif
" always split windows vertically
set splitright
set splitbelow
set diffopt+=vertical
silent! set splitvertical
set tabstop=2 softtabstop=2 shiftwidth=2 noexpandtab
let mapleader=" "
inoremap jk <ESC>
vnoremap jk <ESC>
cnoremap jk <ESC>
onoremap jk <ESC>
set encoding=utf-8
set updatetime=250
nnoremap <tab> %
vnoremap <tab> %
vnoremap <tab> %
nnoremap <C-i> <C-I>
" duplicate line
" nmap <leader>d mzyyp`zgj
" use Enter to insert a blank line...
nmap <CR> ojk
" ...but still use Enter to navigate in the quickfix window
autocmd BufReadPost quickfix nnoremap <buffer> <CR> <CR>

" Visual Mode swapping
" To use this mapping: first, delete some text.
" Then, use visual mode to select some other text, and press Ctrl-X.
" The two pieces of text should then be swapped.
vnoremap <C-X> <Esc>`.``gvP``P

set path+=**
" autocommand to open files based on current suffix
augroup suffixes
    autocmd!

    let associations = [
                \["javascript", ".js,.javascript,.es,.esx,.json"],
                \["php", ".php,.twig"],
                \["elm", ".elm,.js"]
                \]

    for ft in associations
        execute "autocmd FileType " . ft[0] . " setlocal suffixesadd=" . ft[1]
    endfor
augroup END

" Install vim-plug if we don't already have it
if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

" Elm stuff
command! ElmExposeAllInModule normal gg$ci(..
noremap <Leader>ee :ElmExposeAllInModule<CR>:w<CR>

call plug#begin('~/.vim/plugged')

" Dockerfiles
Plug 'ekalinin/Dockerfile.vim'
autocmd BufRead,BufNewFile *.df set ft=Dockerfile

" Working with tags (HTML/JSX)
Plug 'tpope/vim-surround'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-ragtag'

" Misc
Plug 'vim-scripts/matchit.zip'
Plug 'tpope/vim-dispatch'
Plug 'tpope/vim-sleuth'
Plug 'tpope/vim-sensible'
Plug 'ConradIrwin/vim-bracketed-paste'

" Motions
Plug 'easymotion/vim-easymotion'
let g:EasyMotion_do_mapping = 0 " Disable default mappings
" Jump to anywhere you want with minimal keystrokes, with just one key binding.
" `s{char}{label}`
" nmap s <Plug>(easymotion-overwin-f)
" or
" `s{char}{char}{label}`
" Need one more keystroke, but on average, it may be more comfortable.
nmap <leader>g <Plug>(easymotion-overwin-f2)

" Turn on case insensitive feature
let g:EasyMotion_smartcase = 1
" JK motions: Line motions
map <Leader>j <Plug>(easymotion-j)
map <Leader>k <Plug>(easymotion-k)
Plug 'chaoren/vim-wordmotion'
let g:wordmotion_prefix = ','
Plug 'vim-scripts/ReplaceWithRegister'

" Snippets
" Plug 'MarcWeber/vim-addon-mw-utils'
" Plug 'tomtom/tlib_vim'
" Plug 'garbas/vim-snipmate'
" Plug 'honza/vim-snippets'

" Completion
"Plug 'ervandew/supertab'
"Plug 'Valloric/YouCompleteMe'

" make YCM compatible with SnipMate (using supertab)
"let g:ycm_key_list_select_completion = ['<C-n>', '<Down>']
"let g:ycm_key_list_previous_completion = ['<C-p>', '<Up>']
"let g:SuperTabDefaultCompletionType = '<C-n>'

" Undo
Plug 'simnalamburt/vim-mundo'
nnoremap <leader>u :MundoToggle<CR>
" Plug 'sjl/gundo.vim'
" nnoremap <leader>u :GundoToggle<CR>

" Git
" Plug 'tpope/vim-ugitive'
" Plug 'tpope/vim-git'
" Plug 'gitv'
Plug 'airblade/vim-gitgutter'

Plug 'ruanyl/coverage.vim'
let g:coverage_json_report_path = 'server/coverage/coverage-final.json'

" Files
Plug 'scrooloose/nerdtree'
let g:NERDTreeWinSize = 24
let g:NERDTreeMinimalUI = 1
let NERDTreeShowHidden=1
Plug 'jistr/vim-nerdtree-tabs'
map <Leader>n <plug>NERDTreeTabsToggle<CR>

Plug 'ctrlpvim/ctrlp.vim'
let g:ctrlp_cmd = 'CtrlP'
let g:ctrlp_map = '<Leader>p'
noremap <leader>b :CtrlPBuffer<CR>
noremap <leader>r :CtrlPMRU<CR>
noremap <leader>t :CtrlPTag<CR>
let g:ctrlp_match_window_bottom = 1
let g:ctrlp_match_window_reversed = 0
""let g:ctrlp_custom_ignore = '\v\~$|\.(o|swp|pyc|wav|mp3|ogg|blend)$|(^|[/\\])\.(hg|git|bzr)($|[/\\])|__init__\.py|node_modules'
let g:ctrlp_working_path_mode = 0
let g:ctrlp_dotfiles = 0
let g:ctrlp_switch_buffer = 0
let g:ctrlp_open_multiple_files = 'ij'
" nnoremap <leader>f :grep! -F <C-r>=expand('<cword>')<CR><CR>
Plug 'moll/vim-bbye'
"Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
"Plug 'junegunn/fzf.vim'
"let g:fzf_layout = { 'down': '~40%' }
"nnoremap <leader>p :Files<cr>
"nnoremap <leader>r :Buffers<cr>

" Search
if executable('rg')
  set grepprg=rg\ no-heading\ --vimgrep
  let g:ctrlp_user_command = 'rg %s --files --hidden -g ""'
  let g:ctrlp_use_caching = 0
endif
Plug 'mhinz/vim-grepper'
let g:grepper = {}
let g:grepper.tools = ['rg']
let g:grepper.prompt = 1
let g:grepper.highlight = 0
" remove ignore-case from defaults
let g:grepper.rg = { 'grepprg': 'rg --no-heading --vimgrep' }
" backslash for Grepper
" vmap gs <Plug>(GrepperOperator)
" nmap gs <Plug>(GrepperOperator)
" :Rg or double-backslash for Grepper command
command! -nargs=+ -bang -complete=file Rg GrepperRg <args>
" Leader+f prompts for search
nmap <leader>f :Rg<Space>-g<Space>"!tags"<Space>-i<Space>""<left>
" Leader+F searches word
nnoremap <leader>F :GrepperRg<Space>-g<Space>"!tags"<Space><cword><CR>

Plug 'brooth/far.vim'
if has('nvim')
    let g:far#source = 'rgnvim'
else
    let g:far#source = 'rg'
endif
let g:far#window_layout = 'current'
let g:far#preview_window_layout = 'right'
let g:far#file_mask_favorites = ['%', 'elm', 'php', 'html', 'json', 'js', 'twig']

Plug 'tpope/vim-abolish'

" Plug 'ironhouzi/vim-stim'
Plug 'osyo-manga/vim-anzu'
nmap n <Plug>(anzu-n-with-echo)
nmap N <Plug>(anzu-N-with-echo)
nmap * <Plug>(anzu-star-with-echo)
nmap # <Plug>(anzu-sharp-with-echo)
nmap <leader>/ :noh<CR><Plug>(anzu-clear-search-status)
Plug 'terryma/vim-multiple-cursors'

" Theme
Plug 'morhetz/gruvbox'
set shortmess+=c
hi def link jsObjectKey Identifier

" Syntax
Plug 'scrooloose/nerdcommenter'
" Add spaces after comment delimiters by default
let g:NERDSpaceDelims = 1
" Use compact syntax for prettified multi-line comments
let g:NERDCompactSexyComs = 1
" Align line-wise comment delimiters flush left instead of following code indentation
let g:NERDDefaultAlign = 'left'
" Allow commenting and inverting empty lines (useful when commenting a region)
let g:NERDCommentEmptyLines = 1
" Enable trimming of trailing whitespace when uncommenting
let g:NERDTrimTrailingWhitespace = 1

Plug 'jpalardy/vim-slime'
let g:slime_target = "neovim"
let g:slime_no_mappings = 1
xmap <c-s><c-s> <Plug>SlimeRegionSend
nmap <c-s><c-s> <Plug>SlimeParagraphSend
nmap <c-s>v     <Plug>SlimeConfig

Plug 'neoclide/coc.nvim', {'tag': '*', 'branch': 'release'}
set updatetime=300

" use tab and shift-tab to navigate the completion list
inoremap <silent><expr><Tab> pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <silent><expr><S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"
autocmd! CompleteDone * if pumvisible() == 0 | pclose | endif

" Do default action for next item.
" nnoremap <silent> <space>j  :<C-u>CocNext<CR>
" Do default action for previous item.
" nnoremap <silent> <space>k  :<C-u>CocPrev<CR>

" Remap for do codeAction of current line
nmap <leader>ac  <Plug>(coc-codeaction)
" Fix autofix problem of current line
nmap <leader>qf  <Plug>(coc-fix-current)<Paste>

" Remap for rename current word
nmap <leader>rn <Plug>(coc-rename)

" Use `[c` and `]c` to navigate diagnostics
nmap <silent> [c <Plug>(coc-diagnostic-prev)
nmap <silent> ]c <Plug>(coc-diagnostic-next)

" Remap keys for gotos
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" Use K to show documentation in preview window
nnoremap <silent> K :call <SID>show_documentation()<CR>

" Using CocList
" Show all diagnostics
nnoremap <silent> <space>ca  :<C-u>CocList diagnostics<cr>
" Manage extensions
nnoremap <silent> <space>ce  :<C-u>CocList extensions<cr>
" Show commands
nnoremap <silent> <space>cc  :<C-u>CocList commands<cr>
" Find symbol of current document
nnoremap <silent> <space>co  :<C-u>CocList outline<cr>
" Search workspace symbols
nnoremap <silent> <space>cs  :<C-u>CocList -I symbols<cr>
" Do default action for next item.
nnoremap <silent> <space>cj  :<C-u>CocNext<CR>
" Do default action for previous item.
nnoremap <silent> <space>ck  :<C-u>CocPrev<CR>
" Resume latest coc list
nnoremap <silent> <space>cp  :<C-u>CocListResume<CR>

" Plug 'flowtype/vim-flow'
" au BufNewFile,BufRead *.js.flow set filetype=javascript.jsx
"
" Plug 'elmcast/elm-vim'
" Plug 'dustinfarris/elm-vim', { 'branch': 'folding' }
Plug 'Zaptic/elm-vim'
" Plug 'andys8/vim-elm-syntax'
let g:polyglot_disabled = ['elm']
" let g:elm_detailed_complete = 1
" let g:elm_format_autosave = 1
" let g:elm_syntastic_show_warnings = 1
" let g:elm_make_show_warnings = 1
" Use Ctrl + V to ignore the remap
au FileType elm inoremap <buffer> $ <bar>><space>
au FileType elm inoremap <buffer> £ <<bar><space>
au FileType elm inoremap <buffer> ; -><space>

" go to the definition of the function under the cursoer
" Ilist is the ilist variant from romainl/vim-qlist
autocmd FileType elm nnoremap <buffer> <leader>] yiw:ilist ^\s*<c-r>"\s.*=$<cr>

" I add .elm at the end so Html.elm is not skipped when the directory Html/
" exists in the same directory...
function! GetElmFilenameFix(word)
  let l:word = a:word
  " replace module dots with slash
  let l:word = substitute(l:word,'\.','/','g') .'.elm'
  return l:word
endfunction
autocmd FileType elm setlocal includeexpr=GetElmFilenameFix(v:fname)

Plug 'sheerun/vim-polyglot'
let g:javascript_plugin_flow = 1
Plug 'mattn/emmet-vim', { 'for': ['html', 'javascript', 'javascript.jsx', 'html.twig', 'elm'] }
let g:user_emmet_settings = {
  \  'php' : {
  \    'extends' : 'html',
  \    'filters' : 'c',
  \  },
  \  'twig' : {
  \    'extends' : 'html',
  \  },
  \  'xml' : {
  \    'extends' : 'html',
  \  },
  \  'haml' : {
  \    'extends' : 'html',
  \  },
  \  'yaml' : {
  \    'extends' : 'html',
  \  },
  \}
Plug 'othree/es.next.syntax.vim', { 'for': ['javascript', 'javascript.jsx'] }
" Plug 'othree/javascript-libraries-syntax.vim'
" let g:used_javascript_libs = 'react,flux,underscore'
" Plug 'fleischie/vim-styled-components'
" Plug 'nelsyeung/twig.vim'
Plug 'arnaud-lb/vim-php-namespace'
let g:php_namespace_sort_after_insert = 1

Plug 'romainl/vim-qf'
nmap <leader>z <Plug>QfCprevious
nmap <leader>s <Plug>QfCnext
nmap ç <Plug>QfSwitch
nmap <F5> <Plug>QfCtoggle
nmap <F6> <Plug>QfLtoggle

" Test
" Plug 'janko-m/vim-test'
" inoremap <F12> , () => {<CR>});<Esc>O<Tab>
" let g:test#javascript#mocha#file_pattern = 'Spec\.js'
" let g:test#javascript#mocha#executable = './node_modules/.bin/mocha --opts spec/mocha.opts'

" Statusline
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
let g:airline_powerline_fonts = 1
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#fnamemod = ':p:.'
let g:airline#extensions#tabline#buffer_idx_mode = 1
let g:airline#extensions#tabline#buffer_nr_show = 0
let g:airline#extensions#tabline#formatter = 'unique_tail_improved'
let g:airline#extensions#syntastic#enabled = 1
let g:airline#extensions#branch#enabled = 1
let g:airline#extensions#hunks#enabled = 1
let g:airline_mode_map = {
    \ '__' : '__',
    \ 'n'  : 'N',
    \ 'i'  : 'I',
    \ 'R'  : 'R',
    \ 'c'  : 'C',
    \ 'v'  : 'V',
    \ 'V'  : 'VL',
    \ '' : 'VB',
    \ 's'  : 's',
    \ 'S'  : 'S',
    \ '' : '^S',
    \ }

" Ctags
Plug 'craigemery/vim-autotag'
Plug 'majutsushi/tagbar'
nmap <F8> :TagbarToggle<CR>
let g:tagbar_type_elm = {
  \ 'kinds' : [
      \ 'f:function:0:0',
      \ 'm:modules:0:0',
      \ 'i:imports:1:0',
      \ 't:types:1:0',
      \ 'a:type aliases:0:0',
      \ 'c:type constructors:0:0',
      \ 'p:ports:0:0',
      \ 's:functions:0:0',
  \ ]
\}

set tags+=tags,tags.vendors

" Format
Plug 'Yggdroot/indentLine'
" Plug 'thaerkh/vim-indentguides'
Plug 'editorconfig/editorconfig-vim'
Plug 'Raimondi/delimitMate'
Plug 'rstacruz/sparkup', {'rtp': 'vim/'}
Plug 'alvan/vim-closetag'
let g:closetag_filenames = "*.html, *.js, *.twig"
"
" " Whitespace
Plug 'vim-scripts/ShowTrailingWhitespace'
Plug 'vim-scripts/DeleteTrailingWhitespace'
let g:DeleteTrailingWhitespace = 1
let g:DeleteTrailingWhitespace_Action = 'delete'

" Match parens
Plug 'luochen1990/rainbow'
let g:rainbow_active = 0
nnoremap <leader>( :RainbowToggle<CR>

" Invisible characters
nmap <leader>l :set list!<CR>
set listchars=tab:▸\ ,eol:¬,trail:~,nbsp:¤,extends:>,precedes:<
set showbreak=↪
" Sessions
Plug 'mhinz/vim-startify'
function! s:sy_add_bookmark(bookmark)
  if !exists('g:startify_bookmarks')
    let g:startify_bookmarks = []
  endif
  let g:startify_bookmarks += [ a:bookmark ]
endfunction
command! -nargs=1 StartifyAddBookmark call <sid>sy_add_bookmark(<q-args>)

let g:startify_list_order = ['sessions', 'bookmarks', 'files', 'dir',
  \ 'commands']
let g:startify_bookmarks = []
let g:startify_session_autoload = 1
let g:startify_session_persistence = 1
let g:startify_change_to_vcs_root = 1
let g:startify_session_sort = 1
let g:startify_session_dir = '~/.vim/session'

filetype off
filetype plugin indent on                   " required!
call plug#end()

" Put your non-Plugin stuff after this line
nnoremap j gj
nnoremap k gk
nnoremap <C-J> :wincmd j<CR>
nnoremap <C-K> :wincmd k<CR>
nnoremap <C-L> :wincmd l<CR>
nnoremap <C-H> :wincmd h<CR>
nnoremap = <C-W>=
nnoremap - <C-W><
nnoremap + <C-W>>
noremap <C-PageUp> :bp<CR>
noremap <C-PageDown> :bn<CR>
nnoremap <C-C> :Bdelete<CR>
" nnoremap gfv :vertical wincmd f<CR>

let g:airline_section_c = '%{strftime("%Hh%M")}'
let g:airline_section_x = airline#section#create_right(['%l:%c (%P)'])
let g:airline_section_y = '%f'
let g:airline_section_z = ''
set autowriteall
au WinLeave,BufLeave,FocusLost * silent! wall

colorscheme gruvbox

