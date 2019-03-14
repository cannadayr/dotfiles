"   DO NOT EDIT. This is an auto-generated file.
"   Created on Tue Mar  5 15:54:03 EST 2019
execute pathogen#infect()

syntax enable

" we need filetype plugins for vimwiki
filetype plugin on

" but it enables annoying autocomments, disable:
au FileType * setlocal formatoptions-=cro

set nocompatible
set expandtab
set tabstop=4
set shiftwidth=4
set textwidth=0
set modeline
set incsearch
set nonumber
set foldmethod=manual
set backspace=2        " fix weird newline backspace keyboard issue
set foldopen-=search
set hlsearch
set ignorecase

" how to use columnated text
" set wrap
" set tw=80
" [ select all the text and type ] gq


" how to use spellcheck
"setlocal spell spelllang=en_us
" use ]s and [s to mv between misspelled words
" use z= to get suggestions

" TODO set omnicomplete & dictionary complete
" http://vim.wikia.com/wiki/Dictionary_completions
"set omnifunc=syntaxcomplete#Complete
map <C-G>n :nohlsearch<CR>

" copy unfolded lines
map ;y :<BS><BS><BS><BS><BS>let @a='' \| '<,'>folddoopen normal "Ayy:let @0=@a

" tab shifting doesn't lose selection
noremap < <gv
noremap > >gv

" toggle case sensitivity
map ic :set ic<CR>
map nic :set noic<CR>

" cycle thru buffers
map <leader>n :bnext<CR>
map <leader>p :bprev<CR>

" toggle fold 'gutter' column that says foldlevel
map <leader>fc :set foldcolumn=1
map <leader>FC :set foldcolumn=0

" source current (vim) file
map <C-G>so :so %<CR>

" :w!!
" write the file when you accidentally opened it without the right (root) privileges
cmap w!! w !sudo tee % > /dev/null

"Plugins
"FoldSearch
map <leader>e :Fp 

"TBone
map <leader>y :Tyank<enter>
"#todo do we have custom version of Tbone for Tyankpart?
map <leader>z :Tyankpart^M

"Syntastic
map st :SyntasticToggleMode

" Make
" nmap ^Gm :!make

" organization & readme writing
"TODO test me
"map h yypV:s/./-/g:nohlsearch

set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*

let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0

" vim-gpg
" see: https://pig-monkey.com/2013/04/password-management-vim-gnupg/
" Tell the GnuPG plugin to armor new files.
let g:GPGPreferArmor=1

" Tell the GnuPG plugin to sign new files.
let g:GPGPreferSign=1

augroup GnuPGExtra
    " Set extra file options.
    autocmd BufReadCmd,FileReadCmd *.\(gpg\|asc\|pgp\) call SetGPGOptions()

    " Automatically close unmodified files after inactivity.
    autocmd CursorHold *.\(gpg\|asc\|pgp\) quit
augroup END

function MyFoldText()
    let line = getline(v:foldstart)
    let sub = substitute(line, '/\*\|\*/\|{{{\d\=', '', 'g')
    return v:folddashes . sub
endfunction

function SetGPGOptions()
    " Set the filetype for syntax highlighting.
    set filetype=gpgpass

    " Set updatetime to 1 minute.
    set updatetime=60000

    " Fold at markers.
    set foldmethod=marker

    " Automatically close all folds.
    set foldclose=all

    " Only open folds with insert commands.
    "set foldopen=all
    set foldopen+=search
    set foldtext=MyFoldText()
endfunction

" gpg helper mappings
" paste back out w/ ctrl-shift-insert
" this doesn't work great, possibly use awk?
nmap <leader>s /pass:<CR>f:w"+y$

" gen password
" TODO figure out how to insert at cursor w/ no newline
" tr -d '\n'
"map <leader>w :r!pwgen --no-capitalize --no-numerals --ambiguous 24 1<CR>
map <leader>w :r!pwgen -sy 24 1<CR>

" https://www.reddit.com/r/vim/comments/6hbsh8/zoom_window_tmux_style_zoom_pane_in_vim/
function! ZoomWindow()
    if winheight(0) >= (&lines - 4) && winwidth(0) >= (&columns - 2)
        exec "resize " . g:lastwh " | vertical resize ". g:lastww
    else
        let g:lastwh = winheight(0)
        let g:lastww = winwidth(0)
        wincmd _
        wincmd |
    endif
endfun
nnoremap <silent> <leader>z  :call ZoomWindow()<cr>
nnoremap <silent> <leader>=  <C-w>=

