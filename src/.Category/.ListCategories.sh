#!/bin/bash

if [[ "$1" != "" ]]; then
    if [[ "$1" == "-help" ]]; then
        echo -e "Usage: prog -cat -list\n"
        exit 0
    else
        echo -e "Wrong option: $1\n"
        exit 1
    fi
fi

function Count_Categories() {
    REPOSITORIES_COUNT=0
    for cat in $(ls -a Repository_Manager/src/.Update_Repositories/.Update_*.sh); do
        if [[ $(basename "$cat") != ".Update_All.sh" ]]; then
            REPOSITORIES_COUNT=1
        fi
    done
}

Count_Categories

text="Your categories structure : \n\n"

if [[ $REPOSITORIES_COUNT != 0 ]]; then
    for cat in $(ls -a Repository_Manager/src/.Update_Repositories/.Update_*.sh); do
        if [[ $(basename "$cat") != ".Update_All" ]]; then
            cat_basename=$(basename "$cat")
            cat=${cat_basename#".Update_"}
            cat=${cat%".sh"}
            text+="     "$cat"\n"
        fi
    done
else
    text+="     You don't have any category yet\n"
fi

echo -e "$text"