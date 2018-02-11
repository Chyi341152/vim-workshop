"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => General
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" load plugins from vundle
filetype off

" 设置Vim运行的路径，默认插件存放的路径为 .vim/bundle/
set rtp+=~/.vim/bundle/vundle/
call vundle#begin()
""""""""""""""""""""""""""""""""""""'
" Installation using Vundle 
" Add Plugin 'vimwiki/vimwiki' to your vimrc file and run 
" vim +PluginInstall +qall 
" :PluginInstall 安装添加到配置中的插件
" :PluginUpdate 更新插件
" :PluginClean 清除本地无用插件
" download the zip archive and extract it in $HOME/.vim/bundle/
" run :Helptags and then :help vimwiki 
" let vundle manage vundle
Plugin 'gmarik/vundle'

" utilities
Plugin 'kien/ctrlp.vim' " fuzzy find files
Plugin 'scrooloose/nerdtree' " file drawer, open with :NERDTreeToggle
Plugin 'benmills/vimux'
Plugin 'tpope/vim-fugitive' " the ultimate git helper
Plugin 'tpope/vim-commentary' " comment/uncomment lines with gcc or gc in visual mode
Plugin 'vimwiki/vimwiki' " Personal Wiki for Vim 

" colorschemes
Plugin 'chriskempson/base16-vim'

" JavaScript plugins
Plugin 'pangloss/vim-javascript'
Plugin 'jelera/vim-javascript-syntax'

" 
Plugin 'a.vim'
Plugin 'c.vim'
Plugin 'vimprj'
Plugin 'DfrankUtil'
Plugin 'narwhales/indexer'
Plugin 'fatih/vim-go'
Plugin 'mattn/emmet-vim'
Plugin 'majutsushi/tagbar'
Plugin 'dgryski/vim-godef'
Plugin 'Blackrush/vim-gocode'
Plugin 'narwhales/delimit-mate'
Plugin 'Valloric/YouCompleteMe'
Plugin 'vim-airline/vim-airline'
Plugin 'vim-airline/vim-airline-themes'
Plugin 'google/yapf', {'rtp': 'plugins/vim'}

call vundle#end()
filetype plugin indent on

set nocompatible " not compatible with vi
set autoread " detect when a file is changed
set paste 

" 带有入校符号的单词不要被换行分割
set iskeyword+=_,$,%,@,#,-

" make backspace behave in a sane manner
set backspace=indent,eol,start
set whichwrap=b,s,<,>,[,]

" set a map leader for more key combos
let mapleader = ','
let g:mapleader = ','

" Fast saving 
nmap <leader>w :w!<cr>

" Tab control
set noexpandtab " tabs ftw
set smarttab " tab respects 'tabstop', 'shiftwidth', and 'softtabstop'
set tabstop=4 " the visible width of tabs
set softtabstop=4 " edit as if the tabs are 4 characters wide
set shiftwidth=4 " number of spaces to use for indent and unindent
set shiftround " round indent to a multiple of 'shiftwidth'

set clipboard=unnamed

" faster redrawing
set ttyfast

" code folding settings
set foldmethod=syntax " fold based on indent
set foldnestmax=10 " deepest fold is 10 levels
set nofoldenable " don't fold by default
set foldlevel=1

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => User Interface
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Searching
set ignorecase " case insensitive searching
set smartcase " case-sensitive if expresson contains a capital letter
set hlsearch
set incsearch " set incremental search, like modern browsers
set nolazyredraw " don't redraw while executing macros

set magic " Set magic on, for regex

set showmatch " show matching braces
set mat=2 " how many tenths of a second to blink

" switch syntax highlighting on
syntax on

" 保存历史和撤销的次数
set history=100
set undolevels=100

" 命令增强
set wildmenu
set wildignore+=*.o,*.so,*.obj,*.pyc,*.swp

set encoding=utf8
set termencoding=utf-8
set fileencoding=utf-8
set fileencodings=ucs-bom,utf-8,gbk,cp936,gb8030,big5,latin1
let base16colorspace=256  " Access colors present in 256 colorspace"
set t_Co=256 " Explicitly tell vim that the terminal supports 256 colors"
set background=dark
colorscheme delek

" 标尺和行号
set ruler
set number

set autoindent " automatically set indent of new line
set smartindent

set laststatus=2 " show the satus line all the time

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Mappings
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

map <leader>ev :e! ~/.vimrc<cr> " edit ~/.vimrc

map <leader>wc :wincmd q<cr>

" moving up and down work as you would expect
nnoremap <silent> j gj
nnoremap <silent> k gk

" helpers for dealing with other people's code
nmap \t :set ts=4 sts=4 sw=4 noet<cr>
nmap \s :set ts=4 sts=4 sw=4 et<cr>

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Functions
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

map <C-h> :call WinMove('h')<cr>
map <C-j> :call WinMove('j')<cr>
map <C-k> :call WinMove('k')<cr>
map <C-l> :call WinMove('l')<cr>

" Window movement shortcuts
" move to the window in the direction shown, or create a new window
function! WinMove(key)
    let t:curwin = winnr()
    exec "wincmd ".a:key
    if (t:curwin == winnr())
        if (match(a:key,'[jk]'))
            wincmd v
        else
            wincmd s
        endif
        exec "wincmd ".a:key
    endif
endfunction

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Plugin settings
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" close NERDTree after a file is opened
let g:NERDTreeQuitOnOpen=0
" show hidden files in NERDTree
let NERDTreeShowHidden=1
" Toggle NERDTree
nmap <silent> <leader>k :NERDTreeToggle<cr>
" expand to the path of the file in the current buffer
nmap <silent> <leader>y :NERDTreeFind<cr>

" map fuzzyfinder (CtrlP) plugin
" nmap <silent> <leader>t :CtrlP<cr>
nmap <silent> <leader>r :CtrlPBuffer<cr>
let g:ctrlp_map='<leader>t'
let g:ctrlp_dotfiles=1
let g:ctrlp_working_path_mode = 'ra'

" CtrlP ignore patterns
let g:ctrlp_custom_ignore = {
            \ 'dir': '\.git$\|node_modules$\|\.hg$\|\.svn$',
            \ 'file': '\.exe$\|\.so$'
            \ }

" search the nearest ancestor that contains .git, .hg, .svn
let g:ctrlp_working_path_mode = 2

"tmux will only forward escape sequences to the terminal if surrounded by a DCS sequence
" http://sourceforge.net/mailarchive/forum.php?thread_name=AANLkTinkbdoZ8eNR1X2UobLTeww1jFrvfJxTMfKSq-L%2B%40mail.gmail.com&forum_name=tmux-users

if exists('$TMUX')
  let &t_SI = "\<Esc>Ptmux;\<Esc>\<Esc>]50;CursorShape=1\x7\<Esc>\\"
  let &t_EI = "\<Esc>Ptmux;\<Esc>\<Esc>]50;CursorShape=0\x7\<Esc>\\"
else
  let &t_SI = "\<Esc>]50;CursorShape=1\x7"
  let &t_EI = "\<Esc>]50;CursorShape=0\x7"
endif 

""" 记住上次文件位置
augroup vimrcEx
	au!
	autocmd FileType text setlocal textwidth=78
	autocmd BufReadPost *
							\ if line("'\"") > 0 && line("'\"") <= line("$") | 
							\ exe "normal g'\"" |
							\ endif 
augroup END

""" 设置文件Tab宽度
autocmd FileType c,cpp,go,php,python setlocal expandtab tabstop=4 shiftwidth=4 softtabstop=4


""" 代码折叠
" zr 打开所有折叠
" zm 关闭所有折叠
" zc 折叠
" zC 对所在范围内所有嵌套点进行折叠
" zo 展开折叠
" zO 对所在范围呢你所有嵌套点展开
" zj 向下移动，到达下一个折叠的开始处
" zk 向上移动到前一个折叠的结束处

" ------------------插件设置-----------------
""" Plugin - delimitMate 自动补全括号
let delimitMate_matchpairs = "(:),[:],{:}"

"""  emmet-vim 前端开发
let g:user_emmet_install_global = 0
autocmd FileType html,css,EmmetInstall 
let g:user_emmet_leader_key='<C-Q>'

""" Plugin-tabbar.vim 函数列表
let g:tabbar_width = 25
let g:tagbar_autofocus = 1
let g:tagbar_ctags_bin = 'ctags'
nmap <silent><F6> <ESC>:TagbarToggle<CR>

""" Plugin - index 自动更新tags 
" set tags+=~/.vim/tags
" 设置indexer调用ctags的参数
" 默认--c++-kinds=+p+l,设置为--c++-kinds=+p+l+x+c+d+e+f+g+m+n+s+t+u+v
" 默认--fields=+iaS不满足YCM要求，需改为--fields=+iaSl
" 标签跳转：ctrl-], tn向后，tp向前
" 返回 ctrl-t,返回到上次光标位置，ctrl-o,返回到上一个标签
" 再次进入：ctrl-i 
let g:indexer_ctagsCommandLineOptions="--c++-kinds=+p+l+x+c+d+e+f+g+m+n+s+t+u+v --fields=+iaSl --extra=+q"

nmap <leader>jc :YcmCompleter GoToDeclaration<CR>
nmap <leader>jd :YcmCompleter GoToDefinition<CR>

""" Plugin - vim-go golang语言支持
let g:godef_split=0
let g:go_highlight_functions = 1
let g:go_highlight_methods = 1
let g:go_highlight_structs = 1
let g:go_highlight_interfaces = 1
let g:go_highlight_operators = 1
let g:go_highlight_build_constraints = 1
" gotags配置
let g:tagbar_type_go = {
		\ 'ctagstype'	: 'go',
		\ 'kinds'		: [
				\ 'p:package',
				\ 'i:imports:1',
				\ 'c:constants',
				\ 'v:variables',
				\ 't:types',
				\ 'n:interfaces',
				\ 'w:fields',
				\ 'e:embedded',
				\ 'm:methods',
				\ 'r:constructor',
				\ 'f:functions'
		\ ],
		\ 'sro' : '.',
		\ 'kind2scope' : {
				\ 't' : 'ctype',
				\ 'n' : 'ntype'
		\ },
		\ 'scope2kind' : {
			\ 'ctype' : 't',
			\ 'ntype' : 'n'
		\ },
		\ 'ctagsbin'  : 'gotags',
		\ 'ctagsargs' : '-sort -silent'
\ }

nmap <leader>g :GoDef<CR>

""" Plugin - airline 状态栏美化
" 设置airline主题
let g:airline_theme="luna"
if !exists('g:airline_symbols')
    let g:airline_symbols = {}
endif
"打开tabline功能,方便查看Buffer和切换
"if has("gui_running")
	let g:airline#extensions#tabline#enabled = 1
	let g:airline#extensions#tabline#left_sep = ''
	let g:airline#extensions#tabline#left_alt_sep = '|'
	let g:airline#extensions#tabline#buffer_nr_show = 1
"endif
" 关闭状态显示空白符号计数
let g:airline#extensions#whitespace#enabled = 0
let g:airline#extensions#whitespace#symbol = '!'
" 状态栏设置
let g:bufferline_echo=0
let g:airline_powerline_fonts=1
let g:Powerline_symbols='fancy'
let g:airline_left_sep = '▶'
let g:airline_left_alt_sep = '»'
let g:airline_right_sep = '◀'
let g:airline_right_alt_sep = '«'
let g:airline_symbols.linenr = '¶'
let g:airline_symbols.paste = 'ρ'
let g:airline_symbols.branch = '⎇'
let g:airline_symbols.readonly = '🔒'
let g:airline_symbols.whitespace = 'Ξ'

""" Plugin - YcmCompleteMe 自动补全
set completeopt=longest,menu	"让Vim的补全菜单行为与一般IDE一致
autocmd InsertLeave * if pumvisible() == 0|pclose|endif			"离开插入模式后自动关闭预览窗口
inoremap <expr> <CR>       pumvisible() ? "\<C-y>" : "\<CR>"	"回车即选中当前项
" 自动补全设置
let g:ycm_global_ycm_extra_conf = '~/.vim/bundle/YouCompleteMe/third_party/ycmd/cpp/ycm/.ycm_extra_conf.py'
" 指定vim解释器
let g:ycm_path_to_python_interpreter = '/usr/bin/python'
" 不显示开启vim时检查ycm_extra_conf文件的信息
let g:ycm_confirm_extra_conf=0
" 关闭语法检查，节省性能
let g:ycm_enable_diagnostic_signs = 0
" 开启基于tag的补全，可以在这之后添加需要的标签路径
let g:ycm_collect_identifiers_from_tags_files=1
"注释和字符串中的文字也会被收入补全
let g:ycm_collect_identifiers_from_comments_and_strings = 0
" 输入第2个字符开始补全
let g:ycm_min_num_of_chars_for_completion=2
" 开启语义补全
let g:ycm_seed_identifiers_with_syntax=1
"在注释输入中也能补全
let g:ycm_complete_in_comments = 1
"在字符串输入中也能补全
let g:ycm_complete_in_strings = 1
" 禁止缓存匹配项,每次都重新生成匹配项
let g:ycm_cache_omnifunc=0
" 设置在下面几种格式的文件上屏蔽ycm
let g:ycm_filetype_blacklist = {
      \ 'nerdtree' : 1,
      \}

" ------------------------ 自定义函数 ------------------------------------
" 批量删除: buffer
func! DeleteAllBuffers()
	let s:curWinNr = winnr()
	if winbufnr(s:curWinNr) == 1
		ret
	endif
	let s:curBufNr = bufnr("%")
	exe "bn"
	let s:nextBufNr = bufnr("%")
	while s:nextBufNr != s:curBufNr
		exe "bn"
		exe "bdel ".s:nextBufNr
		let s:nextBufNr = bufnr("%")
	endwhile
endfunc
nmap <silent><F4> <Esc>:call DeleteAllBuffers()<CR>

" 在文件末尾添加: modelline
func! AppendModeline()
	let l:modeline = printf(" vim: set ts=%d sw=%d tw=%d %set :",
		\ &tabstop, &shiftwidth, &textwidth, &expandtab ? '' : 'no')
	let l:modeline = substitute(&commentstring, "%s", l:modeline, "")
	call append(line("$"), l:modeline)
endfunc
nmap <silent><F3> <Esc>:call AppendModeline()<CR>


" 自动最大化窗口: wmctrl
func! MaximizeWindow()
    silent !wmctrl -r :ACTIVE: -b add,maximized_vert,maximized_horz
endfunc
au GUIEnter * call MaximizeWindow()

" 全屏化
func! ToggleFullScreen()
    call system("wmctrl -r :ACTIVE: -b toggle,fullscreen")
endfunc
nmap <silent><F11> <Esc>:call ToggleFullScreen()<CR>

" ------------------------ 快捷键定制 ------------------------------------
" 文件浏览器
let g:netrw_list_hide =  '^\..*,'                                
let g:netrw_list_hide .= '\.a$,\.so$,'    
let g:netrw_list_hide .= '\.o$,\.obj$,' 
let g:netrw_list_hide .= '\.a\s\+,\.so\s\+,'
let g:netrw_list_hide .= '\.o\s\+,\.obj\s\+,'         
let g:netrw_list_hide .= '\.pyc$,\.git$,\.gitignore$,tags$'
command! E Explore
command! S Sexplore
command! V Vexplore

" 切换窗口快捷键重映射
nmap <C-h> <C-w>h
nmap <C-l> <C-w>l

" 复制粘贴
vmap <C-X> "+x
vmap <C-C> "+y
imap <C-V> "+gP
cmap <C-V> <C-R>+
imap <S-Insert> "+gP
cmap <S-Insert> <C-R>+
exe 'inoremap <script> <C-V>' paste#paste_cmd['i']
exe 'vnoremap <script> <C-V>' paste#paste_cmd['v']

" 切换Buffer
nmap <S-TAB> <Esc>:bn<CR>

" 保存会话
let session_file = $HOME.'/.vim/session/Session.vim'
set sessionoptions=buffers,curdir,resize,folds,tabpages  
" autocmd VimLeave * exec "mks! " . session_file
nmap <leader>m :exec "mks! " . session_file<CR>
" 恢复会话
nmap <leader>r :exec "source " . session_file<CR>

" https://github.com/melanc/vim-tmux-conf/tree/master/vim 

" add key binding in .vimrc file 
map <C-Y> :call yapf#YAPF()<cr>

" Useful mapping for managing tabs 
map <leader>tn :tabnew<cr>
map <leader>to :tabonly<cr>
map <leader>tc :tabclose<cr>
map <leader>tm :tabmove 
map <leader>t<leader> :tabnext 

" Let 'tl' toggle between this and the last accessed tab 
let g:lasttab = 1
nmap <leader>tl :exe "tabn ".g:lasttab<CR>
au TabLeave * let g:lastab = tabpagenr() 

