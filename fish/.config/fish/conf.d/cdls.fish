set -q LS_AFTER_CD || set -xg LS_AFTER_CD true

function __ls_after_cd__on_variable_pwd --on-variable PWD
    if test "$LS_AFTER_CD" = true; and status --is-interactive
        # lsd --group-dirs first -Al
        eza --color=always --long --git --no-filesize --icons=always --no-time --no-user --no-permissions --group-directories-first
    end
end
