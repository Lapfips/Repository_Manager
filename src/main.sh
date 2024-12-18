#!/bin/bash

if [[ -z "$1" ]]; then
    echo
    read -p "Which function do you want to call ? : " FUNC
    echo
else
    FUNC=$1 
fi

case $FUNC in
    -upt) FUNC="Update" ;;
    -cat) FUNC="Category" ;;
    -repo) FUNC="Repository" ;;
    -list) FUNC="List" ;;
    -help) echo -e "\nUsage prog <option>\n
        Options:\n
        -upt  -> Update a repostory or a category of repostitory
        -cat  -> Add or remove a category to your manager
        -repo -> Add or remove a repository to a choosed category
        -list -> List all your categories and repositories\n"
        exit 0
        ;;
    *)  echo -e "\nInvalid parameter. Try again" 
        exit 1 
        ;;
esac

if [[ -f "Repository_Manager/src/$FUNC" ]]; then
    bash "Repository_Manager/src/$FUNC" "$2" "$3" "$4" "$5"
else
    echo -e "\nFunction script $FUNC not found."
    exit 1
fi