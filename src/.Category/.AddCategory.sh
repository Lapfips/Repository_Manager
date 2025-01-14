#!/bin/bash

TIME="[$(date +"%Y-%m-%d %T")]"

# Load the installation directory from the config file
if [ -f "$HOME/.repository_manager_config" ]; then
    source "$HOME/.repository_manager_config"
else
    INSTALL_DIR="$HOME/Repository_Manager"
fi

# Prompt for category name if not provided as an argument
if [[ -z "$1" ]]; then
    echo -e "\nPlease enter the following information : \n"
    read -p "Enter the category name: " CATEGORY_NAME
else
    if [[ "$1" = "-help" ]]; then
        echo -e "\nUsage: prog -cat -add <category_name> <repository_name(optional)>\n"
        exit 0
    else
        CATEGORY_NAME="$1"
    fi
fi

# Check if the category file already exists
if [[ -f "$INSTALL_DIR/src/.Update_Repositories/.Update_$CATEGORY_NAME.sh" ]]; then
    echo -e "\nError: The file for category '$CATEGORY_NAME' already exists."
    exit 1
else
    # Copy the default update script to create a new category file
    cp "$INSTALL_DIR/config/.Default_Update.sh" "$INSTALL_DIR/src/.Update_Repositories/.Update_$CATEGORY_NAME.sh"
    echo -e "$TIME - The file for category '$CATEGORY_NAME' has been created." >> "$INSTALL_DIR/logs/category.log"
    echo -e "\nThe file for category '$CATEGORY_NAME' has been created."
fi