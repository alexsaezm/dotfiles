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
export GOPATH="/home/alex/Developer"
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

alias tmux="tmux attach"
unset rc

# This is a set of shortcuts in Bash to work with git faster
is_in_git_repo() {
  git rev-parse HEAD > /dev/null 2>&1
}

gf() {
  is_in_git_repo &&
    git -c color.status=always status --short |
    fzf --height 40% -m --ansi --nth 2..,.. | awk '{print $2}'
}

gb() {
  is_in_git_repo &&
    git branch -a -vv --color=always | grep -v '/HEAD\s' |
    fzf --height 40% --ansi --multi --tac | sed 's/^..//' | awk '{print $1}' |
    sed 's#^remotes/[^/]*/##'
}

gt() {
  is_in_git_repo &&
    git tag --sort -version:refname |
    fzf --height 40% --multi
}

gl() {
  is_in_git_repo &&
    git log --date=short --format="%C(green)%C(bold)%cd %C(auto)%h%d %s (%an)" --graph |
    fzf --height 40% --ansi --no-sort --reverse --multi | grep -o '[a-f0-9]\{7,\}'
}

gr() {
  is_in_git_repo &&
    git remote -v | awk '{print $1 " " $2}' | uniq |
    fzf --height 40% --tac | awk '{print $1}'
}

bind '"\er": redraw-current-line'
bind '"\C-g\C-f": "$(gf)\e\C-e\er"'
bind '"\C-g\C-b": "$(gb)\e\C-e\er"'
bind '"\C-g\C-t": "$(gt)\e\C-e\er"'
bind '"\C-g\C-l": "$(gl)\e\C-e\er"'
bind '"\C-g\C-r": "$(gr)\e\C-e\er"'

source /usr/share/fzf/shell/key-bindings.bash
