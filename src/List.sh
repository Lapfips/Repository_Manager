#!/bin/bash

if [[ "$1" != "" ]]; then
    if [[ "$1" == "-help" ]]; then
        echo -e "Usage: prog -list\n"
        exit 0
    else
        echo -e "Wrong option\n"
    fi
fi

function Check_if_owner() {
    USER_PSEUDO=$(sed -n 's/^.*name = //p' .gitconfig)
    if [[ $1 == "$USER_PSEUDO"/* ]]; then
        repo="$1"
        repo=${repo#"$USER_PSEUDO/"}
    fi
}

function Count_Categories() {
    COUNT=0
    for cat in $(ls -a Repository_Manager/src/.Update_Repositories/.Update_*.sh); do
        if [[ $(basename "$cat") != ".Update_All" ]]; then
            COUNT=+1
        fi
    done
    return $COUNT
}

text="Your categories and repositories structure : \n\n"

#Count=$(Count_Categories)
#if [[ $Count > 0 ]]; then
    for cat in $(ls -a Repository_Manager/src/.Update_Repositories/.Update_*.sh); do
        if [[ $(basename "$cat") != ".Update_All.sh" ]]; then
            cat_basename=$(basename "$cat")
            cat=${cat_basename#".Update_"}
            cat=${cat%".sh"}
            text+="     "$cat" : \n"
            repositories=$(sed -n 's/repositories=( //p' "Repository_Manager/src/.Update_Repositories/.Update_$cat.sh")
            for repo in $repositories; do
                if [[ $repo != *")"* ]]; then
                    Check_if_owner "$repo"
                    text+="          $repo \n"
                fi
            done
            text+="\n"
        fi
    done
#else
#    text+="     You don't have any category yet\n"
#fi

echo -e "$text"
