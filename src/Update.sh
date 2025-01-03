#!/bin/bash

function Check_Choiced_Repository() {
    if [[ -f "Repository_Manager/src/.Update_Repositories/.Update_$1.sh" ]]; then
        FUNC="$1"
    else
        echo -e "\nInvalid parameter '$1'"
        exit 1
    fi
}

REPO_PATH="GitRepositories"

if [[ -z "$1" ]]; then
    echo
    read -p "Which type of update do you want to do ? : " CHOICE
else
    CHOICE="$1"
fi

if [[ ! -d $REPO_PATH ]]; then
    mkdir -p $REPO_PATH
fi

case $CHOICE in
    -a|--all) FUNC=All ;;
    -help) 
        echo -e "\nUsage: prog -upt <option>\n
        Options:\n
        -a          -> Update all your repositories
        --all       -> Update all your repositories
        <category>  -> Update repositories from this category\n"
        exit 0
        ;;
    *)
        if [[ -z "$CHOICE" ]]; then
            echo -e "\nNo option provided. Use -help to display the usage."
            exit 1
        fi
        Check_Choiced_Repository $CHOICE
        ;;
esac

if [[ -f "Repository_Manager/src/.Update_Repositories/.Update_$FUNC.sh" ]]; then
    ./Repository_Manager/src/.Update_Repositories/.Update_$FUNC.sh "$2" "$3"
else
    echo -e "\nFunction script Repository_Manager/src/.Update_Repositories/.Update_$FUNC.sh not found."
    exit 1
fi
