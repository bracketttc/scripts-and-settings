autocmd FileType python setlocal expandtab tabstop=2 smartindent shiftwidth=2
autocmd FileType cpp setlocal expandtab tabstop=2 smartindent shiftwidth=2
autocmd FileType shell setlocal expandtab tabstop=2 smartindent shiftwidth=2
autocmd FileType cmake setlocal expandtab tabstop=2 smartindent shiftwidth=2
autocmd FileType java setlocal expandtab tabstop=2 smartindent shiftwidth=2
set wildmode=longest,list,full
set wildmenu
set wildchar=<Tab>
colorscheme peachpuff
highlight comment ctermfg=lightblue

augroup filetype
  au! BufRead,BufNewFile *.proto setfiletype proto
augroup end

highlight ExtraWhitespace ctermbg=red guibg=red
match ExtraWhitespace /\s\+$/
autocmd BufWinEnter * match ExtraWhitespace /\s\+$/
autocmd InsertEnter * match ExtraWhitespace /\s\+\%#\@<!$/
autocmd InsertLeave * match ExtraWhitespace /\s\+$/
autocmd BufWinLeave * call clearmatches()

highlight SpecialKey ctermbg=red guibg=red
set list
set listchars=tab:>-
