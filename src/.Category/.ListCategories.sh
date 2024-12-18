#!/bin/bash

function Count_Categories() {
    COUNT=0
    for cat in $(ls -a Repository_Manager/src/.Update_Repositories/.Update_*.sh); do
        if [[ $(basename "$cat") != ".Update_All" ]]; then
            COUNT=+1
        fi
    done
    return $COUNT
}

text="Your categories structure : \n\n"

if [[ "$1" != "" ]]; then
    if [[ "$1" == "-help" ]]; then
        echo -e "Usage: prog -cat -list\n"
        exit 0
    else
        echo -e "Wrong option: $1\n"
        exit 1
    fi
fi

Count=$(Count_Categories)
if [[ $Count > 0 ]]; then
    for cat in $(ls -a Repository_Manager/src/.Update_Repositories/.Update_*.sh); do
        if [[ $(basename "$cat") != ".Update_All" ]]; then
            cat_basename=$(basename "$cat")
            cat=${cat_basename#".Update_"}
            text+="     "$cat"\n"
        fi
    done
else
    text+="     You don't have any category yet\n"
fi

echo -e "$text"