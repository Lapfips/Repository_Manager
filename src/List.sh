#!/bin/bash

# Colors
RED=$(tput setaf 1)
GREEN=$(tput setaf 2)
YELLOW=$(tput setaf 3)
CYAN=$(tput setaf 6)
NC=$(tput sgr0)
BOLD=$(tput bold)

# Load the installation directory from the config file
if [ -f "$HOME/.repository_manager_config" ]; then
    source "$HOME/.repository_manager_config"
else
    INSTALL_DIR="$HOME/Repository_Manager"
fi

# Define the path to the update repositories
UPDATE_REPO_DIR="$INSTALL_DIR/.Update_Repositories"

# Function to count categories
Count_Categories() {
    REPOSITORIES_COUNT=0
    for cat in $(ls -a "$UPDATE_REPO_DIR/.Update_"*); do
        if [[ $(basename "$cat") != ".Update_All.sh" ]]; then
            REPOSITORIES_COUNT=1
        fi
    done
}

Count_Categories

text="${BOLD}\nYour categories and repositories structure : \n\n${NC}"

if [[ $REPOSITORIES_COUNT != 0 ]]; then
    for cat in $(ls -a "$UPDATE_REPO_DIR/.Update_*.sh"); do
        if [[ $(basename "$cat") != ".Update_All.sh" ]]; then
            cat_basename=$(basename "$cat")
            cat=${cat_basename#".Update_"}
            cat=${cat%".sh"}
            text+="${CYAN}     "$cat" : \n${NC}"
            repositories=$(sed -n 's/repositories=( //p' "$UPDATE_REPO_DIR/.Update_$cat.sh")
            for repo in $repositories; do
                if [[ $repo != *")"* ]]; then
                    Check_if_owner "$repo"
                    text+="          $repo \n"
                fi
            done
            text+="\n"
        fi
    done
else
    text+="${RED}     You don't have any category yet\n${NC}"
fi

echo -e "$text"