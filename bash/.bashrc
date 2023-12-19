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

export EDITOR="vim"
export GOPATH="/home/alex/Code"
PATH="$GOPATH/bin:$PATH"
export PATH

##########
# PROMPT #
##########

# Colors
C_TEXT="\033[0m"
C_PS1="\033[38;5;46m"
C_PS2="\033[38;5;208m"
C_PS1_CONTAINER="\033[38;5;208m"

# Toolbox check
if grep -q container /proc/self/cgroup; then
	export PS1="${C_PS1_CONTAINER}\h \\$ ${C_TEXT}"
else
	export PS1="${C_PS1}\\$ ${C_TEXT}"
fi
export PS2="${C_PS2}> ${C_TEXT}"

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

