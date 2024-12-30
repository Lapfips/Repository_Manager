#!/bin/bash

# Time for logs
TIME="[$(date +"%Y-%m-%d %T")]"

# Check for parameters
if [[ "$1" == "-help" ]]; then
    echo -e "\nUsage prog -repo -add <category_name> <repository_name>\n"
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

# Ask for owner
if [[ $NAME != */* ]]; then
    read -p "Is this your own repository -> $NAME ? (yes/no) : " USER_CHOICE
    case $USER_CHOICE in
        no)
            read -p "Enter owner's name : " OWNER_NAME
            NAME="$OWNER_NAME/$NAME"
            ;;
        yes)
            NAME="$(sed -n 's/^.*name = //p' .gitconfig)/$NAME"
            ;;
    esac
fi

# Check for category file existance
if [[ ! -f "Repository_Manager/src/.Update_Repositories/.Update_$CAT.sh" ]]; then
    echo -e "\nError: The file for category '$CAT' does not exist."
    exit 1
fi

# Remove repo from category
if grep -q "\"$NAME\"" "Repository_Manager/src/.Update_Repositories/.Update_$CAT.sh"; then
    echo -e "\nRepository '$NAME' already exists in $CAT."
else
    sed -i "/repositories=( / s#)#$NAME )#" "Repository_Manager/src/.Update_Repositories/.Update_$CAT.sh"
    echo -e "$TIME - Repository '$NAME' added to $CAT." >> ~/Repository_Manager/logs/repository.log
fi