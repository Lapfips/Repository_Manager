#!/bin/bash

cd GitRepositories/

repo_path="$1"
repo_url="$2"
repo_name=$(basename "$repo_path")

if [[ ! -d $repo_name ]]; then
    git clone "$repo_url/$repo_path.git"
fi

cd "$repo_name" || exit

git pull

if [[ -n $(git status --porcelain) ]]; then
    git add .
    if [[ "$3" != "" ]]; then
        if [[ "$3" == "auto" ]]; then
            MESS="Automatic commit message"
        else
            MESS="$3"
        fi
    else
        read -p "Enter your commit message for $repo_name repository : " MESS
    fi
    git commit -m "$MESS"
    git push
fi

cd
