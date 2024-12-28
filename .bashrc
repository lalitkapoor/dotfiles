source ~/.bash/prompt
source ~/.git-completion.bash

export HISTSIZE=1000000
export HISTTIMEFORMAT="%d/%m/%y %T "
shopt -s histappend
#export PROMPT_COMMAND="history -n; history -a; $PROMPT_COMMAND"
#export PROMPT_COMMAND="history -n; $PROMPT_COMMAND"
export PROMPT_COMMAND="$PROMPT_COMMAND"

export SVN_EDITOR=vi

#TEMINAL SETTNGS
#export PS1="\e[0;36m[\u@\h \W]\$ \e[m" #BASH PROMPT LINE COLOR
export INPUTRC=~/.inputrc

#save bash history on exit
shopt -s histappend


#SYSTEM ALIASES
alias tidyxml="tidy -mi -xml --show-body-only true --show-warnings yes --vertical-space no --wrap 0 --markup yes"
alias cueplit="mp3splt -o \"@n @A - @t\" -c"
alias git=/usr/local/bin/hub
alias sublime="open -a Sublime\ Text\ 2"

#SSH CONNECTIONS

#SYSTEM FUNCTIONS
alias updatedb="/usr/libexec/locate.updatedb"
alias removesvn="find . -regex '.*.svn' -exec rm -rf \"{}\" \;"
alias serve="python -m SimpleHTTPServer"
alias fdate="date \"+%Y-%m-%d-%H-%M-%S\""
alias targz="tar -cvzf"
alias sethostname="sudo scutil --set HostName"
alias ebash="vi /Users/lalit/.bashrc"
alias rebash="source /Users/lalit/.bashrc"
alias dockspacer="defaults write com.apple.dock persistent-apps -array-add '{tile-data={}; tile-type=\"spacer-tile\";}'"
alias hgunadd="hg rm -f"

#PATH RELATED
export TM_SUPPORT_PATH=/Applications/TextMate.app/Contents/SharedSupport/Support
export PYTHONPATH=$PYTHONPATH:/Users/lalit/projects/sharex-3rd-party/django-facebook:/Users/lalit/projects/viz/pylib:/Users/lalit/projects/sharex/zen
export PATH=$PATH:/usr/local/mongodb/bin:$HOME/local/node/bin:$HOME/local/coffee-script/bin:/Applications/typesafe-stack/bin:$TM_SUPPORT_PATH:/usr/local/mysql/bin
export JIRA_HOME=/Users/lalit/Applications/jira/home

#FUNCTIONS
pre () {
    echo -n '<pre style="word-wrap: break-word;">'
    perl -pe '$| = 1; s/&/&amp;/g; s/</&lt;/g; s/>/&gt;/g; s/$\\n/<br>/'
    echo '</pre>'
}

#set the title of the current window/tab
title(){
	echo -e "\033];"$1"\007"
}
