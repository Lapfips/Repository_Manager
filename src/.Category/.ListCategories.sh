#!/bin/bash

RED=$(tput setaf 1)
GREEN=$(tput setaf 2)
YELLOW=$(tput setaf 3)
CYAN=$(tput setaf 6)
BOLD=$(tput bold)
NC=$(tput sgr0)

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

text="${BOLD}\nYour categories structure : \n\n${NC}"

if [[ $REPOSITORIES_COUNT != 0 ]]; then
    for cat in $(ls -a Repository_Manager/src/.Update_Repositories/.Update_*.sh); do
        if [[ $(basename "$cat") != ".Update_All.sh" ]]; then
            cat_basename=$(basename "$cat")
            cat=${cat_basename#".Update_"}
            cat=${cat%".sh"}
            text+="     "$cat"\n"
        fi
    done
else
    text+="${RED}     You don't have any category yet\n${NC}"
fi

echo -e "$text"