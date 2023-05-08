# .bashrc

# Source global definitions
if [ -f /etc/bashrc ]; then
	. /etc/bashrc
fi

# User specific environment
if ! [[ "$PATH" =~ "$HOME/.local/bin:$HOME/.local/scripts:$HOME/bin:" ]]
then
    PATH="$HOME/.local/bin:$HOME/.local/scripts:$HOME/bin:$PATH"
fi

export EDITOR="vim"
export GOPATH="/home/alex/Code"
PATH="$GOPATH/bin:$PATH"
export PATH
#export PS1="\[\e[38;5;34m\]\u\[\e[38;5;40m\]@\[\e[38;5;46m\]\h \[\e[38;5;154m\]\W \[\033[0m\]$ "
export PS1="\[\e[38;5;46m\]\\$ \[\033[0m\]"
export PS2="\[\e[38;5;208m\]> \[\033[0m\]"

# Uncomment the following line if you don't like systemctl's auto-paging feature:
# export SYSTEMD_PAGER=

# User specific aliases and functions
if [ -d ~/.bashrc.d ]; then
	for rc in ~/.bashrc.d/*; do
		if [ -f "$rc" ]; then
			. "$rc"
		fi
	done
fi

unset rc

source /usr/share/fzf/shell/key-bindings.bash

