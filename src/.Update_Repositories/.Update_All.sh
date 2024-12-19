#!/bin/bash

TIME="[$(date +"%Y-%m-%d %T")]"
repositories=$(ls Repository_Manager/src/.Update_Repositories/.Update_*.sh)

for repo in $repositories; do
    if [[ $(basename $repo) != ".Update_All" ]]; then
        USER_PSEUDO=$(sed -n 's/^.*name = //p' .gitconfig)
        repo=${repo#"$USER_PSEUDO/"}
        ./Repository_Manager/src/.Update/.Update_$repo.sh "$repo" "$1" "$2" "$3"
    fi
done

echo -e "All your repositories has been updated\n"
echo -e "$TIME - All repositories updated." >> ~/Repository_Manager/logs/update.log