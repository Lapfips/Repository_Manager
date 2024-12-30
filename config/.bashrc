SSH_ENV="$HOME/.ssh/environment"

TIME="[$(date +"%Y-%m-%d %T")]"

# Agent creation
function start_agent {
    echo "Initialising new SSH agent..."
    /usr/bin/ssh-agent | sed 's/^echo/#echo/' > "${SSH_ENV}"
    echo Succeeded
    chmod 600 "${SSH_ENV}"
    . "${SSH_ENV}" > /dev/null
    /usr/bin/ssh-add;
}

# Check for .ssh environment
if [ -f "${SSH_ENV}" ]; then
    . "${SSH_ENV}" > /dev/null
    ps -ef | grep ${SSH_AGENT_PID} | grep ssh-agent$ > /dev/null || {
        start_agent;
    }
else
    start_agent;
fi

echo -e "$TIME - SSH agent successfully started." >> ~/Repository_Manager/logs/SSH_Environment.log

alias prog="bash $HOME/Repository_Manager/src/main.sh"