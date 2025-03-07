# .bashrc

# Source global definitions
if [ -f /etc/bashrc ]; then
	. /etc/bashrc
fi


# User specific environment
export GOPATH="$HOME/Code"
if ! [[ "$PATH" =~ "$HOME/.local/bin:$HOME/.local/scripts:$GOPATH/bin:$HOME/bin:" ]]; then
	PATH="$HOME/.local/bin:$HOME/.local/scripts:$GOPATH/bin:$HOME/bin:$PATH"
fi
export PATH


# It's a symbolic link to /usr/bin/nvim so it doesn't complain if I am in a container:
# sudo dnf remove vim-enhanced -y
# sudo ln -s /usr/bin/nvim /usr/bin/vim
export EDITOR="vim"
alias vimdiff="nvim -d"
alias vim-clean="nvim --clean"

# User specific aliases and functions
if [ -d ~/.bashrc.d ]; then
	for rc in ~/.bashrc.d/*; do
		if [ -f "$rc" ]; then
			. "$rc"
		fi
	done
fi

unset rc

# Configure the prompt, it requires stuff from .bashrc.d
# You can use 5;number for the 256 color chart or 2;R;G;Bm 
export PS1="\[\e[38;2;248;134;130m\]\`toolbox_info\`\[\e[38;2;166;205;119m\]\$ \[\033[0m\]"

# FZF: dnf install fzf -y
# Source only fzf bindings if the file exists. A common scenario is inside a container.
FZF_BINDINGS="/usr/share/fzf/shell/key-bindings.bash"
if [ -f $FZF_BINDINGS ]; then
	source $FZF_BINDINGS
fi

. "$HOME/.cargo/env"

export OPENAI_API_KEY=$( jq -r '.openai' /home/alex/.config/io.datasette.llm/keys.json )
export ELECTRON_OZONE_PLATFORM_HINT=auto

