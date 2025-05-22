#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return
function y() {
  local tmp="$(mktemp -t "yazi-cwd.XXXXXX")" cwd
  yazi "$@" --cwd-file="$tmp"
  IFS= read -r -d '' cwd <"$tmp"
  [ -n "$cwd" ] && [ "$cwd" != "$PWD" ] && builtin cd -- "$cwd"
  rm -f -- "$tmp"
}
alias ls='ls --color=auto'
alias grep='grep --color=auto'
# PS1='[\u@\h \W]\$ '
PS1='\W \$ '
alias hypr='hyprland'
alias windows='sudo grub-reboot 2 && sudo shutdown -r now' alias config='/usr/bin/git --git-dir=$HOME/dotfiles/ --work-tree=$HOME'
alias neofetch='fastfetch -c neofetch'
# fastfetch
