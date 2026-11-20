# Command search path
typeset -U path
path=("$HOME/.opencode/bin" "$HOME/.local/bin" "${path[@]}" /usr/sbin)
export PATH

# ──────────────────────────────────────────────
# Oh My Zsh
# ──────────────────────────────────────────────

# auto update omz
zstyle ':omz:update' mode auto
# silently update omz
# zstyle ':omz:update' verbose silent

export ZSH="$HOME/.oh-my-zsh"

ZSH_THEME=""

plugins=(
  git
  tmux
  rust
  extract
  colored-man-pages
  zsh-vi-mode
)

source "$ZSH/oh-my-zsh.sh"

# ──────────────────────────────────────────────
# History
# ──────────────────────────────────────────────

HISTFILE="$HOME/.zsh_history"
HISTSIZE=50000
SAVEHIST=10000


# ──────────────────────────────────────────────
# Aliases
# ──────────────────────────────────────────────

alias ll="ls -l"
alias update='sudo zypper refresh && sudo zypper dup && flatpak update --user -y && sudo flatpak update --system -y'
alias hypr="start-hyprland"
alias clfetch="clear && fastfetch"

alias server="ssh dk@192.168.105.118"

alias ubumount='sshfs root@192.168.105.118:/ ~/remote/root@ubuntu'
alias dkmount='sshfs dk@192.168.105.118:/home/dk/ ~/remote/dk@ubuntu'
alias media='sshfs dk@192.168.105.118:/data/ ~/remote/media'

# only for nixos, unsafe for fedora
# alias cpfonts='sudo rm -rf "$HOME/.local/share/fonts"; mkdir -p "$HOME/.local/share/fonts" && cp -L /run/current-system/sw/share/X11/fonts/* "$HOME/.local/share/fonts/"'
alias tailget='tailscale file get ~/Downloads'
alias python='python3'


# ──────────────────────────────────────────────
# Yazi
# ──────────────────────────────────────────────

# Run yazi and cd into the directory you exited from.
y() {
  local tmp cwd
  local status_code=0

  tmp="$(mktemp -t 'yazi-cwd.XXXXXX')" || return

  {
    yazi "$@" --cwd-file="$tmp" || status_code=$?
    if (( status_code == 0 )); then
      IFS= read -r cwd < "$tmp"
      if [[ -n "$cwd" && "$cwd" != "$PWD" ]]; then
        builtin cd -- "$cwd" || status_code=$?
      fi
    fi
  } always {
    rm -f -- "$tmp"
  }

  return "$status_code"
}


# ──────────────────────────────────────────────
# Prompt
# ──────────────────────────────────────────────

autoload -Uz vcs_info add-zsh-hook
add-zsh-hook precmd vcs_info

zstyle ':vcs_info:*' enable git
zstyle ':vcs_info:git:*' check-for-changes true
zstyle ':vcs_info:git:*' stagedstr '+'
zstyle ':vcs_info:git:*' unstagedstr '*'
zstyle ':vcs_info:git:*' formats ' (%b%c%u)'
zstyle ':vcs_info:git:*' actionformats ' (%b%c%u|%a)'

setopt prompt_subst
PROMPT='%F{76}%B%n@%m %~${vcs_info_msg_0_}
>>%f%b '


# ──────────────────────────────────────────────
# Startup
# ──────────────────────────────────────────────

if [[ -z "$NO_COWSAY" ]] &&
   (( $+commands[cowthink] && $+commands[fortune] )); then
  cowthink -f tux "$(fortune -s)"
fi


# ──────────────────────────────────────────────
# Environment Variables
# ──────────────────────────────────────────────

export EDITOR=nvim
export VISUAL=nvim




# misc

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

# opensuse command not found handler
command_not_found_handler() {
    local cnf_bin=${COMMAND_NOT_FOUND_BIN:-/usr/bin/cnf}
    if [[ -x "$cnf_bin" ]]; then
        "$cnf_bin" "${(Q)1}"
    fi
    return 127
}

