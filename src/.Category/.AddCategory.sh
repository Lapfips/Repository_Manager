#!/bin/bash

TIME="[$(date +"%Y-%m-%d %T")]"

if [[ -z "$1" ]]; then
    echo -e "\nPlease enter the following information : \n"
    read -p "Enter the category name: " CATEGORY_NAME
else
    if [[ "$1" = "-help" ]]; then
        echo -e "\nUsage prog -cat -add <category_name> <repository_name(optionnal)>\n"
        exit 0
    else
        CATEGORY_NAME="$1"
    fi
fi

if [[ -f "Repository_Manager/src/.Update_Repositories/.Update_$CATEGORY_NAME.sh" ]]; then
    echo -e "\nError: The file for category '$CATEGORY_NAME' already exist."
    exit 1
else
    cp Repository_Manager/config/.Default_Update.sh "Repository_Manager/src/.Update_Repositories/.Update_$CATEGORY_NAME.sh"
    echo -e "$TIME - The file for category '$CATEGORY_NAME' has been created successfully." >> ~/Repository_Manager/logs/category.log
fi

if [[ "$3" == "-n" ]]; then
    USER_CHOICE_ADD_NEW_REPOSITORY="no"
fi

if [[ -z "$2" ]]; then
    read -p "Do you want to add a repository to your new category -> $CATEGORY_NAME ? (yes/no) : " USER_CHOICE_ADD_NEW_REPOSITORY
else
    REPOSITORY_NAME="$2"
    echo
    ./Repository_Manager/src/main.sh -repo -add "$CATEGORY_NAME" "$REPOSITORY_NAME"
    echo
fi

if [[ "$USER_CHOICE_ADD_NEW_REPOSITORY" != "no" ]]; then
    read -p "Do you want to add another repository to your new category -> $CATEGORY_NAME ? (yes/no) : " USER_CHOICE_ADD_NEW_REPOSITORY
fi

while [[ "$USER_CHOICE_ADD_NEW_REPOSITORY" != "no" ]]; do
    echo
    read -p "Enter the repository name you want to add : " REPOSITORY_NAME
    ./Repository_Manager/src/main.sh -repo -add "$CATEGORY_NAME" "$REPOSITORY_NAME"
    echo
    read -p "Do you want to add another repository to your new category -> $CATEGORY_NAME ? (yes/no) : " USER_CHOICE_ADD_NEW_REPOSITORY 
done