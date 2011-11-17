#!/bin/bash

#SYSTEM ALIASES
alias updatedb="sudo /usr/libexec/locate.updatedb"
alias serve="python -m 'SimpleHTTPServer'"
alias rebash="source ~/.bashrc"
alias tidyxml="tidy -mi -xml --show-body-only true --show-warnings yes --vertical-space no --wrap 0 --markup yes"


#SYSTEM PATHS
export NODE_PATH="/usr/local/lib/node_modules"

#GLOBAL FUNCTIONS
function swap()         
{
    local TMPFILE=tmp.$$
    mv "$1" $TMPFILE
    mv "$2" "$1"
    mv $TMPFILE "$2"
}
