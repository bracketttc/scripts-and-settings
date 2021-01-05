" Vimrc - Jesse Bassett
" 1.0.1 - 2019-03-06

" A path to a user-controlled vimrc that is source at the end of this file
let uservimrc = expand($HOME . "/.vim/vimrc")

" General {{{
" Sets how many lines of history VIM has to remember
set history=700

" Enable filetype plugin
filetype plugin on
filetype indent on

" Backups {{{
" Write backup files to these directories
set backupdir=~/.vim/backup,~/.tmp,~/tmp,/var/tmp,/tmp
" Skip creating backups when editing files in these directories
set backupskip=/tmp/* 
" Write swap files to these directories
set directory=~/.vim/swap,~/.tmp,~/tmp,/var/tmp,/tmp
" Make a backup before overwriting a file
set writebackup
"}}}

" Set to auto read when a file is changed from the outside
set autoread

" With a map leader it's possible to do extra key combinations
" like <leader>w saves the current file
let mapleader = ","
let g:mapleader = ","


" Fast saving
nmap <leader>w :w!<cr>

" Fast editing of the .vimrc
map <leader>e :e! ~/.vimrc<cr>
" Fast editing of the user vimrc
" It looks funky because of how variables are interpolated via map
execute 'map <leader>eu :e! ' . uservimrc . '<cr>'

" When a vimrc is edited, reload it
autocmd! bufwritepost vimrc source ~/.vimrc

" Statusline {{{
set statusline=
set statusline+=%-.100F\  
set statusline+=[%{strlen(&fenc)?&fenc:'none'},%{&ff}]
set statusline+=%h%m%r%y%=[%03.b]%3.c,%l/%L\ %P

set statusline=   " clear the statusline for when vimrc is reloaded
set statusline+=%-3.3n\                      " buffer number
set statusline+=%f\                          " file name
set statusline+=%h%m%r%w                     " flags
set statusline+=[%{strlen(&ft)?&ft:'none'},  " filetype
set statusline+=%{strlen(&fenc)?&fenc:&enc}, " encoding
set statusline+=%{&fileformat}]              " file format
set statusline+=%=                           " right align
set statusline+=%{synIDattr(synID(line('.'),col('.'),1),'name')}\  " highlight
set statusline+=%3.b,0x%-8B\                 " current char
set statusline+=%-14.(%l,%c%V%)\ %<%P        " offset
set laststatus=2
"}}}

" Enable mouse support
map <leader>a :set mouse=a<cr>


" }}}
" Movement {{{

" In visual, j and k go up and down by _visual_ line, not by file line number
nnoremap j gj
nnoremap k gk

noremap   <buffer>  <silent>  <Up>    gk
noremap   <buffer>  <silent>  <Down>  gj
noremap   <buffer>  <silent>  <Home>  g<Home>
noremap   <buffer>  <silent>  <End>   g<End>
inoremap  <buffer>  <silent>  <Up>    <C-o>gk
inoremap  <buffer>  <silent>  <Down>  <C-o>gj
inoremap  <buffer>  <silent>  <Home>  <C-o>g<Home>
inoremap  <buffer>  <silent>  <End>   <C-o>g<End>

nnoremap gV `[v'`]

" }}}
" VIM user interface {{{
" Set 7 lines to the curors - when moving vertical..
set so=7

" Turn on WiLd menu, and exclude compiled objects
set wildmenu
set wildmode=list:longest,full

" Build the wildignore menu
set wildignore+=.git,.git/* " Git
set wildignore+=*.o,*.obj,*.so,*.so* " C/C++ 
set wildignore+=*.dll,*.om,*.exe " Windows
set wildignore+=*.bak,~* " Linux
set wildignore+=*.pyc,*.pyo " Python
set wildignore+=*.jpg,*.gif,*.png " Images
set wildignore+=*.class " Java

set ruler "Always show current position

set cmdheight=2 "The commandbar height

" When closing a buffer, it becomes hidden, not unloaded
set hid


set number " Line numbers on by default
" Toggle line numbers
map <leader>n :setlocal nu!<cr>
" Toggle relative line numbers
map <leader>r :setlocal rnu!<cr>

" Toggle cursor line
set nocursorline
map <leader>c :set cursorline!<cr>

" Set backspace config
set backspace=eol,start,indent
set whichwrap+=<,>,h,l

" Searching {{{
set ignorecase "Ignore case when searching
set smartcase

set hlsearch "Highlight search things
set incsearch "Make search act like search in modern browsers

" Clear highlights in all buffers
map <leader><space> :noh<cr>
" }}}

set lazyredraw "Don't redraw while executing macros 

set magic "Set magic on, for regular expressions

set showmatch "Show matching braces when text indicator is over them
set mat=2 "How many tenths of a second to blink

" No sound on errors
set noerrorbells
set novisualbell
set t_vb=

" Wait 500ms for a command sequence (e.g. <leader> commands) to complete
set timeoutlen=500

""" Folding
if !has("compatible")
    set foldenable
    set foldlevelstart=10
    set foldnestmax=10
    set foldmethod=syntax
endif

" Fold and unfold with spacebar !!!
nnoremap <space> za

" }}}
" Colors and Fonts {{{

" Enable syntax highlighting
syntax enable

" For me, the background is dark
set background=dark

" GUIs have a different set of options 
if has("gui_running")
  " Remove the toolbar
  " set guioptions-=T

  " Different colorscheme, to tell the difference between gvim and vim
  colorscheme koehler

  " Wider and bigger
  set columns=120
  set lines=50

  " Hide the mouse when using GVim
  set mousehide
else
    " Best colorscheme for dark backgrounds with syntax highlighting
    colorscheme elflord
endif

" UTF-8
set encoding=utf8
" Set lang if not already set
try
    lang en_US
catch
endtry

" File types to save as
set ffs=unix,dos,mac

" }}}
" Text, tab and indent related {{{
set expandtab
set shiftwidth=4
set softtabstop=4
set tabstop=4
set smarttab
set shiftround
set infercase

" Unless specified by a filetype plugin, no automatic text wrapping
set tw=0

" Color the textwidth line
set cc=+0

set ai "Auto indent
set si "Smart indent
set wrap "Wrap lines

" Listing and linebreaking are incompatible.
" The default behavior is now to list instead of linebreak,
" but it can be toggled by setting the values below
" set linebreak " Wrap lines at linebreaks
" set nolist " Disable listing, because that disables linebreak
set nolinebreak
set list

" Toggle listing
map <leader>l :set list!<cr>

set listchars= " Clear default listchars
set listchars+=tab:>- " Show tab characters
set listchars+=trail:- " Highlight trailing spaces
set listchars+=extends:> "  Indicate a line goes off to the right
set listchars+=precedes:< " Indicate a line goes off to the left
if has("gui")
    inoremap <C-Space> <C-n>
else
    if has("unix")
        inoremap <Nul> <C-n>
    else
        "eh?
    endif
endif

" Highlight characters after column 78 in text documents
"au BufWinEnter *.txt let w:m1=matchadd('Search', '\%79v.', -1)
"au BufWinEnter *.txt let w:m2=matchadd('ErrorMsg', '\%>120v.\+', -1)
au BufWinEnter *.tex set nowrap


" }}}
" Spell checking {{{
" Rebind the spelling commands to <leader>s, because the 'z' is also
" used for folding.

"Pressing ,ss will toggle and untoggle spell checking
map <leader>ss :setlocal spell!<cr>

""" Shortcuts using <leader>
" Next and previous spelling error
map <leader>sn ]s
map <leader>sp [s

" Add or remove word to dictionary
map <leader>sa zg
map <leader>sA zug

" Mark or unmark a word as bad in a dictionary
map <leader>sb zw
map <leader>sB zuw

" Show possible corrections
map <leader>s/ z=
map <leader>s? z=
map <leader>s= z=


" }}}
" Functions {{{
" Any defined vim functions should be placed here

" from https://dougblack.io/words/a-good-vimrc.html#organization
" strips trailing whitespace at the end of files. this
" is called on buffer write in the autogroups below.
function! <SID>StripTrailingWhitespaces()
    " save last search & cursor position
    let _s=@/
    let l = line(".")
    let c = col(".")
    %s/\s\+$//e
    let @/=_s
    call cursor(l, c)
endfunction


" From http://vim.wikia.com/wiki/Display_output_of_shell_commands_in_new_window
" Run a command with ':Shell ls -al' and get the output in a new window
command! -complete=shellcmd -nargs=+ Shell call s:RunShellCommand(<q-args>)
function! s:RunShellCommand(cmdline)
    echo a:cmdline
    let expanded_cmdline = a:cmdline
    for part in split(a:cmdline, ' ')
        if part[0] =~ '\v[%#<]'
            let expanded_part = fnameescape(expand(part))
            let expanded_cmdline = substitute(expanded_cmdline, part, expanded_part, '')
        endif
    endfor
    botright new
    setlocal buftype=nofile bufhidden=wipe nobuflisted noswapfile nowrap
    call setline(1, 'You entered:    ' . a:cmdline)
    call setline(2, 'Expanded Form:  ' .expanded_cmdline)
    call setline(3,substitute(getline(2),'.','=','g'))
    execute '$read !'. expanded_cmdline
    setlocal nomodifiable
    1
endfunction

" Also from http://vim.wikia.com/wiki/Display_output_of_shell_commands_in_new_window
" Run git commands and get the output in a scratch window with ':Git status'
command! -complete=file -nargs=* Git call s:RunShellCommand('git '.<q-args>)
" }}}
" Filetypes {{{
" Assorted specific settings for particular filetypes
" Python section {{{
let python_highlight_all = 1
augroup pythongroup
    autocmd!

    " Extra syntax highlighting for some keywords
    au FileType python syn keyword pythonDecorator True None False self

    " Substitue $<patterns> with python code ($d is great!)
    au FileType python inoremap # X#
    au FileType python inoremap <buffer> $r return
    au FileType python inoremap <buffer> $i import
    au FileType python inoremap <buffer> $p print
    au FileType python inoremap <buffer> $d import pdb; pdb.set_trace()

    " Some quick search functions
    " Find next class
    au FileType python map <buffer> <leader>1 /class
    " Find next function
    au FileType python map <buffer> <leader>2 /def
    " Find previous class
    au FileType python map <buffer> <leader>C ?class
    " Find previous function
    au FileType python map <buffer> <leader>D ?def

    " Set the foldmethod to indent
    au FileType python set foldmethod=indent

    " On save, strip trailing whitespace
    au FileType python au BufWritePre <buffer> :call <SID>StripTrailingWhitespaces()
augroup END

" }}}
" Perl section {{{
augroup perlgroup
    autocmd!
    au FileType perl set showmatch
    " Run :make to see syntax errors
    au FileType perl set makeprg=*.pl\ -cT\ %\ $*
    " Error formatting for the :make command
    au FileType perl set errorformat=%f:%l:%m
    au FileType perl set autowrite
    au FileType perl set number
augroup END

let perl_include_pod = 1

let perl_extended_vars = 1
" }}}
" Markdown {{{
augroup markdown
    autocmd!
    au BufRead,BufNewFile *.md set filetype=markdown
    au FileType markdown set tw=0
augroup END
"}}}
" Makefiles {{{
augroup filetypedetect
    au BufRead,BufNewFile *.mak setfiletype mak
augroup END
" }}}
" Text files {{{
augroup text
    au FileType text set tw=80

    let g:LargeFile = 1024 * 1024 * 5
    autocmd BufReadPre * let f=expand("<afile>") | if getfsize(f) > g:LargeFile | set eventignore+=FileType | setlocal noswapfile bufhidden=unload buftype=nowrite undolevels=-1 | else | set eventignore-=FileType | endif

augroup END
" }}}
" }}}

if filereadable(uservimrc)
    execute 'source' . uservimrc
end

let g:ale_sign_column_always = 1

" vim:foldmethod=marker:foldlevel=-
