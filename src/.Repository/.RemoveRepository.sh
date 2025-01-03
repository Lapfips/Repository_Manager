#!/bin/bash

TIME="[$(date +"%Y-%m-%d %T")]"

if [[ "$1" == "-help" ]]; then
    echo -e "\nUsage porg -repo -rm <category_name> <repository_name>\n"
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

if [[ ! -f "Repository_Manager/src/.Update_Repositories/.Update_$CAT.sh" ]]; then
    echo -e "\nError: The file for category '$CAT' does not exist."
    exit 1
fi

if grep -q "$(sed -n 's/^.*name = //p' .gitconfig)/$NAME" "Repository_Manager/src/.Update_Repositories/.Update_$CAT.sh"; then
    NAME="$(sed -n 's/^.*name = //p' .gitconfig)/$NAME"
fi

if grep -q "$NAME" "Repository_Manager/src/.Update_Repositories/.Update_$CAT.sh"; then
    sed -i "/repositories=( / s#$NAME ##" "Repository_Manager/src/.Update_Repositories/.Update_$CAT.sh"
    echo -e "$TIME - Repository '$NAME' removed from $CAT." >> ~/Repository_Manager/logs/repository.log
else
    echo -e "\nRepository '$NAME' does not exist in $CAT."
fi

read -p "Do you want to remove this repository from your system -> $NAME ? (yes/no) " USER_CHOICE
if [[ "^$USER_CHOICE" == "yes" ]]; then
    rm -rf "GitRepositories/$NAME"
fi