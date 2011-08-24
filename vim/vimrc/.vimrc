" ---- Shreyans Bhansali ----

" ---- General settings -----
" Some taken from: http://amix.dk/vim/vimrc.html

filetype on
filetype plugin on
filetype indent on

syntax on
syntax enable

colorscheme ir_black_kortina
set background=dark
set t_Co=256
set number		"show line numbers
set history=700 	"number of lines of history for VIM to remember
set autoread		"auto update file if changed externally
set ruler		"show current position
set ignorecase		"ignore case when searching
set hlsearch		"highlight search things
set incsearch		"make search act like search in modern browsers
set showmatch		"show matching bracket when cursor is over one of them
set noerrorbells	"no sounds on errors
set visualbell
set t_vb=
set nobackup		"no backing up of files since it's all in svn
set noswapfile
set nowb		
set backspace=indent,eol,start
set tags+=./tags;
set cursorline
"set cursorcolumn
autocmd BufRead,BufNewFile * setlocal iskeyword-=.
autocmd BufRead,BufNewFile * setlocal iskeyword-=)
autocmd BufRead,BufNewFile * setlocal iskeyword-=(
set iskeyword-=. 	"treat as wordbreaks
set iskeyword-=(
set iskeyword-=)

autocmd WinEnter * setlocal cursorline
autocmd WinLeave * setlocal nocursorline
autocmd BufRead,BufNewFile,BufDelete * :syntax on

let g:miniBufExplMapWindowNavVim = 1
let g:miniBufExplMapWindowNavArrows = 1
let g:miniBufExplMapCTabSwitchBufs = 1
let g:miniBufExplModSelTarget = 1

autocmd! bufwritepost vimrc source ~/.vimrc	"reload vimrc when it is updated

set statusline=%F%m%r%h%w[%L][%{&ff}]%y[%p%%][%04l,%04v]

call pathogen#runtime_append_all_bundles() 

let g:commandTMaxHeight=10

" ---- Settings for specific language files ----
au BufRead,BufNewFile *.mustache set syntax=html autoindent tabstop=4 expandtab shiftwidth=4 softtabstop=4

autocmd FileType python set complete+=k~/.vim/syntax/python.vim isk+=.,(

autocmd BufRead,BufNewFile *.py syntax on
autocmd BufRead,BufNewFile *.py set ai
autocmd BufRead *.py set smartindent cinwords=if,elif,else,for,while,with,try,except,finally,def,class,#

au FileType python setl autoindent tabstop=4 expandtab shiftwidth=4 softtabstop=4
au FileType javascript setl autoindent tabstop=4 expandtab shiftwidth=4 softtabstop=4
au FileType html setl autoindent tabstop=4 expandtab shiftwidth=4 softtabstop=4
au FileType css setl autoindent tabstop=4 expandtab shiftwidth=4 softtabstop=4

autocmd FileType python set omnifunc=pythoncomplete#Complete
"autocmd FileType python setlocal list
autocmd FileType javascript set omnifunc=javascriptcomplete#CompleteJS
autocmd FileType html set omnifunc=htmlcomplete#CompleteTags
autocmd FileType css set omnifunc=csscomplete#CompleteCSS
autocmd FileType python set ft=python.django " For SnipMate
autocmd FileType html set ft=html.django_template " For SnipMate

let g:pydiction_location = '~/.vim/ftplugin/pydiction-1.2/complete-dict'


" ---- key mappings ----
nmap ,t <Leader>t

"  The following four are for going to the next/prev function definition and
"  next/prev class definition in python
nmap df :?^\s.*def <cr>
nmap fd :/^\s.*def <cr>
nmap cv :?^class <cr>
nmap vc :/^class <cr>
" copy to clipboard
nmap ,a ggVG"*y

"clear the search buffer, not just remove the highlight
map \c :let @/ = ""<CR>

" open the ctag definition in a vertical split
map <C-\> :tab split<CR>:exec("tag ".expand("<cword>"))<CR>
map <A-]> :vsp <CR>:exec("tag ".expand("<cword>"))<CR>

"Easy edit of vimrc
nmap \s :source $MYVIMRC<CR>
nmap \v :e $MYVIMRC<CR>

imap jj <Esc>

"##################################################
" via http://www.vim.org/scripts/script.php?script_id=30
"##################################################

map  ,cm   :call PythonCommentSelection()<CR>
vmap ,cm   :call PythonCommentSelection()<CR>
map  ,cu   :call PythonUncommentSelection()<CR>
vmap ,cu   :call PythonUncommentSelection()<CR>
" Comment out selected lines
" commentString is inserted in non-empty lines, and should be aligned with
" the block
function! PythonCommentSelection()  range
  let commentString = "#"
  let cl = a:firstline
  let ind = 1000    " I hope nobody use so long lines! :)

  " Look for smallest indent
  while (cl <= a:lastline)
    if strlen(getline(cl))
      let cind = indent(cl)
      let ind = ((ind < cind) ? ind : cind)
    endif
    let cl = cl + 1
  endwhile
  if (ind == 1000)
    let ind = 1
  else
    let ind = ind + 1
  endif

  let cl = a:firstline
  execute ":".cl
  " Insert commentString in each non-empty line, in column ind
  while (cl <= a:lastline)
    if strlen(getline(cl))
      execute "normal ".ind."|i".commentString
    endif
    execute "normal \<Down>"
    let cl = cl + 1
  endwhile
endfunction

" Uncomment selected lines
function! PythonUncommentSelection()  range
  " commentString could be different than the one from CommentSelection()
  " For example, this could be "# \\="
  let commentString = "#"
  let cl = a:firstline
  while (cl <= a:lastline)
    let ul = substitute(getline(cl),
             \"\\(\\s*\\)".commentString."\\(.*\\)$", "\\1\\2", "")
    call setline(cl, ul)
    let cl = cl + 1
  endwhile
endfunction
