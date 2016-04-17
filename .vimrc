
autocmd BufNewFile *.html 0r $HOME/.vim/template/template.html
autocmd BufNewFile *.css 0r $HOME/.vim/template/template.css
autocmd BufNewFile *.styl 0r $HOME/.vim/template/template.css
autocmd BufNewFile *.cp.js 0r $HOME/.vim/template/template.cp.js

"Installing Neobundle
if has('vim_starting')
	set nocompatible
	if !isdirectory(expand("~/.vim/bundle/neobundle.vim/"))
		echo "install neobundle..."
		:call system("git clone git://github.com/Shougo/neobundle.vim ~/.vim/bundle/neobundle.vim")
	endif
	set runtimepath+=~/.vim/bundle/neobundle.vim/
endif
call neobundle#begin(expand('~/.vim/bundle'))
let g:neobundle_default_git_protocol='https'

" Write plugin between neobundle#begin and neobundle#end
NeoBundleFetch 'Shougo/neobundle.vim'

" Tree Filer
" NeoBundle 'scrooloose/nerdtree'

" Multiline comment outer
NeoBundle 'tyru/caw.vim.git'

" Coloring indent
NeoBundle 'nathanaelkane/vim-indent-guides'

" Markdown
NeoBundle 'plasticboy/vim-markdown'
NeoBundle 'kannokanno/previm'
NeoBundle 'tyru/open-browser.vim'

" syntax
NeoBundleLazy 'jelera/vim-javascript-syntax', {'autoload': {'filetypes': ['javascript']}}
NeoBundle 'hail2u/vim-css3-syntax'
" NeoBundle 'taichouchou2/html5.vim'
NeoBundle 'hokaccha/vim-html5validator'

"snippet
" NeoBundle 'Shougo/neocomplete'
" NeoBundle 'Shougo/neosnippet'
" NeoBundle 'Shougo/neosnippet-snippets'

NeoBundleCheck
call neobundle#end()

filetype plugin indent on

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
let g:hybrid_use_Xresources=1
let g:hybrid_use_iTerm_colors=1
autocmd ColorScheme * highlight LineNr ctermfg=9
colorscheme hybrid
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
set fileencoding=utf-8

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
autocmd! FileType css setlocal shiftwidth=2 tabstop=2 softtabstop=2
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
nmap <C-C> <Plug>(caw:i:toggle)
vmap <C-C> <Plug>(caw:i:toggle)

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

" imap <expr><TAB> neosnippet#expandable_or_jumpable() ?
"             \ "\<Plug>(neosunippet_expand_or_jump)"
"             \: pumvisible() ? "\<C-n>" : "\<TAB>"
smap <expr><TAB> neosnippet#expandable_or_jumpable() ?
            \ "\<Plug>(neosunippet_expand_or_jump)" : "\<TAB>"

if has('conceal')
    set conceallevel=2 concealcursor=niv
endif

