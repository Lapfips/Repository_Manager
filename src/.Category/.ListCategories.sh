#!/bin/bash

RED=$(tput setaf 1)
GREEN=$(tput setaf 2)
YELLOW=$(tput setaf 3)
CYAN=$(tput setaf 6)
BOLD=$(tput bold)
NC=$(tput sgr0)

# Load the installation directory from the config file
if [ -f "$HOME/.repository_manager_config" ]; then
    source "$HOME/.repository_manager_config"
else
    INSTALL_DIR="$HOME/Repository_Manager"
fi

# Check for help option
if [[ "$1" != "" ]]; then
    if [[ "$1" == "-help" ]]; then
        echo -e "Usage: prog -cat -list\n"
        exit 0
    else
        echo -e "Wrong option: $1\n"
        exit 1
    fi
fi

# Function to count categories
function Count_Categories() {
    REPOSITORIES_COUNT=0
    for cat in $(ls -a "$INSTALL_DIR/src/.Update_Repositories/.Update_"*); do
        if [[ $(basename "$cat") != ".Update_All.sh" ]]; then
            REPOSITORIES_COUNT=1
        fi
    done
}

Count_Categories

text="${BOLD}\nYour categories and repositories structure : \n\n${NC}"

if [[ $REPOSITORIES_COUNT != 0 ]]; then
    for cat in $(ls -a "$INSTALL_DIR/src/.Update_Repositories/.Update_"*); do
        if [[ $(basename "$cat") != ".Update_All.sh" ]]; then
            cat_basename=$(basename "$cat")
            cat=${cat_basename#".Update_"}
            cat=${cat%".sh"}
            text+="${CYAN}     "$cat" : \n${NC}"
            repositories=$(sed -n 's/repositories=( //p' "$INSTALL_DIR/src/.Update_Repositories/.Update_$cat.sh")
            for repo in $repositories; do
                if [[ $repo != *")"* ]]; then
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