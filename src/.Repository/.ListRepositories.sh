#!/bin/bash

function Count_Repositories() {
    COUNT=0
    for repo in $(sed -n 's/repositories=( //p' "Repository_Manager/src/.Update_Repositories/.Update_$CAT.sh"); do
        echo $repo to count
        if [[ $repo != *")"* ]]; then
            COUNT+=1
        fi
    done
    return $COUNT
}

function Check_if_owner() {
    USER_PSEUDO=$(sed -n 's/^.*name = //p' .gitconfig)
    if [[ $1 == "$USER_PSEUDO"/* ]]; then
        repo="$1"
        repo=${repo#"$USER_PSEUDO/"}
    fi
}

if [[ "$1" != "" ]]; then
    if [[ "$1" == "-help" ]]; then
        echo -e "Usage: prog -repo -list <category_name>\n"
        exit 0
    else
        CAT="$1"
        if [[ -f "Repository_Manager/src/.Update_Repositories/.Update_$CAT.sh" && "$CAT" != "All" ]]; then
            text="Your categories structure : \n\n"
        else
            echo -e "Error: This category name does not exist -> $CAT\n"
            exit 1
        fi
    fi
else
    echo -e "Error: Enter a category name\n"
    exit 1
fi

Count=$(Count_Repositories)
if [[ $Count > 0 ]]; then
    text+="     "$CAT" : \n"
    repositories=$(sed -n 's/repositories=( //p' "Repository_Manager/src/.Update_Repositories/.Update_$CAT.sh")
    for repo in $repositories; do
        if [[ $repo != *")"* ]]; then
            Check_if_owner "$repo"
            text+="          $repo \n"
        fi
    done
else
    text+="     You don't have any repositories in this category\n"
fi

echo -e "$text"