" Get the defaults that most users want.
source $VIMRUNTIME/defaults.vim

"""""""""""""""""" Default options

syntax on
set hidden
set autoread
set number
set relativenumber
set cursorline
set termguicolors
set scrolloff=8            " keep context above/below the cursor
set sidescrolloff=8
set laststatus=2
set showcmd
set splitright splitbelow  " new splits open where you'd expect
set list listchars=tab:»\ ,trail:·,nbsp:␣   " show tabs and trailing spaces

set incsearch hlsearch
set ignorecase smartcase   " case-insensitive unless you type a capital
nnoremap <silent> <Esc><Esc> :nohlsearch<CR>

set expandtab shiftwidth=2 softtabstop=2 tabstop=8
set autoindent
autocmd FileType java setlocal shiftwidth=4 softtabstop=4

set wildmenu
set wildmode=longest:full,full
set wildoptions=pum,fuzzy  " popup menu + fuzzy matching for :e, :b, :find
set wildignore+=*/node_modules/*,*/.git/*,*/target/*,*/build/*,*/dist/*

set path+=**               " :find searches recursively from cwd
nnoremap <leader>f :find *
nnoremap <leader>b :buffer *

let s:undodir = expand('~/.vim/undo')
if !isdirectory(s:undodir) | call mkdir(s:undodir, 'p') | endif
let &undodir = s:undodir
set undofile

" :grep foo  → results in quickfix; open with :copen
nnoremap ]q :cnext<CR>
nnoremap [q :cprev<CR>

packadd! matchit           " % jumps between if/else/fi, HTML tags, etc.
silent! packadd comment    " gcc / gc{motion} to toggle comments (Vim 9.1+)
silent! packadd editorconfig  " respect .editorconfig in projects (Vim 9.0+)

colorscheme zaibatsu


"""""""""""""""""" Netrew

let g:netrw_liststyle = 3   " default listing style (the one 'i' cycles through)
let g:netrw_banner = 0      " hide the header/banner
let g:netrw_winsize = -35
let g:netrw_browse_split = 4
let g:netrw_keepdir = 1  " the working directory follows the directory you browse
let g:netrw_altv = 1     " vertical splits open on the right
let g:netrw_preview = 1        " `p` preview opens in a vertical split
let g:netrw_sizestyle = "H"    " human-readable file sizes (1K, 2M)
let g:netrw_bufsettings = 'noma nomod nu rnu nobl nowrap ro'  " line numbers in netrw

let g:netrw_decompress = {
        \ '.gz': 'gunzip', '.bz2': 'bunzip2', '.xz': 'unxz',
        \ '.zip': 'unzip', '.tar': 'tar -xf',
        \ '.zst': 'unzstd --rm', '.tgz': 'tar -zxf',
        \ }

augroup NetrwDrawer
      autocmd!
      " Open the drawer, then move the cursor back to the file window
      autocmd VimEnter * ++nested
        \ if argc() == 1 && isdirectory(argv(0)) |
        \   execute 'cd' fnameescape(argv(0)) |
        \   enew |
        \   Lexplore |
        \ else |
        \   Lexplore | wincmd p |
        \ endif      " Quit Vim if netrw is the only window left
      autocmd BufEnter * if winnr('$') == 1 && &filetype ==# 'netrw' | quit | endif
augroup END

function! s:SyncAllWindows(dir) abort
  for w in getwininfo()
    call win_execute(w.winid, 'noautocmd cd ' . fnameescape(a:dir))
  endfor
endfunction

augroup NetrwSyncCwd
  autocmd!
  autocmd DirChanged window
        \ if &filetype ==# 'netrw' | call s:SyncAllWindows(getcwd()) | endif
augroup END

" Toggle the drawer with a key
nnoremap <leader>e :Lexplore<CR>
" Open the drawer at the current file's directory
nnoremap <leader>E :Lexplore %:p:h<CR>

"""""""""""""""""" Linters

let g:ale_linter_aliases = {'bash': 'sh'}
let g:ale_linters = {
      \ 'sh': ['shellcheck'],
      \ 'dockerfile': ['hadolint']
      \ }
let g:ale_lint_on_text_changed = 'normal'   " lint after edits in normal mode, not on every keystroke
let g:ale_echo_msg_format = '[%linter%] %code: %%s'

" jump between problems
nmap <silent> [e <Plug>(ale_previous_wrap)
nmap <silent> ]e <Plug>(ale_next_wrap)

