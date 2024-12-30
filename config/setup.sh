#!/bin/bash

# Colors
RED=$(tput setaf 1)
GREEN=$(tput setaf 2)
YELLOW=$(tput setaf 3)
CYAN=$(tput setaf 6)
NC=$(tput sgr0)
BOLD=$(tput bold)
TIME="[$(date +"%Y-%m-%d %T")]"

# Log file location
LOG_FILE="../logs/configuration.log"

# Function to log messages
log_message() {
    echo -e "$1"
    echo -e "$TIME" - "$2" >> "$LOG_FILE"
}

# Ensuring Git installation
log_message "${YELLOW}\nChecking for Git installation...${NC}" "Checking for Git installation..."
if ! command -v git &> /dev/null; then
    log_message "${YELLOW}Git is not installed. Installing Git...\n${NC}" "Git not found. Attempting to install..."
    sudo apt update && sudo apt install -y git || {
        log_message "${RED}Failed to install Git. Exiting.${NC}" "Failed to install Git."
        exit 1
    }
    log_message "${GREEN}Git successfully installed.${NC}" "Git successfully installed."
else
   log_message "${GREEN}Git is already installed.${NC}" "Git already installed."
fi

# SSH Key generation accorded to the user choice
log_message "${YELLOW}\nChecking for SSH key...${NC}" "Checking for SSH key..."
if [[ -d "$HOME/.ssh" ]]; then
    while true; do
        read -p "${CYAN}An SSH key already exists. Do you want to overwrite it? (y or n): ${NC} " SSH_KEY
        case $SSH_KEY in
            [Yy]*)
                ssh-keygen -t ed25519 -f "$HOME/.ssh/id_ed25519" -N "" || {
                    log_message "${RED}Failed to create SSH key.${NC}" "Failed to create SSH key."
                    exit 1
                }
                log_message "${BOLD}\n$(cat $HOME/.ssh/id_ed25519.pub)${NC}" "New SSH key successfully created."
                log_message "${GREEN}Paste this key on your GitHub profile --> https://github.com/settings/keys${NC}" \
                            "Instructed user to add SSH key to GitHub."
                break ;;
            [Nn]*)
                log_message "${GREEN}Keeping existing SSH key.${NC}" "Keeping existing SSH key."
                break ;;
            *)
                log_message "${RED}Please answer y or n.${NC}" "Invalid response for SSH key overwrite choice." ;;
        esac
    done
else
    log_message "${YELLOW}Creating a new SSH key...${NC}" "No existing SSH key found. Creating a new one..."
    ssh-keygen -t ed25519 -f "$HOME/.ssh/id_ed25519" -N "" || {
        log_message "${RED}Failed to create SSH key.${NC}" "Failed to create SSH key."
        exit 1
    }
    log_message "${BOLD}\n$(cat $HOME/.ssh/id_ed25519.pub)${NC}" "New SSH key successfully created."
    log_message "${GREEN}Paste this key on your GitHub profile --> https://github.com/settings/keys${NC}" \
                "Instructed user to add SSH key to GitHub."
fi

# Configuring .gitconfig accorded to the user choice
log_message "${YELLOW}\nChecking for .gitconfig file...${NC}" "Checking for .gitconfig file..."
if [[ -f "$HOME/.gitconfig" ]]; then
    echo -e "${BOLD}Current content of your .gitconfig file:${NC}"
    cat "$HOME/.gitconfig"
    while true; do
        read -p "${CYAN}Do you want to overwrite your .gitconfig? (y or n): ${NC} " CHOICE
        case $CHOICE in
            [Yy]*)
                read -p "${BOLD}Enter your GitHub email: ${NC} " EMAIL
                read -p "${BOLD}Enter your GitHub name: ${NC} " NAME
                git config --global user.name "$NAME"
                git config --global user.email "$EMAIL"
                log_message "${GREEN}.gitconfig has been updated successfully.${NC}" ".gitconfig updated successfully."
                break ;;
            [Nn]*)
                log_message "${GREEN}No changes were made to your .gitconfig file.${NC}" "No changes made to .gitconfig."
                break ;;
            *)
                log_message "${RED}Please answer y or n.${NC}" "Invalid response for .gitconfig overwrite choice." ;;
        esac
    done
else
    log_message "${YELLOW}Creating a new .gitconfig file...${NC}" "No .gitconfig file found. Creating one..."
    read -p "${BOLD}Enter your GitHub email: ${NC} " EMAIL
    read -p "${BOLD}Enter your GitHub name: ${NC} " NAME
    git config --global user.name "$NAME"
    git config --global user.email "$EMAIL"
    log_message "${GREEN}.gitconfig file created successfully.${NC}" ".gitconfig created successfully."
fi

# Configuring and executing .bashrc accorded to the user choice
log_message "${YELLOW}\nChecking for .bashrc file...${NC}" "Checking for .bashrc file..."
if [[ -f "$HOME/.bashrc" ]]; then
    echo -e "${BOLD}Current content of your .bashrc file:${NC}"
    cat "$HOME/.bashrc"
    while true; do
        read -p "${CYAN}Do you want to overwrite your .bashrc? (y or n): ${NC} " CHOICE
        case $CHOICE in
            [Yy]*)
                cp ../config/.bashrc "$HOME/.bashrc"
                log_message "${GREEN}.bashrc has been updated successfully.${NC}" ".bashrc updated successfully."
                break ;;
            [Nn]*)
                log_message "${GREEN}No changes were made to your .bashrc file.${NC}" "No changes made to .bashrc."
                break ;;
            *)
                log_message "${RED}Please answer y or n.${NC}" "Invalid response for .bashrc overwrite choice." ;;
        esac
    done
else
    log_message "${YELLOW}Creating a new .bashrc...${NC}" "No .bashrc file found. Creating one..."
    cp ../config/.bashrc "$HOME/.bashrc"
    log_message "${GREEN}.bashrc file created successfully.${NC}" ".bashrc created successfully."
fi

# Automatically source .bashrc
log_message "${YELLOW}Sourcing the .bashrc...${NC}" "Sourcing the .bashrc..."
source "$HOME/.bashrc" || {
    log_message "${RED}Failed to source .bashrc. Ensure it is valid.${NC}" "Failed to source .bashrc."
}

log_message "${GREEN}\nSetup execution completed successfully.\n${NC}" "Setup execution completed successfully."