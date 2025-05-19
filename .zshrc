
# The following lines were added by compinstall
zstyle :compinstall filename '/home/dk/.zshrc'

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
# aliases:
alias hypr='hyprland'
alias windows='sudo grub-reboot 2 && sudo shutdown -r now' alias config='/usr/bin/git --git-dir=$HOME/dotfiles/ --work-tree=$HOME'
alias neofetch='fastfetch -c neofetch'
# startup commands:
cowthink -f tux $(fortune -s)

