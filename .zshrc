# The following lines were added by compinstall
zstyle :compinstall filename '/root/.zshrc'

autoload -Uz compinit
compinit

# End of lines added by compinstall

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

PROMPT='%F{153}%n@%m %~
>>%f '

# startup commands:
if [[ -z $NO_COWSAY ]]; then
  cowthink -f tux $(fortune -s)
fi

# aliases:
alias ls='ls --color=auto'
alias grep='grep --color=auto'
alias hypr='hyprland'
alias windows='sudo efibootmgr --bootnext 0000 && reboot'
alias config='/usr/bin/git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME'
alias clfetch='clear && fastfetch'
alias yay='paru'
alias hetzner='ssh root@188.34.196.140'
alias server='ssh dk@192.168.178.69'
alias ubumount='sshfs root@192.168.178.69:/ ~/remote'
alias minecraft='ssh minecraft@188.34.196.140'
alias mcmount='sshfs minecraft@188.34.196.140:/home/minecraft ~/remote2'
