alias ga "git add ."
abbr ga "git add ."
alias gc "git commit"
abbr gc "git commit"
abbr gpl "git pull"
abbr gp "git push"
abbr gfo "git fetch origin"
abbr gfa "git fetch --all"
abbr gfp "git fetch --prune"
abbr gca "git commit -am"
abbr gco "git checkout"
abbr gcb "git checkout -b"
abbr gw "git worktree"
abbr gwa "git worktree add"
alias gcopy "git log -1 --pretty=format:\"%H\" | pbcopy ."
alias gs "git st"
abbr ghcs "gh copilot suggest"
abbr ghce "gh copilot explain"
alias lola "git log --graph --decorate --pretty=oneline --abbrev-commit --all"

function gfu                                              
    git fetch upstream
    git merge upstream/$argv
end
