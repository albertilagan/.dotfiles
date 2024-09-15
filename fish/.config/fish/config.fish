set fish_function_path $fish_function_path ~/.config/fish/github/plugin-foreign-env/functions

eval (/opt/homebrew/bin/brew shellenv)
eval (/run/current-system/sw/bin/direnv hook fish)
starship init fish | source
zoxide init fish | source

# source /Users/albertilagan/google-cloud-sdk/path.fish.inc

# fenv "[ -f ~/fubectl.source ] && source ~/fubectl.source"

fish_add_path ~/.config/bin
# fish_add_path ~/.nix-profile/bin
fish_add_path ~/.config/tmux/plugins/t-smart-tmux-session-manager/bin
fish_add_path ~/.locize-cli/bin
fish_add_path /opt/homebrew/opt/fzf/bin

set -U fish_greeting # disable fish greeting
set -U fish_key_bindings fish_vi_key_bindings
# set -U fish_key_bindings fish_default_key_bindings

set -Ux EDITOR nvim
set -Ux BAT_THEME Catppuccin-mocha
set -Ux VISUAL nvim
set -Ux SOPS_AGE_KEY_FILE "$HOME/.sops/medcheck-gatekeeper.txt"

abbr fishrc "nvim ~/.config/fish/config.fish"
abbr zshrc "nvim ~/.zshrc"
abbr vimrc "nvim ~/.config/nvim/"
abbr tmuxconf "nvim ~/.config/tmux/tmux.conf"

abbr c clear
abbr pn pnpm
abbr lf lfcd
abbr vim nvim
abbr lg lazygit
abbr v nvim
abbr ip "ifconfig en0 | grep inet | awk '{ print \$2 }'"
abbr nixf "nix --extra-experimental-features 'nix-command flakes'"
abbr nix-install "nix profile install --accept-flake-config nixpkgs#"

# abbr l "lsd --group-dirs first -A"
# abbr ls "lsd --group-dirs first -A"
# abbr ll "lsd --group-dirs first -Al"
# abbr lt "lsd --group-dirs last -A --tree"
alias l "eza --color=always --long --git --no-filesize --icons=always --no-time --no-user --no-permissions --group-directories-first"
alias ls "eza --color=always --long --git --no-filesize --icons=always --no-time --no-user --no-permissions --group-directories-first"
alias ll "eza --color=always --long --git --no-filesize --icons=always --no-time --no-user --no-permissions --group-directories-first"
alias cd "z"
alias gws "source ~/.dotfiles/sesh/.config/sesh/bin/nvim-w.sh"

# alias ccat "cat"
alias cat "bat --style=plain"
alias search "~/.dotfiles/scripts/search.sh"
alias nixd-reload "darwin-rebuild switch --flake ~/.config/nix-darwin"
alias nixd-config "nvim ~/.config/nix-darwin/flake.nix"

abbr p "pnpm run (jq -r '.scripts|to_entries[]|((.key))' package.json | fzf-tmux -p --border-label='pnpm run')"

abbr gfo "git fetch origin"
abbr gfa "git fetch --all"
abbr gfp "git fetch --prune"
abbr gc "git commit -m"
abbr gca "git commit -am"
abbr gco "git checkout"
abbr gcb "git checkout -b"
abbr gw "git worktree"
abbr gwa "git worktree add"
alias gs "git status"
alias gb "~/gsb.sh"
alias gshow "~/gshow.sh"

abbr core-proxy "cloud_sql_proxy -instances=analog-stage-198105:us-central1:core-replica=tcp:8912"

abbr sops "sops --in-place"
abbr k kubectl
abbr kctx kubectx
abbr kns kubens
abbr fr "flux reconcile"
abbr frk "flux reconcile kustomization"
abbr frhr "flux reconcile hr"
abbr kpf "kubectl port-forward"
abbr kg "kubectl get"
abbr kd "kubectl describe"

abbr ghcs "gh copilot suggest"
abbr ghce "gh copilot explain"

abbr da "direnv allow"

set -gx VOLTA_HOME "$HOME/.volta"
set -gx PATH "$VOLTA_HOME/bin" $PATH

# fzf

# fzf --fish | source
eval (fish_user_key_bindings)
eval (fzf_configure_bindings --git_status=\cg --history=\cr --variables=\cv --directory=\cd)

# fd
# set -Ux FZF_DEFAULT_COMMANDS "fd -H -E '.git'"
set -Ux FZF_TMUX_OPTS "-d 90%"
set -Ux FZF_DEFAULT_COMMAND "fd -u --strip-cwd-prefix --exclude .git"
set -Ux FZF_CTRL_T_COMMAND "$FZF_DEFAULT_COMMAND"
set -Ux FZF_ALT_C_COMMAND "fd --type d -u --strip-cwd-prefix --exclude .git"
set -Ux FZF_CTRL_T_OPTS "--preview 'bat -n --color=always --line-range :500 {}'"
set -Ux FZF_ALT_C_OPTS "--preview 'eza --tree --color=always {} | head -200'"
set -Ux FZF_DEFAULT_OPTS "\
  --reverse \
  --border rounded \
  --no-info \
  --pointer='👉' \
  --marker=' ' \
  --ansi \
  --color='16,bg+:-1,gutter:-1,prompt:5,pointer:5,marker:6,border:4,label:4,header:italic'"
set -Ux FZF_TMUX_OPTS "-p 55%,60%"
set -Ux FZF_CTRL_R_OPTS "--border-label=' history ' \
--prompt='  '"


function fzf_compgen_path
  fd --hidden --follow --exclude .git . $argv
end

function fzf_compgen_dir
  fd --type d --hidden --follow --exclude .git . $argv
end

# thefuck --alias | source
# thefuck --alias fk | source
# thefuck --alias fck | source

function set_openai_key
    set OPENAI_API_KEY (op read "op://Private/OpenRouterOpenAI/luxor" --account=my)
    set -Ux OPENAI_API_HOST "https://openrouter.ai/api/v1/chat/completions"
end

# set -xU KUBECONFIG "/Users/albertilagan/.kube/shoots/kubeconfig-admin-mj57vqlzxh"
# set -xU KUBECONFIG "$KUBECONFIG:/Users/albertilagan/.kube/shoots/kubeconfig-admin-sparta.yaml"
# eval (kubectl config view --merge --flatten > ~/.kube/config)
# set -xU KUBECONFIG "/Users/albertilagan/.kube/config"
#
