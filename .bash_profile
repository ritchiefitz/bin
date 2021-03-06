homebrew=/usr/local/bin:/usr/local/sbin:/Users/ritchiefitzgerald/bin:
export PATH=$homebrew:$PATH:/Users/ritchiefitzgerald/Downloads/adt-bundle-mac-x86_64-20140321/sdk/tools:/Users/ritchiefitzgerald/Downloads/adt-bundle-mac-x86_64-20140321/sdk/platform-tools:

SSH_ENV=$HOME/.ssh/environment

# start the ssh-agent
function start_agent {
    echo "Initializing new SSH agent..."
    # spawn ssh-agent
    /usr/bin/ssh-agent | sed 's/^echo/#echo/' > "${SSH_ENV}"
    echo succeeded
    chmod 600 "${SSH_ENV}"
    . "${SSH_ENV}" > /dev/null
    /usr/bin/ssh-add
}

if [ -f "${SSH_ENV}" ]; then
    . "${SSH_ENV}" > /dev/null
    ps -ef | grep ${SSH_AGENT_PID} | grep ssh-agent$ > /dev/null || {
        start_agent;
    }
else
    start_agent;
fi

alias cl="clear"
alias ll="ls -l"
alias subl="subl ."
alias brc="source ~/.bash_profile"
alias updatedb="sudo /usr/libexec/locate.updatedb"
alias delDS="find . -name '*.DS_Store' -type f -delete"
alias gitshc="git show --pretty=\"format:\" --name-only "

PS1="\[\e[1;32m\]\u:\[\e[00m\]\[\e[1;33m\]\w\[\e[00m\] \[\e[1;32m\]\$\[\e[00m\] "

function c() {
    # IFS breaks on spaces. Change it.
    SAVEIFS=$IFS
    IFS=$(echo -e '\n\b')

    if [[ $2 ]]; then
        testd=`cruby $1 $2`
    else
        testd=`cruby $1`
    fi
        #statements

    echo $testd
    cd $testd
    cbase;

    IFS=$SAVEIFS
}

function ip-address() {
    echo "IP Address: \c"
    ifconfig | sed '/netmask/!d; /broadcast/!d' | awk '{print $2}'
}

# This will list members of a group.
function group() {
    dscl . -list /Users | while read user; do printf "$user "; dsmemberutil checkmembership -U "$user" -G "$*"; done | grep "is a member" | cut -d " " -f 1;
}

function cbase(){
    PS1="\[\e[1;32m\]\u:\[\e[00m\]\[\e[1;33m\]\W\[\e[00m\] \[\e[1;32m\]\$\[\e[00m\] "	
}

function cbaseu(){
    PS1="\[\e[1;32m\]\u:\[\e[00m\]\[\e[1;33m\]\w\[\e[00m\] \[\e[1;32m\]\$\[\e[00m\] "	
}