#!/bin/bash

if [[ -z "$1" ]]; then
    echo
    read -p "Which option do you want to call about your repository(ies) ? : " OPT
    echo
else
    OPT="$1" 
fi

case $OPT in
    -add) FUNC="AddRepository" ;;
    -rm) FUNC="RemoveRepository" ;;
    -list) FUNC="ListRepositories" ;;
    -help) echo -e "\nUsage prog -repo <option> <category_name> <repository_name>\n
        Options:\n
        -add  -> Add a repository to a certain category
        -rm   -> Remove a repository to a certain category
        -list -> List all repositories\n"
        exit 0
        ;;
    *)  echo -e "\nInvalid parameter. Try again" 
        exit 1 
        ;;
esac

if [[ -f "Repository_Manager/src/.Repository/.$FUNC.sh" ]]; then
    ./Repository_Manager/src/.Repository/.$FUNC.sh "$2" "$3" "$4"
else
    echo -e "\nFunction script $FUNC.sh not found."
    exit 1
fi