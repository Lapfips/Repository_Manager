#!/bin/bash

repositories=$(ls Repository_Manager/src/.Update_Repositories/.Update_*.sh)

for repo in $repositories; do
    if [[ $(basename $repo) != ".Update_All" ]]; then
        USER_PSEUDO=$(sed -n 's/^.*name = //p' .gitconfig)
        repo=${repo#"$USER_PSEUDO/"}
        ./Repository_Manager/src/.Update/.Update_$repo.sh "$repo" "$1" "$2" "$3"
    fi
done