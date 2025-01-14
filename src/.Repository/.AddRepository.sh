#!/bin/bash

TIME="[$(date +"%Y-%m-%d %T")]"

# Load the installation directory from the config file
if [ -f "$HOME/.repository_manager_config" ]; then
    source "$HOME/.repository_manager_config"
else
    INSTALL_DIR="$HOME/Repository_Manager"
fi

if [[ "$1" == "-help" ]]; then
    echo -e "\nUsage: prog -repo -add <category_name> <repository_name>\n"
    exit 0
else
    if [[ -z "$1" ]]; then
        if [[ -z "$2" ]]; then
            echo -e "\nPlease enter the following information(s) : \n"
            read -p "Enter the repository category: " CAT
        else
            echo -e "\nPlease enter the following information : \n"
        fi
        read -p "Enter the repository name : " NAME
    else
        CAT="$1"
        NAME="$2"
    fi
fi

if [[ $NAME != */* ]]; then
    read -p "Is this your own repository -> $NAME ? (yes/no) : " USER_CHOICE
    case $USER_CHOICE in
        [Yy]*)
            USER_PSEUDO=$(sed -n 's/^.*name = //p' ~/.gitconfig)
            NAME="$USER_PSEUDO/$NAME"
            ;;
        [Nn]*)
            read -p "Enter the repository owner name : " OWNER
            NAME="$OWNER/$NAME"
            ;;
        *)
            echo -e "\nInvalid choice. Operation cancelled."
            exit 1
            ;;
    esac
fi

if [[ ! -f "$INSTALL_DIR/src/.Update_Repositories/.Update_$CAT.sh" ]]; then
    echo -e "\nError: The file for category '$CAT' does not exist."
    exit 1
else
    sed -i "/repositories=(/ s/)/ $NAME)/" "$INSTALL_DIR/src/.Update_Repositories/.Update_$CAT.sh"
    echo -e "$TIME - The repository '$NAME' has been added to the category '$CAT'." >> "$INSTALL_DIR/logs/repository.log"
    echo -e "\nThe repository '$NAME' has been added to the category '$CAT'."
fi