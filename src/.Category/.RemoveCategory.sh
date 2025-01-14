#!/bin/bash

TIME="[$(date +"%Y-%m-%d %T")]"

# Load the installation directory from the config file
if [ -f "$HOME/.repository_manager_config" ]; then
    source "$HOME/.repository_manager_config"
else
    INSTALL_DIR="$HOME/Repository_Manager"
fi

# Check for arguments
if [[ "$1" = "-help" ]]; then
    echo -e "\nUsage: prog -cat -rm <category_name>\n"
    exit 0
else
    if [[ "$#" -lt 1 ]]; then
        echo -e "\nPlease enter the following information : \n"
        [ -z "$1" ] && read -p "Enter the category name: " CAT
    else
        CAT="$1"
    fi
fi

read -p "Do you really want to remove your $CAT category? (y/n): " USER_CHOICE

case $USER_CHOICE in
    [Yy]*)
        if [[ ! -f "$INSTALL_DIR/src/.Update_Repositories/.Update_$CAT.sh" ]]; then
            echo -e "\nError: The file for category '$CAT' does not exist."
            exit 1
        else
            rm "$INSTALL_DIR/src/.Update_Repositories/.Update_$CAT.sh"
            echo -e "$TIME - The file for category '$CAT' has been removed." >> "$INSTALL_DIR/logs/category.log"
            echo -e "\nThe file for category '$CAT' has been removed."
        fi
        ;;
    [Nn]*)
        echo -e "\nOperation cancelled."
        exit 0
        ;;
    *)
        echo -e "\nInvalid choice. Operation cancelled."
        exit 1
        ;;
esac