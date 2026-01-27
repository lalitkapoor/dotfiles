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
    set -l is_detached "false"
    if test -z "$branch"
        set is_detached "true"
    end

    set -l branch (string replace -r '^lalitkapoor--' '' -- "$branch")
    set -l physical_repo_root "$repo_root"
    if command -q realpath
        set physical_repo_root (command realpath "$repo_root" 2>/dev/null)
    end

    set -l git_dir (command git rev-parse --git-dir 2>/dev/null)
    if test -n "$git_dir"
        if not string match -q '/*' -- "$git_dir"
            set git_dir "$repo_root/$git_dir"
        end
        if command -q realpath
            set git_dir (command realpath "$git_dir" 2>/dev/null)
        end
    end

    set -l common_dir (command git rev-parse --git-common-dir 2>/dev/null)
    if test -n "$common_dir"
        if not string match -q '/*' -- "$common_dir"
            set common_dir "$repo_root/$common_dir"
        end
        if command -q realpath
            set common_dir (command realpath "$common_dir" 2>/dev/null)
        end
    end

    set -l repo_name ""
    if test -n "$common_dir"
        set repo_name (basename (dirname "$common_dir"))
    else if test -n "$physical_repo_root"
        set repo_name (basename "$physical_repo_root")
    end

    if test -n "$git_dir"
        if string match -q '*worktrees/*' -- "$git_dir"
            set -l worktree_name (basename "$physical_repo_root")
            if test -n "$repo_name" -a -n "$worktree_name"
                if test "$is_detached" = "true"
                    command tmux rename-window "$repo_name/$worktree_name"
                else
                    set -l suffix " ($repo_name/$worktree_name)"
                    command tmux rename-window "$branch$suffix"
                end
                return
            end
        end
    end

    if test -n "$repo_name"
        if test "$is_detached" = "true"
            command tmux rename-window "$repo_name"
        else
            set -l suffix " ($repo_name)"
            command tmux rename-window "$branch$suffix"
        end
        return
    end

    if test "$is_detached" = "true"
        return
    end

    command tmux rename-window "$branch"
end

function __tmux_rename_git_window_on_pwd --on-variable PWD
    __tmux_rename_git_window
end

__tmux_rename_git_window
