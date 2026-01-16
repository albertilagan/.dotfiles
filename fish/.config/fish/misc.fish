abbr c clear
abbr pn pnpm
abbr lf lfcd
abbr vim nvim
abbr lg lazygit
abbr ip "ifconfig en0 | grep inet | awk '{ print \$2 }'"
abbr da "direnv allow"
abbr v nvim

# abbr docker "podman"
# alias docker "podman"
alias co "container"

alias sf superfile
alias v nvim

alias l "eza --color=always --long --git --no-filesize --icons=always --no-time --no-user --no-permissions --group-directories-first"
alias ls "eza --color=always --long --git --no-filesize --icons=always --no-time --no-user --no-permissions --group-directories-first"
alias ll "eza --color=always --long --git --no-filesize --icons=always --no-time --no-user --no-permissions --group-directories-first"

alias cat "bat --style=plain"
alias claudeyolo "claude --dangerously-skip-permissions"
alias nixd-reload "sudo darwin-rebuild switch --flake ~/.dotfiles/nix-darwin"
alias nixd-config "nvim ~/.dotfiles/nix-darwin/flake.nix"

abbr p "pnpm run (jq -r '.scripts|to_entries[]|((.key))' package.json | fzf-tmux -p --border-label='pnpm run')"
alias ssh-list='awk \'$1 == "Host" && $2 != "*" {host=$2} $1 == "HostName" {printf "%-15s %s\n", host, $2}\' ~/.ssh/config'
function sc
    set selected (awk '$1 == "Host" && $2 != "*" {host=$2} $1 == "HostName" {printf "%-15s %s\n", host, $2}' ~/.ssh/config | fzf --prompt="SSH to: " --height=40% --reverse)
    if test -n "$selected"
        set host (echo $selected | awk '{print $1}')
        echo "Connecting to $host..."
        ssh $host
    end
end
