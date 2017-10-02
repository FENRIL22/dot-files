all:
	@echo "Usage:"
	@echo "init:"
	@echo "clean:"

init:
	ln -s $(CURDIR)/.vimrc ~/.vimrc
	ln -s $(CURDIR)/.gvimrc ~/.gvimrc
	ln -s $(CURDIR)/.eskk ~/.eskk
	ln -s $(CURDIR)/.tmux.conf ~/.tmux.conf
	
	@echo "" >> ~/.bashrc
	@echo "# auto created by init script" >> ~/.bashrc
	@echo "source $(CURDIR)/.bashrc_ref" >> ~/.bashrc
	@echo "" >> ~/.bashrc
	
	@echo "" >> ~/.bash_profile
	@echo "# auto created by init script" >> ~/.bash_profile
	@echo "source ~/.bashrc" >> ~/.bash_profile
	@echo "source $(CURDIR)/.bash_profile_ref" >> ~/.bash_profile
	@echo "" >> ~/.bash_profile

clean:
	rm ~/.vimrc
	rm ~/.gvimrc
	rm ~/.eskk
	rm ~/.tmux.conf
	@echo "Please rm source $(CURDIR)/.bashrc_ref in .bashrc"
	@echo "Pleaes rm source $(CURDIR)/.bash_profile_ref in .bash_profile"
