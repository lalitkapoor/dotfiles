function __tmux_rename_git_window --description "Rename tmux window to git branch and repo name"
    if not status --is-interactive
        return
    end

    if not set -q TMUX
        return
    end

    if not command -q git
        return
    end

    if not command git rev-parse --show-toplevel >/dev/null 2>&1
        return
    end

    set -l repo_root (command git rev-parse --show-toplevel 2>/dev/null)

    set -l branch (command git branch --show-current 2>/dev/null)
    if test -z "$branch"
        return
    end

    set -l branch (string replace -r '^lalitkapoor--' '' -- "$branch")
    set -l physical_repo_root "$repo_root"
    if command -q realpath
        set physical_repo_root (command realpath "$repo_root" 2>/dev/null)
    end

    set -l repo_name (basename "$physical_repo_root")
    if test -n "$repo_name"
        set -l suffix " ($repo_name)"
        command tmux rename-window "$branch$suffix"
        return
    end

    command tmux rename-window "$branch"
end

function __tmux_rename_git_window_on_pwd --on-variable PWD
    __tmux_rename_git_window
end

__tmux_rename_git_window
