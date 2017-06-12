all:
	@echo "Usage:"
	@echo "init:"
	@echo "clean:"

init:
	ln -s $(CURDIR)/.vimrc ~/.vimrc
	ln -s $(CURDIR)/.gvimrc ~/.gvimrc
	ln -s $(CURDIR)/.eskk ~/.eskk

clean:
	rm ~/.vimrc
	rm ~/.gvimrc
	rm ~/.eskk
