set tabstop=4
set sw=4
set expandtab
set smartindent
set cindent

if has("autocmd")
  au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif
endif
