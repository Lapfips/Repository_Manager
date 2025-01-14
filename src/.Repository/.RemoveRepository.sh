#!/bin/bash

TIME="[$(date +"%Y-%m-%d %T")]"

# Load the installation directory from the config file
if [ -f "$HOME/.repository_manager_config" ]; then
    source "$HOME/.repository_manager_config"
else
    INSTALL_DIR="$HOME/Repository_Manager"
fi

if [[ "$1" == "-help" ]]; then
    echo -e "\nUsage: prog -repo -rm <category_name> <repository_name>\n"
    exit 0
else
    if [[ "$#" -lt 2 ]]; then
        echo -e "\nPlease enter the following information(s): \n"
            if [[ "$#" -lt 1 ]]; then
                [ -z "$1" ] && read -p "Enter the repository category: " CAT
            fi
        [ -z "$2" ] && read -p "Enter the repository name (<user>/<repository_name> or <organization>/<repository_name>): " NAME
    else
        CAT="$1"
        NAME="$2"
    fi
fi

if [[ ! -f "$INSTALL_DIR/src/.Update_Repositories/.Update_$CAT.sh" ]]; then
    echo -e "\nError: The file for category '$CAT' does not exist."
    exit 1
fi

if ! grep -q "$NAME" "$INSTALL_DIR/src/.Update_Repositories/.Update_$CAT.sh"; then
    echo -e "\nError: The repository '$NAME' does not exist in the category '$CAT'."
    exit 1
else
    sed -i "/$NAME/d" "$INSTALL_DIR/src/.Update_Repositories/.Update_$CAT.sh"
    echo -e "$TIME - The repository '$NAME' has been removed from the category '$CAT'." >> "$INSTALL_DIR/logs/repository.log"
    echo -e "\nThe repository '$NAME' has been removed from the category '$CAT'."
fi