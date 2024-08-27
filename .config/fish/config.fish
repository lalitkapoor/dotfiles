alias refish "source ~/.config/fish/config.fish"
alias efish "vi ~/.config/fish/config.fish"
alias killdns "sudo killall -HUP mDNSResponder"
alias flushdns "sudo killall -HUP mDNSResponder"

function vi
  nvim $argv
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

# enable starfish shell prompt
# https://github.com/starship/starship
starship init fish | source

# setup asdf - language version manager

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

# mise package manager
mise activate fish | source

# pnpm
set -gx PNPM_HOME "/Users/lalit/Library/pnpm"
if not string match -q -- $PNPM_HOME $PATH
  set -gx PATH "$PNPM_HOME" $PATH
end
# pnpm end
