#!/bin/bash

# Colors
RED=$(tput setaf 1)
GREEN=$(tput setaf 2)
YELLOW=$(tput setaf 3)
CYAN=$(tput setaf 6)
NC=$(tput sgr0)
BOLD=$(tput bold)
TIME="[$(date +"%Y-%m-%d %T")]"

# Check if the installation directory is provided as an argument
if [[ -z "$1" ]]; then
    echo -e "${RED}Installation directory not provided. Exiting.${NC}"
    exit 1
fi

INSTALL_DIR="$1"

# Log file location
LOG_FILE="$INSTALL_DIR/logs/configuration.log"

# Function to log messages
log_message() {
    echo -e "$1"
    echo -e "$TIME - $2" >> "$LOG_FILE"
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

# SSH Key generation according to the user choice
log_message "${YELLOW}\nChecking for SSH key...${NC}" "Checking for SSH key..."
if [[ -d "$HOME/.ssh" ]]; then
    while true; do
        read -p "${CYAN}An SSH key already exists. Do you want to overwrite it? (y or n): ${NC} " SSH_KEY
        case $SSH_KEY in
            [Yy]*)
                read -p "${CYAN}Enter a passphrase for your SSH key (leave empty for no passphrase): ${NC}" PASSPHRASE
                ssh-keygen -t ed25519 -f "$HOME/.ssh/id_ed25519" -N "$PASSPHRASE" || {
                    log_message "${RED}Failed to generate SSH key. Exiting.${NC}" "Failed to generate SSH key."
                    exit 1
                }
                log_message "${GREEN}SSH key generated successfully.${NC}" "SSH key generated successfully."
                break ;;
            [Nn]*)
                log_message "${GREEN}No changes were made to your SSH key.${NC}" "No changes made to SSH key."
                break ;;
            *)
                log_message "${RED}Please answer y or n.${NC}" "Invalid response for SSH key overwrite choice." ;;
        esac
    done
else
    log_message "${YELLOW}Creating .ssh directory and generating SSH key...${NC}" "No .ssh directory found. Creating one and generating SSH key..."
    mkdir -p "$HOME/.ssh"
    read -p "${CYAN}Enter a passphrase for your SSH key (leave empty for no passphrase): ${NC}" PASSPHRASE
    ssh-keygen -t ed25519 -f "$HOME/.ssh/id_ed25519" -N "$PASSPHRASE" || {
        log_message "${RED}Failed to generate SSH key. Exiting.${NC}" "Failed to generate SSH key."
        exit 1
    }
    log_message "${GREEN}SSH key generated successfully.${NC}" "SSH key generated successfully."
fi

# Save the installation directory to a config file
echo "INSTALL_DIR=$INSTALL_DIR" > "$HOME/.repository_manager_config"

# Add the installation directory to the PATH if it's not already there
if [[ ":$PATH:" != *":$INSTALL_DIR:"* ]]; then
    echo "export PATH=\$PATH:$INSTALL_DIR" >> ~/.bash_profile
    source ~/.bash_profile
fi

# Check if .bash_profile exists
if [ -f "$HOME/.bash_profile" ]; then
    echo -e "${BOLD}Current content of your .bash_profile file:${NC}"
    cat "$HOME/.bash_profile"
    while true; do
        read -p "${CYAN}Do you want to overwrite your .bash_profile? (y or n): ${NC} " CHOICE
        case $CHOICE in
            [Yy]*)
                cp config/.bash_profile "$HOME/.bash_profile"
                log_message "${GREEN}.bash_profile has been updated successfully.${NC}" ".bash_profile updated successfully."
                break ;;
            [Nn]*)
                log_message "${GREEN}No changes were made to your .bash_profile file.${NC}" "No changes made to .bash_profile."
                break ;;
            *)
                log_message "${RED}Please answer y or n.${NC}" "Invalid response for .bash_profile overwrite choice." ;;
        esac
    done
else
    log_message "${YELLOW}Creating a new .bash_profile...${NC}" "No .bash_profile file found. Creating one..."
    cp config/.bash_profile "$HOME/.bash_profile"
    log_message "${GREEN}.bash_profile file created successfully.${NC}" ".bash_profile created successfully."
fi

# Source the .bash_profile
source "$HOME/.bash_profile" || {
    log_message "${RED}Failed to source .bash_profile. Ensure it is valid.${NC}" "Failed to source .bash_profile."
    exit 1
}

log_message "${GREEN}Setup completed successfully.${NC}" "Setup completed successfully."
