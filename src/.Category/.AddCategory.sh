#!/bin/bash

# Time for logs
TIME="[$(date +"%Y-%m-%d %T")]"

# Check parameters
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

# Manage category file creation
if [[ -f "Repository_Manager/src/.Update_Repositories/.Update_$CATEGORY_NAME.sh" ]]; then
    echo -e "\nError: The file for category '$CATEGORY_NAME' already exist."
    exit 1
else
    cp Repository_Manager/config/.Default_Update.sh "Repository_Manager/src/.Update_Repositories/.Update_$CATEGORY_NAME.sh"
    echo -e "$TIME - The file for category '$CATEGORY_NAME' has been created." >> ~/Repository_Manager/logs/category.log
fi

# Check if user want to not add a new repo
if [[ "$3" == "-n" ]]; then
    USER_CHOICE_ADD_NEW_REPOSITORY="no"
fi

# Add repo to the category
if [[ -z "$2" ]]; then
    read -p "Do you want to add a repository to your new category -> $CATEGORY_NAME ? (yes/no) : " USER_CHOICE_ADD_NEW_REPOSITORY
else
    REPOSITORY_NAME="$2"
    echo
    ./Repository_Manager/src/main.sh -repo -add "$CATEGORY_NAME" "$REPOSITORY_NAME"
    echo
    if [[ "$USER_CHOICE_ADD_NEW_REPOSITORY" != "no" ]]; then
        read -p "Do you want to add another repository to your new category -> $CATEGORY_NAME ? (yes/no) : " USER_CHOICE_ADD_NEW_REPOSITORY
    fi
fi

# Keep asking to the user if he wants to add repo to his new category
while [[ "$USER_CHOICE_ADD_NEW_REPOSITORY" != "no" ]]; do
    echo
    read -p "Enter the repository name you want to add : " REPOSITORY_NAME
    ./Repository_Manager/src/main.sh -repo -add "$CATEGORY_NAME" "$REPOSITORY_NAME"
    echo
    read -p "Do you want to add another repository to your new category -> $CATEGORY_NAME ? (yes/no) : " USER_CHOICE_ADD_NEW_REPOSITORY 
done