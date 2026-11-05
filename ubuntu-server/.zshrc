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
PROMPT='%F{166}%B%n@%m %~ 
>>%f%b '

# terminal config:
export TERM='xterm-256color'

# snap config:
export PATH=$PATH:/snap/bin

# Load NVM only when a Node command is first used.
export NVM_DIR="$HOME/.nvm"
_load_nvm() {
    [[ ${_NVM_LOADED:-0} == 1 ]] && return 0
    if [[ ! -s "$NVM_DIR/nvm.sh" ]]; then
        print -u2 "NVM initialization file not found: $NVM_DIR/nvm.sh"
        return 1
    fi
    unfunction nvm node npm npx corepack 2>/dev/null
    source "$NVM_DIR/nvm.sh" || return
    typeset -g _NVM_LOADED=1
    [[ ! -s "$NVM_DIR/bash_completion" ]] || source "$NVM_DIR/bash_completion"
    return 0
}
nvm() { _load_nvm && nvm "$@"; }
node() { _load_nvm && command node "$@"; }
npm() { _load_nvm && command npm "$@"; }
npx() { _load_nvm && command npx "$@"; }
corepack() { _load_nvm && command corepack "$@"; }

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
	_load_nvm || return
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
export PATH="$HOME/bin:$PATH"
