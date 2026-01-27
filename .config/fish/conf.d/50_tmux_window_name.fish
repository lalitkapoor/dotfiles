function __tmux_rename_git_window --description "Rename tmux window to git branch"
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
    set -l slot_name ""
    set -l physical_repo_root "$repo_root"
    if command -q realpath
        set physical_repo_root (command realpath "$repo_root" 2>/dev/null)
    end

    set -l common_dir (command git rev-parse --git-common-dir 2>/dev/null)
    if test -n "$common_dir"
        if not string match -q '/*' -- "$common_dir"
            set common_dir "$repo_root/$common_dir"
        end
    end

    set -l physical_common_dir "$common_dir"
    if test -n "$physical_common_dir" -a -n "$common_dir" -a (command -q realpath)
        set physical_common_dir (command realpath "$common_dir" 2>/dev/null)
    end

    if test -n "$physical_common_dir" -a -n "$physical_repo_root"
        if not string match -q -- "$physical_repo_root/*" "$physical_common_dir"
            set slot_name (basename "$physical_repo_root")
        end
    end

    if test -n "$slot_name"
        set -l slot " ($slot_name)"
        command tmux rename-window "$branch$slot"
        return
    end

    command tmux rename-window "$branch"
end

function __tmux_rename_git_window_on_pwd --on-variable PWD
    __tmux_rename_git_window
end

__tmux_rename_git_window
