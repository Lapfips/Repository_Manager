#!/bin/bash

if [[ "$1" = "-help" ]]; then
    echo -e "\nUsage prog -cat -add <category_name> <repository_name(optionnal)>\n"
    exit 0
else
    if [[ -z "$1" ]]; then
        echo -e "\nPlease enter the following information : \n"
        read -p "Enter the category name: " CAT
    else
        CAT="$1"
        echo
    fi
fi

if [[ -f "Repository_Manager/src/.Update_Repositories/.Update_$CAT.sh" ]]; then
    echo -e "\nError: The file for category '$CAT' already exist."
    exit 1
else
    cp Repository_Manager/config/.Default_Update "Repository_Manager/src/.Update_Repositories/.Update_$CAT.sh"
fi

if [[ "$2" == "" ]]; then
    read -p "Do you want to add a repository to your new category -> $CAT ? (yes/no) : " USER_CHOICE
else
    REPOSITORY_NAME="$2"
    echo
    bash Repository_Manager/src/main.sh -repo -add "$CAT" "$REPOSITORY_NAME"
    echo
    read -p "Do you want to add another repository to your new category -> $CAT ? (yes/no) : " USER_CHOICE 
fi

if [[ "$3" == "-n" ]]; then
    USER_CHOICE="no"
fi

while [[ "$USER_CHOICE" != "no" ]]; do
    echo
    read -p "Enter the repository name you want to add : " REPOSITORY_NAME
    bash Repository_Manager/src/main.sh -repo -add "$CAT" "$REPOSITORY_NAME"
    echo
    read -p "Do you want to add another repository to your new category -> $CAT ? (yes/no) : " USER_CHOICE 
done