#!/bin/bash

# Load the installation directory from the config file
if [ -f "$HOME/.repository_manager_config" ]; then
    source "$HOME/.repository_manager_config"
else
    INSTALL_DIR="$HOME/Repository_Manager"
fi

# Check if an option is provided as an argument
if [[ -z "$1" ]]; then
    echo
    read -p "Which option do you want to call about your repository(ies)? : " OPT
    echo
else
    OPT="$1" 
fi

# Determine the function to call based on the provided option
case $OPT in
    -add) FUNC="AddRepository" ;;
    -rm) FUNC="RemoveRepository" ;;
    -list) FUNC="ListRepositories" ;;
    -help) echo -e "\nUsage: prog -repo <option> <category_name> <repository_name>\n
        Options:\n
        -add  -> Add a repository to a certain category
        -rm   -> Remove a repository from a certain category
        -list -> List all repositories\n"
        exit 0
        ;;
    *)  echo -e "\nInvalid parameter. Try again" 
        exit 1 
        ;;
esac

# Define the path to the function scripts
SCRIPT_DIR="$INSTALL_DIR/src/.Repository"

# Check if the function script exists and execute it
if [[ -f "$SCRIPT_DIR/.$FUNC.sh" ]]; then
    "$SCRIPT_DIR/.$FUNC.sh" "$2" "$3" "$4"
else
    echo -e "\nFunction script $FUNC.sh not found."
    exit 1
fi