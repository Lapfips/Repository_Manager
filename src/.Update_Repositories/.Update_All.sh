#!/bin/bash

TIME="[$(date +"%Y-%m-%d %T")]"

# Load the installation directory from the config file
if [ -f "$HOME/.repository_manager_config" ]; then
    source "$HOME/.repository_manager_config"
else
    INSTALL_DIR="$HOME/Repository_Manager"
fi

for repo in $(ls "$INSTALL_DIR/src/.Update_Repositories/.Update_*.sh"); do
    if [[ $(basename $repo) != ".Update_All.sh" ]]; then
        USER_PSEUDO=$(sed -n 's/^.*name = //p' ~/.gitconfig)
        repo=$(basename $repo)
        repo=${repo#".Update_"}
        repo=${repo%".sh"}
        "$INSTALL_DIR/src/.Update/.Update_Repo.sh" "$repo" "$1" "$2" "$3"
    fi
done

echo -e "All your repositories have been updated\n"
echo -e "$TIME - All repositories updated." >> "$INSTALL_DIR/logs/update.log"