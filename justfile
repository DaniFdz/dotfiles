setup:
	fd -t d -x echo | tr -d './' | xargs stow
	chmod +x $HOME/.config/scripts/*
	
