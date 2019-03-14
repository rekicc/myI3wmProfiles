"原方案 https://github.com/ma6174/vim 在此基础上进行了大幅修改,只为终端vim配置

"**************************************************************
"                       主题配置                              "
"**************************************************************                       
if $TERM =~ '^xterm' || $TERM =~ '^screen' || $TERM=~ '256color$'
    set t_Co=256
   colorscheme molokai
"    colorscheme gruvbox
"    set background=dark
elseif $TERM =~ 'cons25'
    colorscheme default
endif

set nocompatible        " 去掉有关vi一致性模式，避免以前版本的一些bug和局限  


"**************************************************************
"                       显示相关                              "
"**************************************************************                       
set sw=4
set ts=4
set et
set smarttab
set smartindent         " 开启新行时使用智能自动缩进
set lbr
set fo+=mB
set sm
set selection=inclusive
set wildmenu
set mousemodel=popup
syntax enable
syntax on
set cul                 " 高亮光标所在行
set cuc
set shortmess=atI       " 启动的时候不显示那个援助乌干达儿童的提示  
set go=                 " 不要图形按钮  
autocmd InsertEnter * se cul             " 用浅色高亮当前行  
set ruler               " 显示标尺  
set showcmd             " 输入的命令显示出来，看的清楚些  
set scrolloff=2         " 光标移动到buffer的顶部和底部时保持3行距离  
set statusline=%F%m%r%h%w\ [FORMAT=%{&ff}]\ [TYPE=%Y]\ [POS=%l,%v][%p%%]\ %{strftime(\"%d/%m/%y\ -\ %H:%M\")}\ %{ALEGetStatusLine()}   " 状态行显示的内容  
set laststatus=2        " 启动显示状态行(1),总是显示状态行(2)  
" 设置折叠
set foldenable          " 允许折叠 
set foldcolumn=0        " 设置折叠区域宽度
" 自动缩进
set autoindent
set cindent
set tabstop=4           " Tab键的宽度 
" 统一缩进为4
set softtabstop=4
set shiftwidth=4
" 使用空格代替制表符
set expandtab
" 在行和段开始处使用制表符
set smarttab
" 历史记录数
set history=1000
" 搜索逐字符高亮
set hlsearch
set incsearch
" 语言设置
set langmenu=zh_CN.UTF-8
set helplang=cn
" 保存全局变量
set viminfo+=!
" 带有如下符号的单词不要被换行分割
set iskeyword+=_,$,@,%,#,-
set guioptions-=T           " 隐藏工具栏
set guioptions-=m           " 隐藏菜单栏


"*************************************************************
"                   编译运行与调试                           "
"*************************************************************                   
func! Compile()
	exec "w"
	if &filetype == 'c'
		exec "!gcc -g -m32 % -o %<"
	elseif &filetype == 'cpp'
		exec "!g++ % -o %<"
	elseif &filetype == 'java' 
		exec "!javac %" 
    elseif &filetype == 'go'
"        exec "!go build %<"
	endif
endfunc

func! Run()
	exec "w"
	if &filetype == 'c'
		exec "!time ./%<"
	elseif &filetype == 'cpp'
		exec "!time ./%<"
	elseif &filetype == 'java' 
		exec "!time java %<"
	elseif &filetype == 'sh'
		:!time bash %
	elseif &filetype == 'python'
		exec "!time python2.7 %"
    elseif &filetype == 'html'
        exec "!firefox % &"
    elseif &filetype == 'go'
        exec "!time go run %"
	endif
endfunc

func! Rungdb()
	exec "w"
	exec "!g++ % -g -o %<"
	exec "!gdb ./%<"
endfunc


"*************************************************************
"                           实用设置                         "
"*************************************************************                           
" 显示中文帮助
if version >= 603
	set helplang=cn
	set encoding=utf-8
endif

setlocal magic    " 设置魔术
if has("autocmd")
      autocmd BufReadPost *
          \ if line("'\"") > 0 && line("'\"") <= line("$") |
          \   exe "normal g`\"" |
          \ endif
endif

" 当打开vim且没有文件时自动打开NERDTree
autocmd vimenter * if !argc() | NERDTree | endif
" 只剩 NERDTree时自动关闭
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTreeType") && b:NERDTreeType == "primary") | q | endif
" 设置当文件被改动时自动载入
set autoread
" 自动保存
set autowrite
" 去掉输入错误的提示声音
set noeb
" 在处理未保存或只读文件的时候，弹出确认
set confirm
" 禁止生成临时文件
set nobackup
set noswapfile
" 搜索忽略大小写,但有一个及以上大写字母时仍保持大小写敏感
set ignorecase smartcase
" 增强模式中的命令行自动完成操作
set wildmenu
" 使回格键（backspace）正常处理indent, eol, start等
set backspace=2
set linespace=0
set selection=exclusive
set selectmode=mouse,key
" 在被分割的窗口间显示空白，便于阅读
set fillchars=vert:\ ,stl:\ ,stlnc:\
" 高亮显示匹配的括号
set showmatch
" 匹配括号高亮的时间（单位是十分之一秒）
set matchtime=1
" 覆盖文件时不备份 
set nobackup 
" 设置备份时的行为为覆盖
set backupcopy=yes 
" 禁止在搜索到文件两端时重新搜索
set nowrapscan
set completeopt=longest,menu
set fileencodings=utf8,ucs-bom,gbk,cp936,gb2312,gb18030
set relativenumber
set number

"*************************************************************
"                   Vundle configure                         "
"*************************************************************                   
filetype off                   " required!
set rtp+=~/.vim/bundle/vundle/
call vundle#begin()

Plugin 'gmarik/vundle'
Bundle 'Yggdroot/indentLine'
Plugin 'vim-airline/vim-airline'
Plugin 'vim-airline/vim-airline-themes'
"Plugin 'vimwiki/vimwiki'
Bundle 'Auto-Pairs'
Plugin 'scrooloose/nerdtree'
Plugin 'tpope/vim-endwise'
Plugin 'majutsushi/tagbar'
Plugin 'ryanoasis/vim-devicons'
Plugin 'godlygeek/tabular'
Plugin 'Xuyuanp/nerdtree-git-plugin'
Plugin 'Valloric/YouCompleteMe'
Plugin 'w0rp/ale'
Plugin 'tpope/vim-surround'
Plugin 'rking/ag.vim'
Plugin 'sjl/gundo.vim'
Plugin 'tpope/vim-fugitive'
Plugin 'octol/vim-cpp-enhanced-highlight'
Plugin 'Yggdroot/LeaderF',{'do':'./install.sh'}
Plugin 'SirVer/ultisnips'
Plugin 'honza/vim-snippets'
Plugin 'junegunn/limelight.vim'
Plugin 'gregsexton/gitv'
Plugin 'airblade/vim-gitgutter'
call vundle#end()


"*************************************************************
"                           插件设置                         "
"*************************************************************                           
filetype plugin indent on       "打开文件类型检测，并载入相关缩进文件
filetype plugin on

" airline
let g:airline_powerline_fonts = 1
let g:airline_theme = 'powerlineish'
let g:airline#extensions#tabline#enabled = 1            " 显示tabline,方便切换buffer
let g:airline#extensions#ale#enabled = 1                "　显示ale结果
let g:airline#extensions#tagbar#enabled = 1
let g:airline#extensions#tabline#buffer_nr_show = 1
let g:airline#extensions#whitespace#enabled = 0         " 不显示空白符号计数

" 提示线
let g:indentLine_char = '┊'

" ale
let g:ale_set_highlights = 0
let g:ale_sign_error = '✗' 
let g:ale_sign_warning = '⚠'
let g:ale_sign_column_always = 1
let g:ale_statusline_format = ['✗ %d', '⚡ %d', '✔ OK']
let g:ale_echo_msg_error_str = 'E'
let g:ale_echo_msg_warning_str = 'W'
let g:ale_echo_msg_format = '[%linter%] %s [%severity%]'
let g:ale_lint_on_text_changed = 'nerver'
let g:ale_lint_on_enter = 1
let g:ale_linters = {
        \ 'c' : ['clang'],
        \ 'c++' : ['g++']
        \}

" YCM
let g:ycm_server_python_interpreter = '/usr/bin/python'
let g:ycm_global_ycm_extra_conf = '~/.vim/.ycm_extra_conf.py'
let g:ycm_show_diagnostics_ui = 0
let g:ycm_enable_diagnostic_signs = 0
let g:ycm_enable_diagnostic_hignlignting = 0
let g:ycm_echo_current_diagnostic = 0
let g:ycm_seed_identifiers_with_syntax = 1
let g:ycm_autoclose_previre_window_after_completion = 1
let g:ycm_usr_ultisnips_completer = 1
let g:ycm_goto_buffer_command = 'horizontal-split'
let g:ycm_filetype_blacklist = {
        \ 'tagbar' : 1,
        \ 'vimwiki' : 1
        \}

" fzf
set rtp+=~/.vim/plugin/fzf

" ag
let g:ag_working_path_mode = "r"
let g:ag_highlight = 1

" tagbar
let g:tagbar_autofocus = 1
let g:tagbar_width = 30
let g:tagbar_ctags_bin = '/usr/bin/ctags'


" vim-cpp-enhanced-highlight
let g:cpp_class_scope_highlight = 1
let g:cpp_member_variable_highlight = 1
let g:cpp_class_decl_highlight = 1
let g:cpp_experimental_simple_template_hightlight = 1
let g:cpp_experimental_template_hithlight = 1
let g:cpp_concepts_highlight = 1

" ultisnips
let g:UltiSnipsExpandTrigger="<Leader>e"
let g:UltiSnipsJumpForwardTrigger="<C-b>"
let g:UltiSnipsJumpBackwardTrigger="<C-z>"

" vimwiki
let g:vimwili_folding = 'expr'

" limelight
let g:limelight_conceal_ctermfg = 'gray'
let g:limelight_conceal_ctermfg = 240
let g:limelight_default_coefficient = 0.7

" gitgutter
set updatetime=1000
"*************************************************************
"                          键盘命令                          "
"*************************************************************
" leader
let mapleader="\<Space>"
" fzf
" nnoremap <Leader>f :FZF<CR> 
" 列出当前目录文件树状图
nmap <F3> :NERDTreeToggle<CR>
imap <F3> <ESC> :NERDTreeToggle<CR>
" insert mode shortcut
imap <A-h> <Left>
imap <A-j> <Down>
imap <A-k> <Up>
imap <A-l> <Right>
" C，C++ 按C-B编译
nmap <C-B> :call Compile()<CR>
" C-F5运行程序
nmap <C-F5> :call Run()<CR>
" C,C++的调试
nmap <F5> :call Rungdb()<CR>
" Ag
nnoremap <Leader>a :AgBuffer 
" F6显示tagbar
nmap <F6> :TagbarToggle<CR>
" gundo
nmap <silent><Leader>g :GundoShow<CR>
" disable search highlight
noremap <silent><Leader>/ :nohls<CR>
" use arrow key to change buffer
nnoremap<silent><left> :bp<CR>
nnoremap<silent><right> :bn<CR>
" smart move between windows
noremap<C-j> <C-W>j
noremap<C-k> <C-W>k
noremap<C-h> <C-W>h
noremap<C-l> <C-W>l
" ale shortcuts
nnoremap <Space>p <Plug>(ale_previous_warp)
nnoremap <Space>n <Plug>(ale_next_warp)
nnoremap <silent><Leader>r :set relativenumber<CR>
nnoremap <silent><Leader>nr :set norelativenumber<CR>
" limelight shortcuts
nmap <Leader>l :Limelight<CR>
" save file and quit vim
nnoremap <silent><Leader>w :w<CR>
nnoremap <silent><Leader>q :q<CR>


"*************************************************************
"                     some special color                     " 
"*************************************************************
hi Normal  ctermbg=none
hi ALEErrorSign ctermfg=red ctermbg=235
hi ALEWarningSign ctermfg=yellow ctermbg=235
hi ALEError ctermbg=red
hi ALEWarning ctermbg=gray


"************************************************************
"                         gui set                           "
"************************************************************
set guifont=SauceCodePro\ Nerd\ Font\ Mono\ 12
