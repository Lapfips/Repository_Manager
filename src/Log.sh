#!/bin/bash

# Colors
RED=$(tput setaf 1)
GREEN=$(tput setaf 2)
YELLOW=$(tput setaf 3)
NC=$(tput sgr0)
BOLD=$(tput bold)

# Load the installation directory from the config file
if [ -f "$HOME/.repository_manager_config" ]; then
    source "$HOME/.repository_manager_config"
else
    INSTALL_DIR="$HOME/Repository_Manager"
fi

# Function to check if more than one log file corresponds
IS_MORE_THAN_ONE_REPOSITORY_CORRESPONDING() {
    if [[ $(ls -a "$LOG_DIR/$LOG_FILE_NAME"* | wc -l) -gt 1 ]]; then
        echo -e "${RED}\nToo many log files correspond. Try again.\n${NC}"
        exit 1
    else
        LOG_FILE_NAME=$(ls -a "$LOG_DIR/$LOG_FILE_NAME"*)
    fi
}

# Define the path to the log directory
LOG_DIR="$INSTALL_DIR/logs"

# Check if a log file name is provided as an argument
if [[ -z "$1" ]]; then
    echo
    read -p "Enter the log file name: " LOG_FILE_NAME
    echo
else
    LOG_FILE_NAME="$1"
fi

# Validate the log file name
if [[ ! -f "$LOG_DIR/$LOG_FILE_NAME" ]]; then
    echo -e "${RED}Wrong log file name. Try again.\n${NC}"
    exit 1
else
    IS_MORE_THAN_ONE_REPOSITORY_CORRESPONDING
fi

LOG_INFO_MESSAGE="${BOLD}\nLogs from your $(basename "$LOG_FILE_NAME") file :\n\n${NC}"

if [[ $LOG_FILE_NAME != "TRUE" ]]; then
    while IFS= read -r line; do
        case "$line" in
            *"successfully"*|*"added"*) LOG_INFO_MESSAGE+="${GREEN}$line\n${NC}" ;;
            *"failed"*|*"removed"*) LOG_INFO_MESSAGE+="${RED}$line\n${NC}" ;;
            *) LOG_INFO_MESSAGE+="${YELLOW}$line\n${NC}" ;;
        esac
    done < "$LOG_FILE_NAME"
    if [[ "$LOG_INFO_MESSAGE" == "${BOLD}\nLogs from your $(basename "$LOG_FILE_NAME") file :\n\n${NC}" ]]; then
        LOG_INFO_MESSAGE+="${RED}You don't have any log yet.\n${NC}"
    fi
    echo -e "$LOG_INFO_MESSAGE"
else
    echo -e "${RED}\nToo many log files correspond. Try again.\n${NC}"
fi