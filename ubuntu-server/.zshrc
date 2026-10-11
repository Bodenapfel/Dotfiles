# The following lines were added by compinstall
zstyle :compinstall filename '/root/.zshrc'

autoload -Uz compinit
compinit

# End of lines added by compinstall

# oh my zsh autoupdate config:
zstyle ':omz:update' mode auto


# Lines configured by zsh-newuser-install

HISTFILE=~/.histfile
HISTSIZE=1000
SAVEHIST=1000

# End of lines configured by zsh-newuser-install

# oh-my-zsh config:
export ZSH="$HOME/.oh-my-zsh"
ZSH_THEME=""
plugins=(git zsh-vi-mode tmux rust extract colored-man-pages)

source $ZSH/oh-my-zsh.sh

# yazi config:
function y() {
	local tmp="$(mktemp -t "yazi-cwd.XXXXXX")" cwd
	yazi "$@" --cwd-file="$tmp"
	IFS= read -r -d '' cwd < "$tmp"
	[ -n "$cwd" ] && [ "$cwd" != "$PWD" ] && builtin cd -- "$cwd"
	rm -f -- "$tmp"
}

# ls color config:
export LS_COLORS='di=01;34:ln=01;36:or=01;31:ex=01;32:fi=00:bd=40;33;01:cd=40;33;01:so=01;35:pi=40;33'

# custom prompt:
PROMPT='%F{cyan}%B%n@%m %~ 
>>%f%b '

# terminal config:
export TERM='xterm-256color'

# snap config:
export PATH=$PATH:/snap/bin

# enable nvm
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

# aliases:
alias motd='run-parts /etc/update-motd.d/'
alias fixperms='sudo chown -R 1000:1000 /srv/media/shows /srv/media/incoming'
alias sysupdate='sudo apt update && sudo apt upgrade -y && sudo apt autoremove -y && sudo apt autoclean -y'
alias update='sudo apt update && sudo apt upgrade -y'
alias cl='clear'
alias ampperms='sudo chown -R amp:amp /home/amp/.ampdata/'
alias code-server-update='curl -fsSL https://code-server.dev/install.sh | sh'
alias code='/snap/code/current/usr/share/code/bin/code'

codex() {
	if [ -n "$TMUX" ]; then
		command codex "$@"
		return
	fi

	local i session_name quoted_args
	i=1
	while tmux has-session -t "codex-$i" 2>/dev/null; do
		i=$((i + 1))
	done

	session_name="codex-$i"
	quoted_args="${(j: :)${(q)@}}"
	tmux new-session -s "$session_name" "command codex ${quoted_args}"
}

export EDITOR=/snap/bin/nvim
export VISUAL=/snap/bin/nvim
export PATH="$HOME/.local/bin:$PATH"
