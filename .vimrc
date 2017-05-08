"""""""""""
"" Vimrc 
"""""""""""
" "->"は左のキーを押してから右のキーを押す
" z->oでカーソル下の折り畳み(Folding)を開く
" z->cでカーソル下の再度折り畳み
" z->rで全foldを1段階開く
" z->mで閉じる
" z->Rで全て開く
" z->Mで全て閉じる

"" vim-plug settings {{{1
if has('vim_starting')
  set rtp+=~/.vim/plugged/vim-plug
  if !isdirectory(expand('~/.vim/plugged/vim-plug'))
    echo 'install vim-plug...'
    call system('mkdir -p ~/.vim/plugged/vim-plug')
    call system('git clone https://github.com/junegunn/vim-plug.git ~/.vim/plugged/vim-plug/autoload')
  end
endif

"" plugin auto install {{{2
"function! s:plug.check_installation()
"  if empty(self.plugs)
"    return
"  endif
"
"  let list = []
"  for [name, spec] in items(self.plugs)
"    if !isdirectory(spec.dir)
"      call add(list, spec.uri)
"    endif
"  endfor
"
"  if len(list) > 0
"    let unplugged = map(list, 'substitute(v:val, "^.*github\.com/\\(.*/.*\\)\.git$", "\\1", "g")')
"
"    " Ask whether installing plugs like NeoBundle
"    echomsg 'Not installed plugs: ' . string(unplugged)
"    if confirm('Install plugs now?', "yes\nNo", 2) == 1
"      PlugInstall
"      " Close window for vim-plug
"      silent! close
"      " Restart vim
"      silent! !vim
"      quit!
"    endif
"
"  endif
"endfunction
"
"augroup check-plug
"  autocmd!
"  autocmd VimEnter * if !argc() | call s:plug.check_installation() | endif
"augroup END



"" Color Scheme {{{ 1
"NeoBundle 'w0ng/vim-hybrid'
"NeoBundle 'vim-scripts/Wombat'
"
"

"" Plugins {{{1
call plug#begin('~/.vim/plugged')
	" Plugs(nosetting) {{{2
	Plug 'junegunn/vim-plug',
        \ {'dir': '~/.vim/plugged/vim-plug/autoload'}
	Plug 'itchyny/lightline.vim'
	Plug 'tpope/vim-fugitive'
	Plug 'kmnk/vim-unite-giti'
	Plug 'Shougo/vimproc.vim', { 'dir': '~/.vim/plugged/vimproc.vim', 'do': 'make' }
	Plug 'Shougo/unite.vim'
	" NeoCompCache {{{2
	Plug 'Shougo/neocomplcache'
	" config {{{3
	" Disable AutoComplPop.
	let g:acp_enableAtStartup = 0
	" Use neocomplcache.
	let g:neocomplcache_enable_at_startup = 1
	" Use smartcase.
	let g:neocomplcache_enable_smart_case = 1
	" Set minimum syntax keyword length.
	let g:neocomplcache_min_syntax_length = 3
	let g:neocomplcache_lock_buffer_name_pattern = '\*ku\*'
	
	" Define dictionary.
	let g:neocomplcache_dictionary_filetype_lists = {
	    \ 'default' : ''
	    \ }
	
	" key-mapping {{{3
	inoremap <expr><C-g>     neocomplcache#undo_completion()
	inoremap <expr><C-l>     neocomplcache#complete_common_string()
	
	" function {{{3
	" <CR>: close popup and save indent.
	inoremap <silent> <CR> <C-r>=<SID>my_cr_function()<CR>
	function! s:my_cr_function()
	  return neocomplcache#smart_close_popup() . "\<CR>"
	endfunction
	" <TAB>: completion.
	inoremap <expr><TAB>  pumvisible() ? "\<C-n>" : "\<TAB>"
	" <C-h>, <BS>: close popup and delete backword char.
	inoremap <expr><C-h> neocomplcache#smart_close_popup()."\<C-h>"
	inoremap <expr><BS> neocomplcache#smart_close_popup()."\<C-h>"
	inoremap <expr><C-y>  neocomplcache#close_popup()
	inoremap <expr><C-e>  neocomplcache#cancel_popup()

	" Quickrun {{{2
	Plug 'thinca/vim-quickrun'
	Plug 'osyo-manga/unite-quickfix'
	Plug 'osyo-manga/shabadou.vim'
	" config
	" present {{{3
	"" runner : 非同期実行のためvimprocを指定
	"" updatetime: 大きすぎる値は設定しない方が良い
	"" hook/shabadubi~ : 実行中アニメーションを表示
	"" hook/shabadubi~ : アニメーションタイミング(大->遅い)
	"" enable_hook_loaded:" unite-quickfix を閉じる用
	"" enable_failure : 失敗した場合に unite-quickfix を起動させる
	"" enable_exit : 成功の有無にかかわらずquickfixを閉じる
	"" enable_failure : 失敗時にbufferを閉じる
	"" enable_empty_data : bufferが空の時にbufを閉じる
	"" outputter : 複数の outputter へと出力
	"" tex (texファイル設定)
	"" cmdopt  : コマンドに渡すオプション
	"" exec    : 実行するコマンド
	"" split : 下に開く設定
	" status {{{3
	let g:quickrun_config = {
	    \   "_": {
		\ 'runner'    : 'vimproc',
		\ 'runner/vimproc/updatetime' : 60,
		\ 'split': 'vertical',
		\ "hook/shabadoubi_touch_henshin/enable" : 1,
		\ "hook/shabadoubi_touch_henshin/wait" : 10,
		\ "hook/close_unite_quickfix/enable_hook_loaded" : 1,
		\ "hook/unite_quickfix/enable_failure" : 1,
		\ "hook/close_quickfix/enable_exit" : 1,
		\ "hook/close_buffer/enable_failure" : 1,
		\ "hook/close_buffer/enable_empty_data" : 1,
		\ "outputter" : "multi:buffer:quickfix",
		\   },
	    \   'tex':{
		\ 'command' : 'make',
		\ 'split': '4sp',
		\ 'outputter': 'error',
		\ 'outputter/error/success': 'null',
		\ 'outputter/error/error': 'quickfix',
		\ 'exec': ['%c'],
		\   },
	    \   'cpp':{
		\   'command': 'g++',
		\   'cmdopt': '-std=c++11'
		\   },
	    \ }
	


	" command {{{3
	" 横分割時は下へ､ 縦分割時は右へ新しいウィンドウが開くようにする
	set splitbelow
	set splitright

	"" key config {{{3
	" 標準のショートカットを無効とする
	let g:quickrun_no_default_key_mappings = 1

	"\r でquickfixを閉じて、保存してからquickrunを実行する。
	nnoremap \r :cclose<CR>:write<CR>:QuickRun -mode n<CR>
	xnoremap \r :<C-U>cclose<CR>:write<CR>gv:QuickRun -mode v<CR>
	"上のmac対応
	nnoremap ¥r :cclose<CR>:write<CR>:QuickRun -mode n<CR>
	xnoremap ¥r :<C-U>cclose<CR>:write<CR>gv:QuickRun -mode v<CR>
	" nnoremap \r :!make -j ../Makefile<CR><CR>

	" <C-c> でquickrunを停止
	nnoremap <expr><silent> <C-c> quickrun#is_running() ? quickrun#sweep_sessions() : "\<C-c>"


	" Previm and open-browser {{{2
	Plug 'tyru/open-browser.vim'
	" rich previm
	Plug 't3nro/previm-KaTeX'
	" config
	augroup PrevimSettings
	    autocmd!
	    autocmd BufNewFile,BufRead *.{md,mdwn,mkd,mkdn,mark*} set filetype=markdown
	augroup END

	" eskk.vim {{{2
	"Plug 'tyru/eskk.vim'
	" coifig
	""内部のIM(eskk.vim)を優先させる
	"これは+ximをコンパイルオプションとして指定すると可能
	"set imdisable
	""辞書設定
	"let g:eskk#directory = "~/.eskk"
	"let g:eskk#dictionary = { 'path': "~/.skk-jisyo", 'sorted': 0, 'encoding': 'utf-8', }
	"let g:eskk#large_dictionary = { 'path': "~/.eskk/SKK-JISYO.L", 'sorted': 1, 'encoding': 'euc-jp', }
	""補完関係
	"let g:eskk#enable_completion = 1
	"let g:eskk#max_candidates = 3
	"let g:eskk#tab_select_completion = 1
	""開業制御
	""let g:eskk#egg_like_newline_completion = 1
	"" 状態の保存(insert->normal->insertの時にimeの状態が同じ
	"let g:eskk#keep_state = 1

	"let g:eskk#server = {
	"\   'host': 'localhost',
	"\   'port': 1143,
	"\}

	" >skk.vim {{{2
	Plug 'tyru/skk.vim'
	"config
	map! <C-j> <Plug>(skk-toggle-im)
	let g:skk_large_jisyo = expand('~/.eskk/SKK-JISYO.L')
	let g:skk_auto_save_jisyo = 1
	let g:skk_keep_state = 1
	let g:skk_kutouten_type = "en"
	set imdisable
	" >ColorScheme
	Plug 'w0ng/vim-hybrid'
	Plug 'vim-scripts/Wombat'

" endPlugs{{{2
call plug#end()


" My_Setting {{{1
" ファイルタイプ別のプラグイン/インデントを有効にする
" 今はとりあえず保留
"filetype plugin indent on
set autoindent
set tabstop=4
set shiftwidth=4
" Tabをスペースで表現する.解除する時はnoexpandtab
"set expandtab
" [Backspace] で既存の文字を削除できるように設定
"  start - 既存の文字を削除できるように設定
"  eol - 行頭で[Backspace]を使用した場合上の行と連結
"  indent - オートインデントモードでインデントを削除できるように設定

" シンタックスハイライト有効化 (背景黒向け。白はコメントアウトされている設定を使用)
syntax on
" For Linux user! Mac ?
"let g:hybrid_use_Xresources = 1
set background=dark
colorscheme hybrid
set t_Co=256
" For White Theme Color
"highlight Normal ctermbg=black ctermfg=white
""highlight StatusLine term=none cterm=none ctermfg=darkgray ctermbg=grey
"highlight CursorLine term=none cterm=none ctermfg=none ctermbg=darkgray
""highlight Normal ctermbg=grey ctermfg=black
"highlight StatusLine term=none cterm=none ctermfg=grey ctermbg=black
""highlight CursorLine term=none cterm=none ctermfg=darkgray ctermbg=none

set backspace=start,eol,indent

" 特定のキーに行頭および行末の回りこみ移動を許可する設定
"  b - [Backspace]  ノーマルモード ビジュアルモード
"  s - [Space]      ノーマルモード ビジュアルモード
"   - [→]          ノーマルモード ビジュアルモード
"  [ - [←]          挿入モード 置換モード
"  ] - [→]          挿入モード 置換モード
"  ~ - ~            ノーマルモード
set whichwrap=b,s,[,],,~

" マウス機能有効化
set mouse=a
set nohlsearch " 検索キーワードをハイライトしないように設定
set cursorline " カーソルラインの強調表示を有効化
" 行番号を表示
set number
" 相対行番号を表示(number設定でカーソル行が絶対行表示)
set relativenumber

" ステータスラインを表示
set laststatus=2 " ステータスラインを常に表示
set statusline=%F%r%h%= " ステータスラインの内容

if has("mac")
" mac用の設定
" キーマッピング(\をダイレクトに入力)
"noremap! ¥ \
"noremap! \ ¥
elseif has("unix")
" unix固有の設定
endif



" インクリメンタル検索を有効化
"set incsearch
" 補完時の一覧表示機能有効化
"set wildmenu wildmode=list:full
" 自動的にファイルを読み込むパスを設定 ~/.vim/userautoload/*vim


"" vimrc compaction setting {{{1
"
"" モードラインを有効にする
"set modeline
"" 3行目までをモードラインとして検索する
"set modelines=3
"
"" vim: foldmethod=marker
"" vim: foldcolumn=3
"" vim: foldlevel=0
