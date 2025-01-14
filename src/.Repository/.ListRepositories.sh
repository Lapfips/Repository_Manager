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
        echo -e "Usage: prog -repo -list <category_name>\n"
        exit 0
    else
        echo -e "Wrong option: $1\n"
        exit 1
    fi
fi

# Prompt for category name if not provided as an argument
if [[ -z "$1" ]]; then
    echo -e "\nPlease enter the following information : \n"
    read -p "Enter the category name: " CAT
else
    CAT="$1"
fi

# Function to count repositories
function Count_Repositories() {
    COUNT=0
    for repo in $(sed -n 's/repositories=( //p' "$INSTALL_DIR/src/.Update_Repositories/.Update_$CAT.sh"); do
        if [[ $repo != *")"* ]]; then
            COUNT=$((COUNT + 1))
        fi
    done
}

# Function to check if the repository belongs to the user
function Check_if_owner() {
    USER_PSEUDO=$(sed -n 's/^.*name = //p' ~/.gitconfig)
    if [[ $1 == "$USER_PSEUDO"/* ]]; then
        repo="$1"
        repo=${repo#"$USER_PSEUDO/"}
    fi
}

# Count repositories in the category
Count_Repositories

text="${BOLD}\nRepositories in category '$CAT' : \n\n${NC}"

if [[ $COUNT != 0 ]]; then
    for repo in $(sed -n 's/repositories=( //p' "$INSTALL_DIR/src/.Update_Repositories/.Update_$CAT.sh"); do
        if [[ $repo != *")"* ]]; then
            Check_if_owner "$repo"
            text+="${CYAN}     $repo\n${NC}"
        fi
    done
else
    text+="${RED}     No repositories found in category '$CAT'\n${NC}"
fi

echo -e "$text"