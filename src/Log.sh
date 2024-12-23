#!/bin/bash

RED=$(tput setaf 1)
GREEN=$(tput setaf 2)
YELLOW=$(tput setaf 3)
CYAN=$(tput setaf 6)
BOLD=$(tput bold)
NC=$(tput sgr0)

function IS_MORE_THAN_ONE_REPOSITORY_CORRESPONDING() {
    COUNT="0"
    for repo in $(ls -a "Repository_Manager/logs/$LOG_FILE_NAME"*); do
        COUNT+="0"
    done
    if [[ "$COUNT" == "000"* ]]; then
        LOG_FILE_NAME="TRUE"
    else
        LOG_FILE_NAME=$(ls -a "Repository_Manager/logs/$LOG_FILE_NAME"*)
    fi
}

if [[ "$1" == "-help" ]]; then
    echo -e "Usage : prog -log <log_file_name>"
else
    if [[ -z "$1" ]]; then
        read -p "Enter the log file name you want to display : " LOG_FILE_NAME
    else
        LOG_FILE_NAME="$1"
    fi
fi

if [[ ! -f "Repository_Manager/logs/$LOG_FILE_NAME"* ]]; then
    echo -e "Wrong log file name try again.\n"
    exit 1
fi

IS_MORE_THAN_ONE_REPOSITORY_CORRESPONDING

LOG_INFO_MESSAGE="${BOLD}\nLogs from your $(basename $LOG_FILE_NAME) file :\n\n${NC}"

if [[ $LOG_FILE_NAME != "TRUE" ]]; then
    while IFS= read -r line; do
        case "$line" in
            *"successfully"*) LOG_INFO_MESSAGE+="${GREEN}$line\n${NC}" ;;
            *"already"*|*"No changes"*|*"Keeping"*) LOG_INFO_MESSAGE+="${YELLOW}$line\n${NC}" ;;
            *"failed"*) LOG_INFO_MESSAGE+="${RED}$line\n${NC}" ;;
            *) LOG_INFO_MESSAGE+="$line\n" ;;
        esac
    done < "$LOG_FILE_NAME"
    if [[ "$LOG_INFO_MESSAGE" == "${BOLD}\nLogs from your $(basename $LOG_FILE_NAME) file :\n\n${NC}" ]]; then
        LOG_INFO_MESSAGE+="${RED}You don't have any log yet.\n${NC}"
    fi
    echo -e $LOG_INFO_MESSAGE
else
    echo -e "${RED}\nToo much log file name corresponding try again.\n${NC}"
fi