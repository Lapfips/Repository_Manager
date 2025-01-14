#!/bin/bash

# Load the installation directory from the config file
if [ -f "$HOME/.repository_manager_config" ]; then
    source "$HOME/.repository_manager_config"
else
    INSTALL_DIR="$HOME/Repository_Manager"
fi

# Function to check if the chosen repository exists
function Check_Choiced_Repository() {
    if [[ -f "$UPDATE_REPO_DIR/.Update_$1.sh" ]]; then
        FUNC="$1"
    else
        echo -e "\nInvalid parameter '$1'"
        exit 1
    }
}

# Define the path to the update repositories
UPDATE_REPO_DIR="$INSTALL_DIR/.Update_Repositories"
REPO_PATH="$HOME/GitRepositories"

# Prompt the user for the update type if not provided as an argument
if [[ -z "$1" ]]; then
    echo
    read -p "Which type of update do you want to do? : " CHOICE
else
    CHOICE="$1"
fi

# Create the repository path if it doesn't exist
if [[ ! -d $REPO_PATH ]]; then
    mkdir -p $REPO_PATH
fi

# Determine the function to call based on the provided option
case $CHOICE in
    -a|--all) FUNC=All ;;
    -help) 
        echo -e "\nUsage: prog -upt <option>\n
        Options:\n
        -a          -> Update all your repositories
        --all       -> Update all your repositories
        <category>  -> Update repositories from this category\n"
        exit 0
        ;;
    *)
        if [[ -z "$CHOICE" ]]; then
            echo -e "\nNo option provided. Use -help to display the usage."
            exit 1
        fi
        Check_Choiced_Repository $CHOICE
        ;;
esac

# Execute the update function
if [[ -f "$UPDATE_REPO_DIR/.Update_$FUNC.sh" ]]; then
    "$UPDATE_REPO_DIR/.Update_$FUNC.sh"
else
    echo -e "\nUpdate script for $FUNC not found."
    exit 1
fi