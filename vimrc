call pathogen#infect()
set nocompatible
behave xterm
              
if has("terminfo")
  set t_Co=8
  set t_Sf=[3%p1%dm
  set t_Sb=[4%p1%dm
else
    set t_Co=8
    set t_Sf=[3%dm
    set t_Sb=[4%dm
endif

""   Termcap seems to be broken for backspace ???  -13 Aug 99-
"if &term == "xterm-color"
"    set t_kb=
"    fixdel
"endif

" Tab stuff
"set ts=4
set ts=8
set sts=4
set shiftwidth=2
"   Make every tab really be spaces
set expandtab
set shiftround
set softtabstop=2
set tabstop=2


set virtualedit=all
set laststatus=2

" show line numbers
set number

set wrapscan

"Auto-fold perl subs
"let perl_fold=1

"If you want to fold blocks in if statements, etc. as well set the
"following:
"let perl_fold_blocks = 1

"Enable folding for classes and functions: >
"let php_folding = 1

set nojoinspaces

" autoindent
autocmd FileType perl set autoindent | set smartindent

map Q :q
map W :w


" make tab in normal mode indent code
nmap <tab> >> 
nmap <s-tab> ^i<bs><esc>

set paste
set pastetoggle=<F10>

map <C-K> :call SyntaxCheck()<CR>

function! SyntaxCheck()
        let filename = expand("%")
        let ftype = &filetype
        if ftype == '' 
                return
        echo ftype 
        elseif ftype == "cs"
                if exists("Makefile")
                  let cmd = "!clear; gmake"
                else 
                  let cmd = "!clear; mcs --parse " . filename
                endif
                echo cmd
                execute cmd
        elseif ftype == "perl"
                let cmd = "!clear; echo \"\"; echo \"\"; perl -cw " . filename
                echo cmd
                execute cmd
        elseif ftype == "javascript"
                let cmd = "!clear; echo \"\"; echo \"\"; smjs " . filename
                echo cmd
                execute cmd
         elseif ftype == "php"
                let cmd = "!clear; echo \"\"; echo \"\"; php -l " . filename
                echo cmd
                execute cmd  
        else
                echo "Cant syntax check file type : " . ftype
                return
        endif
endfunction

"""""""""""""""""""""

"set makeprg=gmake

set vb t_vb=

set ic

" Save some info about the session between sessions
"set viminfo='50,%,n.viminfo

" Where to put swap files
set dir='~/tmp,/var/tmp,/tmp'
"set dir='~/tmp'

" Size of History
set hi=100

" Autowrite
"set aw
" Hidden
set hidden

"   Show the matching brace/parent/bracket
set showmatch

" Allow local overloads
set ex

set ssop=winsize

"   Wildcard settings
"       What to ignore
set wildignore=*.o,*~
"       complete to longest common and list the alternatives
set wildmode=list:longest

" Make settings
"set mp=gmake
"set sp=2>&1\ \|\ ~/bin/addcolor2.pl 
"set mef=proj.err

"   Set the equal program
"set equalprg=sort

" Indenting
"set smartindent
"set autoindent
set cindent
set cinoptions=g0,+2s,(1s,c1s
" set cinkeys=0{,0},0),:,0#,!^F,o,O,e {default}
" don't force perl comment to be entered into column 1
set cinkeys=0{,0},!^F,o,O,e
    
"   Completion
set cpt=k
set dict=~/.vim_dictionary
  
"   What to after building 
"let runcmd = 'sudo /home/apache/restart'

" Some mappings that I like
nmap  O#ifdef kathey_ANTIQUEj
nmap  o#endif /*  kathey_ANTIQUE  */k
vmap  oVO#ifdef kathey_ANTIQUEjgvoVo#endif  /*  kathey_ANTIQUE  */k

nmap [18~ ggO/***   $Source: $** $Revision: $**     $Date: $**   $Author: $*/j
nmap [19~ :source ~/.vimrc:if filereadable( "./.vimrc" )source ./.vimrcendif
"map [20~ :!sudo /home/apache/restart
"map [20~ :execute "!" .  runcmd . ""
"nmap [20~ :execute '!' .  runcmd
"nmap  :execute '!' .  runcmd
"nmap [21~ :mak
"nmap  :mak
"nmap  :mak %:r.o
"nmap [17~ 0d/^-- $
"nmap  ggO"%P:s/.*\///eA__I__:s/\./_/gegUU"zyyI#ifndef "zpI#define oGo"zpI#endif  /*  A */

" Navigate buffers
map  :bn
map  :bp
map - :bd
map  :files

" Give emacs style command line editing
" start of line
cnoremap <C-A>    <Home>
" back one character
cnoremap <C-B>    <Left>
" delete character under cursor
cnoremap <C-D>    <Del>
" end of line
cnoremap <C-E>    <End>
" forward one character
cnoremap <C-F>    <Right>
" recall newer command-line
cnoremap <C-N>    <Down>
" recall previous (older) command-line
cnoremap <C-P>    <Up>
" back one word
cnoremap <Esc>b   <S-Left>
" forward one word
cnoremap <Esc>f   <S-Right>

"cnoremap <Esc>W          <Esc>:w
"cmap W w

" reindent pasted text
"nnoremap p  p'[v']=
"nnoremap P  P'[v']=


" Reload the previous files
autocmd!
"au VimEnter * source _vimsession
"au VimLeavePre * mks! _vimsession
"auto BufEnter * let &titlestring = "bash - " . getcwd() . " {VIM - " . expand("%:t") . "}"
auto BufEnter * let &titlestring = strpart( hostname(), 0, match( hostname(), '\.' ) ) . " (" . $USER . " )  " . fnamemodify( getcwd(), ':~' ) . " (" . fnamemodify( expand( "%:p" ), ":." ) . ")"

" command line abbreviations
"cab vimrc $BASEDRIVE:\briefcase\vimrc

" Stuff to help me write C/C++ faster
"iab if if ( )hi
"iab for for ( )hi
"iab ei else if ( )hi
"iab pu public:
"iab pro protected:
"iab pri private:
"inoremap { {}O
inoremap # X#

  
"if expand( "%" ) == ""
" exe "bp"
"endif

" Syntax Highlighting
syn on
"set background=dark

"guggen's fancy persistent search highlighting
set incsearch
set hlsearch
map <M-;> :noh


"   A few niceties for editing when launched from Mutt                
auto BufEnter /tmp/mutt-* set viminfo= tw=66 nocindent                                              

:au BufNewFile,BufRead {autohandler,dhandler} so /usr/local/share/vim/vim62/syntax/mason.vim
"auto BufEnter /tmp/mutt-* nmap ^K 0d/^-- $^M                             
"auto BufEnter /tmp/mutt-* normal O^[


"   Syntax highlighting for HTML only
"let html_my_rendering=1
"hi htmlLink ctermfg=6

"hi Directory ctermfg=6
"let did_drchip_tags_inits=1
"hi tagPath ctermfg=6
"hi tagBaseFile ctermfg=6
"hi tagName ctermfg=6
"hi htmlLink cterm=underline ctermfg=2
"hi htmlBold     term=bold cterm=bold gui=bold
"hi htmlBoldUnderline  term=bold,underline cterm=bold,underline gui=bold,underline
"hi htmlBoldItalic     term=bold,italic cterm=bold,italic gui=bold,italic
"hi htmlBoldUnderlineItalic term=bold,italic,underline cterm=bold,italic,underline gui=bold,italic,underline
"hi htmlUnderline    term=underline cterm=underline gui=underline
"hi htmlUnderlineItalic  term=italic,underline cterm=italic,underline gui=italic,underline
"hi htmlItalic     term=italic cterm=italic gui=italic

"au BufReadPost * if $filetype == "tags"
"au BufReadPost *    hi PreProc ctermfg=6
"au BufReadPost * endif
"let mysyntaxfile = "~/local/vim/mysyntax.vim"
"autocmd FileType tags   hi PreProc ctermfg=6
"au Syntax tags   hi PreProc ctermfg=6
"au Filetype tags   hi PreProc ctermfg=6

set ruler
"let g:ctags_path='/usr/local/bin/exctags'
"let g:ctags_statusline=1 " To show tag name in status line.
"let generate_tags=1
"
let TE_Ctags_Path = '/usr/local/bin/exctags' 
map f :TagExplorer

"Set or remove autoindent and smart indent
function! ToggleForPaste()
  exe 'set nopaste!'
endfunction

iab pmod ^]:r ~/bin/module_doc.pm^M

noremap <buffer> <F2> :call ToggleForPaste()<CR>

let g:miniBufExplMapWindowNavArrows = 1 

" Move between windows with C-key
"nnoremap <silent><C-Right> <Esc><C-w>l
"noremap <unique><script><C-Right> <Esc><C-w>l
"noremap <C><Right> <Esc><C-w>l
"imap <C-Right> <Esc><C-w>l
"noremap <C-Left> <Esc><C-w>h
"imap <C-Left> <Esc><C-w>h
"noremap <C-Up> <Esc><C-w>k
"imap <C-Up> <Esc><C-w>k
"noremap <C-Down> <Esc><C-w>j
"imap <C-Down> <Esc><C-w>j

nnoremap <silent> <Esc>t :TlistToggle<CR>
let Tlist_Auto_Open = 1
let tlist_php_settings='php;f:function'
let tlist_javascript_settings='javascript;f:function;p:property;v:variable'
let tlist_actionscript_settings = 'actionscript;c:class;f:method;p:property;v:variable'
let Tlist_Process_File_Always = 1
set tags=/Users/harshdoshi/git/tags
map <esc><space> <C-w>j

 " Set comment characters for common languages
autocmd FileType python,sh,bash,zsh,ruby,perl,muttrc let StartComment="#" | let EndComment=""
autocmd FileType html let StartComment="<!--" | let EndComment="-->"
autocmd FileType php,cpp,javascript let StartComment="//" | let EndComment=""
autocmd FileType c,css let StartComment="/*" | let EndComment="*/"
autocmd FileType vim let StartComment="\"" | let EndComment=""
autocmd FileType ini let StartComment=";" | let EndComment=""

" Toggle comments on a visual block
function! CommentLines()
    try
        execute ":s@^".g:StartComment." @\@g"
        execute ":s@ ".g:EndComment."$@@g"
    catch
        execute ":s@^@".g:StartComment." @g"
        execute ":s@$@ ".g:EndComment."@g"
    endtry
endfunction

" Comment convenientlyvmap <C-C> :call CommentLines()<CR>
vmap <C-C> :call CommentLines()<CR>

" Use the below highlight group when displaying bad whitespace is desired.
highlight BadWhitespace ctermbg=red guibg=red
 
" Display tabs at the beginning of a line in Python mode as bad.
au BufRead,BufNewFile *.py,*.pyw match BadWhitespace /^\t\+/
" Make trailing whitespace be flagged as bad.
au BufRead,BufNewFile  *.py,*.pyw,*.rb,*.c,*.h,*.pl,*.pm,*.php match BadWhitespace /\s\+$/


filetype on
map <C-U> <C-]> 
map <C-L> g]

function! SuperCleverTab()
    if strpart(getline('.'), 0, col('.') - 1) =~ '^\s*$'
        return "\"
    else
        if &omnifunc != ''
            return "\\"
        elseif &dictionary != ''
            return "\"
        else
            return "\"
        endif
    endif
endfunction

set nocp                                                                                                                                                                                      
filetype plugin on
filetype plugin indent on
set ofu=syntaxcomplete#Complete
autocmd FileType php set omnifunc=phpcomplete#CompletePHP
autocmd FileType javascript set omnifunc=javascriptcomplete#CompleteJS
autocmd FileType actionscript set omnifunc=actionscriptcomplete#CompleteAS
autocmd FileType html set omnifunc=htmlcomplete#CompleteTags
autocmd FileType css set omnifunc=csscomplete#CompleteCSS
autocmd CursorMovedI * if pumvisible() == 0|pclose|endif
autocmd InsertLeave * if pumvisible() == 0|pclose|endif 
au Bufread,BufNewFile *.as set filetype=actionscript
command Asgrep execute "lvim /%/gj ./**/*.as"
command Phpgrep execute "lvim /%/gj ./**/*.php"

map <F4> :execute "lvim /" . expand("<cword>") . "/gj ./**/*.as" <Bar> lw<CR>
map <F5> :execute "lvim /" . expand("<cword>") . "/gj ./**/*.php" <Bar> lw<CR>
"map <C-j> :execute "lvim /" . expand("<cword>") . "/gj ./**/*.h ./**/*.c ./**/*.rb ./**/*.php" <Bar> lw<CR>
map <C-j> :execute "Ack"<CR> 
nmap <C-y> :NERDTreeToggle<CR>
autocmd vimenter * NERDTree
nmap <leader>nf :NERDTreeFind<CR>
nmap <C-g> :TagbarToggle<CR>

" Syntastic checker options
let g:syntastic_c_include_dirs = ['.', '../', 'includes', '../includes', 'libevent', 'protobuf-c', 'protobuf_defs', 'memalloc', 'adserving_libs', 'protobuf_defs/c' ]
