#!/bin/bash

TIME="[$(date +"%Y-%m-%d %T")]"

function Is_Repository() {
    Is_Repository="FALSE"
    REPOSITORY_NAME="$1"
    USER_PSEUDO=$(sed -n 's/^.*name = //p' .gitconfig)
    for repo in "${repositories[@]}"; do
        if [[ $REPOSITORY_NAME == $repo ]]; then
            Is_Repository="TRUE"
        else
            if [[ $REPOSITORY_NAME == ${repo#"$USER_PSEUDO/"} ]]; then
                Is_Repository="TRUE" 
            fi
        fi
    done
    return $Is_Repository
}

function Update() {
    echo "Updating $1"
    ./Repository_Manager/src/.Update/.Update_Repo.sh "$1" "$2" "$3"
    echo -e "$TIME - Repository $1 updated successfully." >> ~/Repository_Manager/logs/update.log
}

github="git@github.com:"
repositories=( )

if [[ "$1" == "auto" ]]; then
    for repo in "${repositories[@]}"; do
        commit="auto"
        Update "$repo" "$github" "$commit"
    done
fi

if [[ -z "$1" ]]; then
    for repo in "${repositories[@]}"; do
        Update "$repo" "$github" "$commit"
    done
else
    if [[ $(Is_Repository $1) ]];then
        if [[ "$2" == "auto" ]]; then
            commit="auto"
            Update "$repo" "$github" "$commit"
        else
            commit="$2"
            Update "$repo" "$github" "$commit"
        fi
    else
        echo -e "Wrong repository name\n"
    fi
fi

