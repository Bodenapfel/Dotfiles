
# The following lines were added by compinstall
zstyle :compinstall filename '/root/.zshrc'

autoload -Uz compinit
compinit

# End of lines added by compinstall

# Lines configured by zsh-newuser-install

HISTFILE=~/.histfile
HISTSIZE=1000
SAVEHIST=1000
bindkey -v

# End of lines configured by zsh-newuser-install
PS1='%1~ %# '

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

# aliases:
alias ls='ls --color=auto'
alias grep='grep --color=auto'
alias hypr='hyprland'
alias windows='sudo grub-reboot 2 && sudo shutdown -r now' alias config='/usr/bin/git --git-dir=$HOME/dotfiles/ --work-tree=$HOME'
alias neofetch='fastfetch -c neofetch'

# startup commands:
if [[ -z $NO_COWSAY ]]; then
  cowthink -f tux $(fortune -s)
fi
