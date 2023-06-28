alias zshrc="vim ~/.zshrc"
alias vimrc="vim ~/.config/nvim/"
alias tmuxconf="vim ~/.config/tmux/tmux.conf"
alias c="clear"
alias pn="pnpm"
alias ip="ifconfig en0 | grep inet | awk '{ print \$2 }'"
alias vim="nvim"
alias nix="nix --extra-experimental-features nix-command --extra-experimental-features flakes $@"
alias lg="lazygit"

if command -v exa > /dev/null; then
  alias ls="exa"
  alias ll="exa -alh"
  alias tree="exa --tree"
fi

if command -v bat > /dev/null; then
  alias cat="bat"
fi

# Nix
if [ -e '/nix/var/nix/profiles/default/etc/profile.d/nix-daemon.sh' ]; then
  . '/nix/var/nix/profiles/default/etc/profile.d/nix-daemon.sh'
fi
# End Nix

eval "$($HOME/.nix-profile/bin/starship init zsh)"
eval "$($HOME/.nix-profile/bin/direnv hook zsh)"
eval "$($HOME/.nix-profile/bin/zoxide init zsh)"

# zsh
export ZSH="$HOME/.oh-my-zsh"
plugins=(git zsh-autosuggestions zsh-syntax-highlighting web-search)
source $ZSH/oh-my-zsh.sh

export KUBECONFIG=$HOME/.kube/config
export PATH=$HOME/.config/tmux/plugins/t-smart-tmux-session-manager/bin:$PATH

[ -f ~/fubectl.source ] && source ~/fubectl.source

# fzf
export FZF_CTRL_R_OPTS="--reverse"
export FZF_TMUX_OPTS="-p"
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

source ~/.config/lf/lfcd.sh

# The next line updates PATH for the Google Cloud SDK.
if [ -f '/Users/albertilagan/google-cloud-sdk/path.zsh.inc' ]; then . '/Users/albertilagan/google-cloud-sdk/path.zsh.inc'; fi

# The next line enables shell command completion for gcloud.
if [ -f '/Users/albertilagan/google-cloud-sdk/completion.zsh.inc' ]; then . '/Users/albertilagan/google-cloud-sdk/completion.zsh.inc'; fi

