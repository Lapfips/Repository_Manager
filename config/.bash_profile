SSH_ENV="$HOME/.ssh/environment"

TIME="[$(date +"%Y-%m-%d %T")]"

# Load the installation directory from the config file
if [ -f "$HOME/.repository_manager_config" ]; then
    source "$HOME/.repository_manager_config"
else
    INSTALL_DIR="$HOME/Repository_Manager"
fi

# Agent creation
function start_agent {
    echo "Initialising new SSH agent..."
    /usr/bin/ssh-agent | sed 's/^echo/#echo/' > "${SSH_ENV}"
    echo Succeeded
    chmod 600 "${SSH_ENV}"
    . "${SSH_ENV}" > /dev/null
    /usr/bin/ssh-add
}

# Check for .ssh environment
if [ -f "${SSH_ENV}" ]; then
    . "${SSH_ENV}" > /dev/null
    if ! pgrep -u "$USER" ssh-agent > /dev/null; then
        start_agent
    fi
else
    start_agent
fi

echo -e "$TIME - SSH agent successfully started." >> "$INSTALL_DIR/logs/SSH_Environment.log"

# Alias for the main script
alias prog="bash $INSTALL_DIR/main.sh"