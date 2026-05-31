export PATH="$HOME/.local/bin:$PATH"
export PATH="$HOME/.npm-packages/bin:$PATH"

# Default editor
export EDITOR="nvim"
export VISUAL="nvim"

# Point lazygit at stowed dotfile config (~/Library/Application Support is default on macOS)
export CONFIG_DIR="$HOME/.config/lazygit"

# Nix
if [ -e '/nix/var/nix/profiles/default/etc/profile.d/nix-daemon.sh' ]; then
  . '/nix/var/nix/profiles/default/etc/profile.d/nix-daemon.sh'
fi
# End Nix

eval "$(/run/current-system/sw/bin/starship init zsh)"
eval "$(/run/current-system/sw/bin/direnv hook zsh)"
eval "$(/run/current-system/sw/bin/zoxide init zsh)"

# zsh
bindkey -v
export KEYTIMEOUT=1

# Keep autosuggestions from accepting suggestions when pressing A in vim normal mode.
ZSH_AUTOSUGGEST_ACCEPT_WIDGETS=(${ZSH_AUTOSUGGEST_ACCEPT_WIDGETS:#vi-add-eol})

# Restore common macOS Option+Backspace sequences in vi insert mode.
bindkey -M viins '^[^?' backward-kill-word
bindkey -M viins '^[^H' backward-kill-word
bindkey -M viins '^W' backward-kill-word

# Use a custom A binding so zsh-autosuggestions cannot treat vi-add-eol as accept.
function vi-add-eol-no-suggest {
  CURSOR=${#BUFFER}
  zle vi-insert
}
zle -N vi-add-eol-no-suggest
bindkey -M vicmd 'A' vi-add-eol-no-suggest

function zle-keymap-select {
  case $KEYMAP in
    vicmd) echo -ne '\e[1 q' ;;
    viins|main) echo -ne '\e[5 q' ;;
  esac
}
zle -N zle-keymap-select

# export ZSH="$HOME/.oh-my-zsh"
# plugins=(git zsh-autosuggestions zsh-syntax-highlighting web-search)
# source $ZSH/oh-my-zsh.sh

export KUBECONFIG=$HOME/.kube/config
export PATH=$HOME/.config/tmux/plugins/t-smart-tmux-session-manager/bin:$PATH

[ -f ~/fubectl.source ] && source ~/fubectl.source

# fzf
export FZF_CTRL_R_OPTS="--reverse"
export FZF_TMUX_OPTS="-p"
export FZF_DEFAULT_OPTS="--reverse --border rounded --no-info --pointer='👉' --marker=' ' --ansi --color='16,bg+:-1,gutter:-1,prompt:5,pointer:5,marker:6,border:4,label:4,header:italic'"
export FZF_DEFAULT_COMMAND="fd -u --strip-cwd-prefix --exclude .git"
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
export FZF_ALT_C_COMMAND="fd --type d -u --strip-cwd-prefix --exclude .git"
export FZF_CTRL_T_OPTS="--preview 'bat -n --color=always --line-range :500 {}'"
export FZF_ALT_C_OPTS="--preview 'eza --tree --color=always {} | head -200'"
# [ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# source ~/.config/lf/lfcd.sh

# The next line updates PATH for the Google Cloud SDK.
# if [ -f '/Users/albertilagan/google-cloud-sdk/path.zsh.inc' ]; then . '/Users/albertilagan/google-cloud-sdk/path.zsh.inc'; fi

# The next line enables shell command completion for gcloud.
# if [ -f '/Users/albertilagan/google-cloud-sdk/completion.zsh.inc' ]; then . '/Users/albertilagan/google-cloud-sdk/completion.zsh.inc'; fi

export DISABLE_AUTO_TITLE="true"
unset PROMPT_COMMAND

# custom alias
alias zshrc="vim ~/.zshrc"
alias vimrc="vim ~/.config/nvim/"
alias tmuxconf="vim ~/.config/tmux/tmux.conf"
alias c="clear"
alias pn="pnpm"
alias ip="ifconfig en0 | grep inet | awk '{ print \$2 }'"
alias vim="nvim"
alias v="nvim"
alias nix="nix --extra-experimental-features nix-command --extra-experimental-features flakes $@"
alias lg="lazygit"
alias k="kubectl"

# alias ls="exa"
# alias ll="exa -alh"
alias ls="exa"
alias ll="exa -alh"
alias tree="exa --tree"

alias cat="bat"

sc() {
  local selected host
  selected=$(cat ~/.ssh/config ~/.ssh/config.d/* 2>/dev/null | awk '$1 == "Host" && $2 != "*" {host=$2} $1 == "HostName" {printf "%-15s %s\n", host, $2}' | fzf --prompt="SSH to: " --height=40% --reverse)
  if [[ -n "$selected" ]]; then
    host=$(echo "$selected" | awk '{print $1}')
    echo "Connecting to $host..."
    ssh "$host"
  fi
}

t() {
  sesh connect "$(
    sesh list -ictz | fzf-tmux -p 55%,60% \
      --no-sort --border-label ' sesh ' --prompt '⚡  ' \
      --header '  ^a all ^t tmux ^x zoxide ^g config ^d tmux kill ^f find' \
      --bind 'tab:down,btab:up' \
      --bind 'ctrl-a:change-prompt(⚡  )+reload(sesh list -i)' \
      --bind 'ctrl-t:change-prompt(🪟  )+reload(sesh list -it)' \
      --bind 'ctrl-g:change-prompt(⚙️  )+reload(sesh list -ic)' \
      --bind 'ctrl-x:change-prompt(📁  )+reload(sesh list -iz)' \
      --bind 'ctrl-f:change-prompt(🔎  )+reload(fd -H -d 2 -t d -E .Trash . ~)' \
      --bind 'ctrl-d:execute(tmux kill-session -t {})+change-prompt(⚡  )+reload(sesh list)'
  )"
}

# Added by GitButler installer
eval "$(but completions zsh)"
eval "$(~/.local/bin/mise activate zsh)"

# opencode
export PATH=/Users/albert/.opencode/bin:$PATH
