#!/bin/bash

if [[ -z "$1" ]]; then
    echo
    read -p "Which option do you want to call about your category(ies) ? : " OPT
    echo
else
    OPT="$1" 
fi

case $OPT in
    -add) FUNC="AddCategory" ;;
    -rm) FUNC="RemoveCategory" ;;
    -list) FUNC="ListCategories" ;;
    -help) echo -e "\nUsage prog -cat <option> <category_name> <repository_name>\n
        Options:\n
        -add  -> Add a repository category
        -rm   -> Remove a repository category
        -list -> List all categories\n"
        exit 0
        ;;
    *)  echo -e "\nInvalid parameter. Try again" 
        exit 1 
        ;;
esac

if [[ -f "Repository_Manager/src/.Category/.$FUNC.sh" ]]; then
    ./Repository_Manager/src/.Category/.$FUNC.sh "$2" "$3" "$4"
else
    echo -e "\nFunction script $FUNC.sh not found."
    exit 1
fi