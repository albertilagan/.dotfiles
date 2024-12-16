eval (fish_user_key_bindings)
eval (fzf_configure_bindings --git_status=\cg --history=\cr --variables=\cv --directory=\cd)

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

