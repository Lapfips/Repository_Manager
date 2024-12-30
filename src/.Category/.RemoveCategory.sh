#!/bin/bash

# Colors
TIME="[$(date +"%Y-%m-%d %T")]"

# Check for arguments
if [[ "$1" = "-help" ]]; then
    echo -e "\nUsage prog -cat -rm <category_name>\n"
    exit 0
else
    if [[ "$#" -lt 1 ]]; then
        echo -e "\nPlease enter the following information : \n"
        [ -z "$1" ] && read -p "Enter the category name: " CAT
    else
        CAT="$1"
    fi
fi

# Ask twice to remove the category
read -p "Do you really want to remove your $CAT category ? (y/n) : " USER_CHOICE
case $USER_CHOICE in
    [Yy])
        if [[ ! -f "Repository_Manager/src/.Update_Repositories/.Update_$CAT.sh" ]]; then
            echo -e "\nError: The file for category '$CAT' does not exist."
            exit 1
        else
            rm "Repository_Manager/src/.Update_Repositories/.Update_$CAT.sh"
            echo -e "$TIME - The file for category '$CAT' has been removed." >> ~/Repository_Manager/logs/category.log
        fi
        ;;
    [Nn])
        echo -e "Nothing as been changed\n"
        exit 0
        ;;
esac