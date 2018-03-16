
autocmd BufNewFile *.html 0r $HOME/.vim/template/template.html
autocmd BufNewFile *.css 0r $HOME/.vim/template/template.css
autocmd BufNewFile *.styl 0r $HOME/.vim/template/template.css
autocmd BufNewFile *.cp.js 0r $HOME/.vim/template/template.cp.js
autocmd BufNewFile Vagrantfile 0r $HOME/.vim/template/template.Vagrantfile

"dein Scripts-----------------------------
if &compatible
    set nocompatible " Be iMproved
endif

" Required:
set runtimepath+=~/.cache/dein/repos/github.com/Shougo/dein.vim

" Required:
if dein#load_state('~/.cache/dein')
    call dein#begin('~/.cache/dein')

    " Let dein manage dein
    " Required:
    call dein#add('~/.cache/dein/repos/github.com/Shougo/dein.vim')

    " Add or remove your plugins here:
    " call dein#add('Shougo/neosnippet.vim')
    " call dein#add('Shougo/neosnippet-snippets')

    " You can specify revision/branch/tag.
    " call dein#add('Shougo/vimshell', { 'rev': '3787e5' })

    " Plugins
    call dein#add('tyru/caw.vim.git') " multiline comment outer
    " call dein#add('nathanaelkane/vim-indent-guides') " coloring indent
    call dein#add('w0ng/vim-hybrid') " color scheme
    call dein#add('t9md/vim-textmanip') " text manip
    call dein#add('mattn/emmet-vim') " emmet
    call dein#add('othree/yajs.vim') " js syntax
    call dein#add('ap/vim-buftabline') " show tabs on top

    " Required:
    call dein#end()
    call dein#save_state()
endif

" Required:
filetype plugin indent on
syntax enable

" If you want to install not installed plugins on startup.
if dein#check_install()
  call dein#install()
endif

"End dein Scripts-------------------------


" Tree Filer
" NeoBundle 'scrooloose/nerdtree'

" Markdown
" NeoBundle 'plasticboy/vim-markdown'
" NeoBundle 'kannokanno/previm'
" NeoBundle 'tyru/open-browser.vim'

" syntax
" NeoBundleLazy 'jelera/vim-javascript-syntax', {'autoload': {'filetypes': ['javascript']}}
" NeoBundle 'hail2u/vim-css3-syntax'
" " NeoBundle 'taichouchou2/html5.vim'
" NeoBundle 'hokaccha/vim-html5validator'

"snippet
" NeoBundle 'Shougo/neocomplete'
" NeoBundle 'Shougo/neosnippet'
" NeoBundle 'Shougo/neosnippet-snippets'

""""""""""""""""""""
"                  "
" General Settings "
"                  "
""""""""""""""""""""
" Show syntax highlight
syntax on

" Show line number
set number

" Color scheme
" let g:hybrid_use_Xresources=1
" let g:hybrid_use_iTerm_colors=1
" let g:hybrid_custom_term_colors = 1
" let g:hybrid_reduced_contrast = 1 " Remove this line if using the default palette.
" colorscheme hybrid
autocmd ColorScheme * highlight LineNr ctermfg=9
hi CursorLine term=underline cterm=underline guibg=Grey90

" Dont use swap file.
set noswapfile

" Show invisible chars
set list
"set listchars=tab:>,extends:>>
"set listchars=tab:>\ ,extends:<,nbsp:_,trail:<
set listchars=tab:\ \ ,extends:<,nbsp:_,trail:<
" set listchars=tab:\ \ ,extends:<,nbsp:_

" Show pair bracket
set showmatch

" Do incrimental search
set incsearch

" File encoding
set encoding=utf-8 " inner charset is utf-8
set fileencoding=utf-8 " new file's charset is utf-8
set fileencodings=iso-2022-jp,euc-jp,sjis,utf-8 " try open with jis, euc-jp, shift-jis and utf-8
set fileformats=unix,dos,mac " newline type

" Indent
set expandtab "TABキーを押した時にスペース
set smartindent
set shiftwidth=4
set tabstop=4
set softtabstop=4
set autoindent

"Special Indent
augroup vimrc
autocmd! FileType tag setlocal shiftwidth=2 tabstop=2 softtabstop=2
autocmd! FileType jade setlocal shiftwidth=2 tabstop=2 softtabstop=2
autocmd! FileType html setlocal shiftwidth=2 tabstop=2 softtabstop=2
" autocmd! FileType javascript setlocal shiftwidth=4 tabstop=4 softtabstop=4
augroup END

au BufNewFile,BufRead *.tag setfiletype html
au BufNewFile,BufRead *.jade setfiletype html
au BufNewFile,BufRead *.md setfiletype markdown
au BufNewFile,BufRead *.es6 setfiletype javascript
au BufNewFile,BufRead *.styl setfiletype css

set whichwrap=b,s,h,l,<,>,[,]

" Dont wrap line.
set nowrap


" タブをスペースに展開しない
" set expandtab
set backspace=indent,eol,start
set wildmenu

""""""""""""""""""""""""""
"                        "
" Util setting functions "
"                        "
""""""""""""""""""""""""""

" Remember last cursor
if has("autocmd")
	autocmd BufReadPost *
	\ if line("'\"") > 0 && line ("'\"") <= line("$") |
	\	exe "normal! g'\"" |
	\ endif
endif

"Completion
"inoremap ( ()<ESC>i
"inoremap <expr> ) ClosePair(')')
"inoremap { {}<ESC>i
"inoremap <expr> } ClosePair('}')
"inoremap [ []<ESC>i
"inoremap <expr> ] ClosePair(']')
" pair close checker.
" from othree vimrc ( http://github.com/othree/rc/blob/master/osx/.vimrc )
"function ClosePair(char)
"	if getline('.')[col('.') - 1] == a:char
"        return "\<Right>"
"    else
"        return a:char
"    endif
"endf

augroup MyXML
	autocmd!
	autocmd Filetype html inoremap <buffer> </ </<C-x><C-o>
augroup END

""""""""""""""""""""""""""""""
"                            "
" NeoBundle plugin's setting "
"                            "
""""""""""""""""""""""""""""""

"NERDTree settings
"nnoremap <silent><C-e> :NERDTreeToggle<CR>

" caw settings
nmap <C-C> <Plug>(caw:hatpos:toggle)
vmap <C-C> <Plug>(caw:hatpos:toggle)

" vim-indent-guides settings
let g:indent_guides_enable_on_vim_startup=1
" let g:indent_guides_start_level=2
let g:indent_guides_auto_colors=0
autocmd VimEnter,Colorscheme * :hi IndentGuidesOdd ctermbg=235
autocmd VimEnter,Colorscheme * :hi IndentGuidesEven ctermbg=234
" let g:indent_guides_guide_size=1

" neosnippet

imap <C-s>  <Plug>(neosnippet_expand_or_jump)
smap <C-s>  <Plug>(neosnippet_expand_or_jump)
xmap <C-s>  <Plug>(neosnippet_expand_target)

" emmet-vim
let g:user_emmet_mode='iv'

" imap <expr><TAB> neosnippet#expandable_or_jumpable() ?
"             \ "\<Plug>(neosunippet_expand_or_jump)"
"             \: pumvisible() ? "\<C-n>" : "\<TAB>"
smap <expr><TAB> neosnippet#expandable_or_jumpable() ?
            \ "\<Plug>(neosunippet_expand_or_jump)" : "\<TAB>"

if has('conceal')
    set conceallevel=2 concealcursor=niv
endif

" netrw
let g:netrw_banner = 0
let g:netrw_liststyle = 3
let g:netrw_browse_split = 4 " Enter時に前のWindowに展開する
let g:netrw_altv = 1 " 左右分割で開くときの配置を逆にする(右に表示)
let g:netrw_winsize = 20 " netrwの幅
augroup ProjectDrawer
    autocmd!
    autocmd VimEnter * :Vexplore
augroup END

" vim-buftabline
" override [gt/gT]
nmap gt :bnext<CR>
nmap gT :bprev<CR>

