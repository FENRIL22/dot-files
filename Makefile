all:
	@echo "hoge"

init:
	ln -s $(CURDIR)/.vimrc ~/.vimrc
	ln -s $(CURDIR)/.gvimrc ~/.gvimrc
	ln -s $(CURDIR)/.eskk ~/.eskk
