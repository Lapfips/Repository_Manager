#!/bin/bash

# Load the installation directory from the config file
if [ -f "$HOME/.repository_manager_config" ]; then
    source "$HOME/.repository_manager_config"
else
    INSTALL_DIR="$HOME/Repository_Manager"
fi

# Prompt the user for the function to call if not provided as an argument
if [[ -z "$1" ]]; then
    echo
    read -p "Which function do you want to call? : " FUNC
    echo
else
    FUNC=$1 
fi

# Determine the function to call based on the provided option
case $FUNC in
    -upt) FUNC="Update" ;;
    -cat) FUNC="Category" ;;
    -repo) FUNC="Repository" ;;
    -list) FUNC="List" ;;
    -log) FUNC="Log" ;;
    -help) echo -e "\nUsage: prog <option>\n
        Options:\n
        -upt  -> Update a repository or a category of repositories
        -cat  -> Add or remove a category to your manager
        -repo -> Add or remove a repository to a chosen category
        -list -> List all your categories and repositories
        -log  -> Display logs from a specific file\n"
        exit 0
        ;;
    *)  echo -e "\nInvalid parameter. Try again" 
        exit 1 
        ;;
esac

# Define the path to the function scripts
SCRIPT_DIR="$INSTALL_DIR"

# Check if the function script exists and execute it
if [[ -f "$SCRIPT_DIR/$FUNC.sh" ]]; then
    bash "$SCRIPT_DIR/$FUNC.sh" "$2" "$3" "$4" "$5"
else
    echo -e "\nFunction script $SCRIPT_DIR/$FUNC.sh not found."
    exit 1
fi