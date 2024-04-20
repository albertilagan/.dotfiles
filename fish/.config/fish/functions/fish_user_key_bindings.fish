function fish_user_key_bindings
  /opt/homebrew/opt/fzf/bin/fzf --fish | source
end

function t
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
end
