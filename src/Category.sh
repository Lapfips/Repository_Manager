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
    read -p "Which option do you want to call about your category(ies)? : " OPT
    echo
else
    OPT="$1" 
fi

# Determine the function to call based on the provided option
case $OPT in
    -add) FUNC="AddCategory" ;;
    -rm) FUNC="RemoveCategory" ;;
    -list) FUNC="ListCategories" ;;
    -help) echo -e "\nUsage: prog -cat <option> <category_name> <repository_name>\n
        Options:\n
        -add  -> Add a repository category
        -rm   -> Remove a repository category
        -list -> List all categories\n"
        exit 0
        ;;
    *)  echo -e "\nInvalid parameter. Try again" 
        exit 1 
        ;;
esac

# Define the path to the function scripts
SCRIPT_DIR="$INSTALL_DIR/src/.Category"

# Check if the function script exists and execute it
if [[ -f "$SCRIPT_DIR/.$FUNC.sh" ]]; then
    "$SCRIPT_DIR/.$FUNC.sh" "$2" "$3" "$4"
else
    echo -e "\nFunction script $FUNC.sh not found."
    exit 1
fi