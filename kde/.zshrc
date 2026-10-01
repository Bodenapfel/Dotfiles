# ──────────────────────────────────────────────
# Oh My Zsh
# ──────────────────────────────────────────────

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
HISTSIZE=10000
SAVEHIST=10000


# ──────────────────────────────────────────────
# Aliases
# ──────────────────────────────────────────────

alias ll="ls -l"
alias update="sudo nixos-rebuild switch"
alias hypr="start-hyprland"
alias clfetch="clear && fastfetch"

alias server="ssh dk@192.168.105.118"

alias ubumount='sshfs root@192.168.105.118:/ ~/remote/root@ubuntu'
alias dkmount='sshfs dk@192.168.105.118:/home/dk/ ~/remote/dk@ubuntu'
alias media='sshfs dk@192.168.105.118:/data/ ~/remote/media'

alias cpfonts='sudo rm -rf "$HOME/.local/share/fonts"; mkdir -p "$HOME/.local/share/fonts" && cp -L /run/current-system/sw/share/X11/fonts/* "$HOME/.local/share/fonts/"'
alias tailget='sudo tailscale file get ~/Downloads'


# ──────────────────────────────────────────────
# Yazi
# ──────────────────────────────────────────────

# Run yazi and cd into the directory you exited from.
y() {
  local tmp cwd

  tmp="$(mktemp -t 'yazi-cwd.XXXXXX')" || return

  yazi "$@" --cwd-file="$tmp"

  IFS= read -r cwd < "$tmp"

  if [[ -n "$cwd" && "$cwd" != "$PWD" ]]; then
    builtin cd -- "$cwd"
  fi

  rm -f -- "$tmp"
}


# ──────────────────────────────────────────────
# Prompt
# ──────────────────────────────────────────────

PROMPT='%F{blue}%B%n@%m %~
>>%f%b '


# ──────────────────────────────────────────────
# Startup
# ──────────────────────────────────────────────

if [[ -z "$NO_COWSAY" ]]; then
  cowthink -f tux "$(fortune -s)"
fi


# ──────────────────────────────────────────────
# Environment Variables
# ──────────────────────────────────────────────

export EDITOR=nvim
export VISUAL=nvim


# >>> Codex installer >>>
export PATH="/home/dk/.local/bin:$PATH"
# <<< Codex installer <<<


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
