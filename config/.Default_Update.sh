#!/bin/bash

TIME="[$(date +"%Y-%m-%d %T")]"

# Load the installation directory from the config file
if [ -f "$HOME/.repository_manager_config" ]; then
    source "$HOME/.repository_manager_config"
else
    INSTALL_DIR="$HOME/Repository_Manager"
fi

function Is_Repository() {
    Is_Repository="FALSE"
    REPOSITORY_NAME="$1"
    USER_PSEUDO=$(sed -n 's/^.*name = //p' .gitconfig)
    for repo in "${repositories[@]}"; do
        if [[ $REPOSITORY_NAME == $repo ]]; then
            Is_Repository="TRUE"
        else
            if [[ $REPOSITORY_NAME == ${repo#"$USER_PSEUDO/"} ]]; then
                Is_Repository="TRUE" 
            fi
        fi
    done
    return $Is_Repository
}

function Update() {
    echo "Updating $1"
    "$INSTALL_DIR/src/.Update/.Update_Repo.sh" "$1" "$2" "$3"
    echo -e "$TIME - Repository $1 updated successfully." >> "$INSTALL_DIR/logs/update.log"
}