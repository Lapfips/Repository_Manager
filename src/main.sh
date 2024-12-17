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
    -help) echo -e "\nUsage prog <option>\n\n
        Options:\n\n
        -upt  -> Update a repostory or a category of repostitory\n
        -cat  -> Add or remove a category to your manager\n
        -repo -> Add or remove a repository to a choosed category\n"
        exit 0
        ;;
    *)  echo -e "\nInvalid parameter. Try again" 
        exit 1 
        ;;
esac

if [[ -f "$FUNC" ]]; then
    bash "Repository_Manager/$func" "$2" "$3" "$4" "$5"
else
    echo -e "\nFunction script $FUNC not found."
    exit 1
fi