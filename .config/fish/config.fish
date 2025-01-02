alias refish "source ~/.config/fish/config.fish"
alias efish "vi ~/.config/fish/config.fish"
alias eghost "vi ~/.config/ghostty/config"
alias etmux "vi ~/.config/tmux/tmux.conf"
alias retmux "tmux source ~/.config/tmux/tmux.conf"
alias killdns "sudo killall -HUP mDNSResponder"
alias flushdns "sudo killall -HUP mDNSResponder"
alias y "yazi"
alias ls "eza --icons=always --group-directories-first"

# remove fish greeting
set -g fish_greeting

# add ghostty to the path if it exists
if test -d "/Applications/Ghostty.app/Contents/MacOS"
  fish_add_path "/Applications/Ghostty.app/Contents/MacOS"
end

# alias vi to use nvm
function vi
  nvim $argv
end

# Add dashes to a UUID without them
function fix-uuid
  pbpaste | sed 's|\([a-z0-9]\{8\}\)\([a-z0-9]\{4\}\)\([a-z0-9]\{4\}\)\([a-z0-9]\{4\}\)|\1-\2-\3-\4-|' | tee /dev/stderr | pbcopy 
end

# Remove dashes from a UUID with them
function unfix-uuid
  pbpaste | sed 's|-||g' | tee /dev/stderr | pbcopy
end

[ -f /usr/local/share/autojump/autojump.fish ]; and source /usr/local/share/autojump/autojump.fish

# Configure Homebrew
set -gx PATH $PATH /opt/homebrew/bin
set -gx HOMEBREW_NO_AUTO_UPDATE 1 # Make homebrew not update on every change

# Make vim the default editor
set -gx EDITOR nvim

# Support for local bins
set -gx PATH /Users/lalit/bin $PATH

# add node_module bin to path
set -gx PATH $PATH ./node_modules/.bin

# mise package manager
mise activate fish --shims | source

# enable starfish shell prompt
# https://github.com/starship/starship
starship init fish | source

# setup direnv
direnv hook fish | source

if status is-interactive
    # Commands to run in interactive sessions can go here
end

# The next line updates PATH for the Google Cloud SDK.
if test -f '/Users/lalit/google-cloud-sdk/path.fish.inc' 
  source '/Users/lalit/google-cloud-sdk/path.fish.inc'
end

if test -f 'Users/lalit/.cargo/env'
  source /Users/lalit/.cargo/env
end

set -gx PATH $PATH $HOME/.cargo/bin

# Alias 'cd' to 'zoxide' only in interactive sessions
if status is-interactive
  zoxide init --cmd cd fish | source
end

# fzf
fzf --fish | source

# pnpm
set -gx PNPM_HOME "/Users/lalit/Library/pnpm"
if not string match -q -- $PNPM_HOME $PATH
  set -gx PATH "$PNPM_HOME" $PATH
end
# pnpm end

# if we have a config in ~/.local for private things, source them now
if test -f ~/.local/fish/config.fish
    source ~/.local/fish/config.fish
end

# always be in a tmux session
if test "$TERM_PROGRAM" = "ghostty"; \
  or test "$TERM_PROGRAM" = "iTerm.app"; \
  or test "$TERM_PROGRAM" = "Apple_Terminal"
  if not set -q TMUX
    tmux has-session -t default 2>/dev/null
    if test $status -ne 0
      tmux new-session -s default -d
    end
    exec tmux attach-session -t default
  end
end

