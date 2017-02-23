"フォントsetting
":echo &guifontで確認出来る

if has("mac")
    " mac用の設定
    set guifont=Menlo\ Regular:h16
    " キーマッピング(\をダイレクトに入力)
    "noremap! ¥ \
    "noremap! \ ¥
elseif has("unix")
    " unix固有の設定
    set guifont=MyricaM\ M\ 15
    "set guifont=Monospace\ 18
endif

" ツールバーを削除
" for gvim
set guioptions-=T

"カーソルの点滅を抑制
"for macvim
set guicursor=a:blinkon0

"メニューを削除
"set guioptions-=m
