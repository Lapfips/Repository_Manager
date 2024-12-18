#!/bin/bash

function Is_Repository() {
    COUNT=0
    REPOSITORY_NAME="$2"
    USER_PSEUDO=$(sed -n 's/^.*name = //p' .gitconfig)
    for repo in "${repositories[@]}"; do
        if [[ $REPOSITORY_NAME == $repo ]]; then
            COUNT+=1
        else
            if [[ $REPOSITORY_NAME == ${repo#"$USER_PSEUDO/"} ]]; then
                COUNT+=1
            fi
        fi
    done
    return $COUNT
}

github="git@github.com:"
repositories=( )

if [[ "$1" == "auto" ]]; then
    for repo in "${repositories[@]}"; do
        commit="auto"
        echo "Updating $repo"
        bash Repository_Manager/src/.Update/.Update_Repo.sh "$repo" "$github" "$commit"
    done
fi

if [[ -z "$1" ]]; then
    for repo in "${repositories[@]}"; do
        echo "Updating $repo"
        bash Repository_Manager/src/.Update/.Update_Repo.sh "$repo" "$github"
    done
else
    is_there_repository=$(Is_Repository $1)
    if [[ $is_there_repository == 1 ]];then
        if [[ "$2" == "auto" ]]; then
            commit="auto"
            echo "Updating $repo"
            bash Repository_Manager/src/.Update/.Update_Repo.sh "$repo" "$github" "$commit"
        else
            commit="$2"
            echo "Updating $repo"
            bash Repository_Manager/src/.Update/.Update_Repo.sh "$repo" "$github" "$commit"
        fi
    else
        echo -e "Wrong repository name\n"
    fi
fi
