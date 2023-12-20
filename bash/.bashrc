# .bashrc

# Source global definitions
if [ -f /etc/bashrc ]; then
	. /etc/bashrc
fi


# User specific environment
if ! [[ "$PATH" =~ "$HOME/.local/bin:$HOME/.local/scripts:$HOME/.local/redhat-scripts:$HOME/bin:" ]]
then
	PATH="$HOME/.local/bin:$HOME/.local/scripts:$HOME/.local/redhat-scripts:$HOME/bin:$PATH"
fi

export GOPATH="/home/alex/Code"
export PATH="$GOPATH/bin:$PATH"

# It's a symbolic link to /usr/bin/nvim so it doesn't complain if I am in a container
export EDITOR="vim"

# User specific aliases and functions
if [ -d ~/.bashrc.d ]; then
	for rc in ~/.bashrc.d/*; do
		if [ -f "$rc" ]; then
			. "$rc"
		fi
	done
fi

unset rc

export PS1="\[\e[38;5;202m\]\h \[\e[38;5;131m\]\$ \[\033[0m\]"

# FZF: dnf install fzf -y
# Source only fzf bindings if the file exists. A common scenario is inside a container.
FZF_BINDINGS="/usr/share/fzf/shell/key-bindings.bash"
if [ -f $FZF_BINDINGS ]; then
	source $FZF_BINDINGS
fi

