#!/bin/bash

# Colors
RED=$(tput setaf 1)
GREEN=$(tput setaf 2)
YELLOW=$(tput setaf 3)
CYAN=$(tput setaf 6)
NC=$(tput sgr0)
BOLD=$(tput bold)

# Ensuring Git installation
echo -e "${YELLOW}\nChecking for Git installation...${NC}"
if ! command -v git &> /dev/null; then
    echo -e "${YELLOW}Git is not installed. Installing Git...\n${NC}"
    sudo apt update && sudo apt install -y git || {
        echo -e "${RED}Failed to install Git. Exiting.${NC}"
        echo -e "Failed to install Git.\n" >> ~/Repository_Manager/logs/Configuration.log
        exit 1
    }
    echo -e "${GREEN}Git successfully installed.${NC}" 
    echo -e "Git successfully installed.\n" >> ~/Repository_Manager/logs/Configuration.log
else
    echo -e "${GREEN}Git is already installed.${NC}"
    echo -e "Git is already installed.\n" >> ~/Repository_Manager/logs/Configuration.log
fi

# SSH Key generation accorded to the user choice
echo -e "${YELLOW}\nChecking for SSH key...${NC}"
if [[ -d "$HOME/.ssh" ]]; then
    while true; do
        read -p "${CYAN}An SSH key already exists. Do you want to overwrite it? (y or n): ${NC} " SSH_KEY
        case $SSH_KEY in
            [Yy]*)
                ssh-keygen -t ed25519
                echo -e "${BOLD}\n$(cat $HOME/.ssh/id_ed25519.pub)${NC}"
                echo -e "${GREEN}\nPaste this key on your GitHub profile --> https://github.com/settings/keys${NC}"
                echo -e "${GREEN}New SSH key successfully created.${NC}"
                echo -e "New SSH key successfully created.\n" >> ~/Repository_Manager/logs/Configuration.log
                break ;;
            [Nn]*)
                echo -e "${GREEN}Keeping the existing SSH key.${NC}"
                echo -e "Keeping the existing SSH key.\n" >> ~/Repository_Manager/logs/Configuration.log
                break ;;
            *)
                echo -e "${RED}Please answer y or n.${NC}" ;;
        esac
    done
else
    echo -e "${YELLOW}Creating a new SSH key...${NC}"
    ssh-keygen -t ed25519
    echo -e "${BOLD}\n$(cat $HOME/.ssh/id_ed25519.pub)${NC}"
    echo -e "${GREEN}\nPaste this key on your GitHub profile --> https://github.com/settings/keys${NC}"
    echo -e "${GREEN}New SSH key successfully created.${NC}"
    echo -e "New SSH key successfully created.\n" >> ~/Repository_Manager/logs/Configuration.log
fi

# Configuring .gitconfig accorded to the user choice
echo -e "${YELLOW}\nChecking for .gitconfig file...${NC}"
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
                echo -e "${GREEN}.gitconfig has been updated successfully.${NC}"
                echo -e ".gitconfig has been updated successfully.\n" >> ~/Repository_Manager/logs/Configuration.log
                break ;;
            [Nn]*)
                echo -e "${GREEN}No changes were made to your .gitconfig file.${NC}"
                echo -e "No changes were made to .gitconfig file.\n" >> ~/Repository_Manager/logs/Configuration.log
                break ;;
            *)
                echo -e "${RED}Please answer y or n.${NC}" ;;
        esac
    done
else
    echo -e "${YELLOW}Creating a new .gitconfig file...${NC}"
    read -p "${BOLD}Enter your GitHub email: ${NC} " EMAIL
    read -p "${BOLD}Enter your GitHub name: ${NC} " NAME
    git config --global user.name "$NAME"
    git config --global user.email "$EMAIL"
    echo -e "${GREEN}.gitconfig file created successfully.${NC}"
    echo -e ".gitconfig has been updated successfully.\n" >> ~/Repository_Manager/logs/Configuration.log
fi

# Configuring and executing .bash_profile accorded to the user choice
echo -e "${YELLOW}\nChecking for .bash_profile file...${NC}"
if [[ -f "$HOME/.bash_profile" ]]; then
    echo -e "${BOLD}Current content of your .bash_profile file:${NC}"
    cat "$HOME/.bash_profile"
    while true; do
        read -p "${CYAN}Do you want to overwrite your .bash_profile? (y or n): ${NC} " CHOICE
        case $CHOICE in
            [Yy]*)
                cp ~/Repository_Manager/config/.bash_profile "$HOME/.bash_profile"
                echo -e "${GREEN}.bash_profile has been updated successfully.${NC}"
                echo -e ".bash_profile has been updated successfully.\n" >> ~/Repository_Manager/logs/Configuration.log
                break ;;
            [Nn]*)
                echo -e "${GREEN}No changes were made to your .bash_profile file.${NC}"
                echo -e "No changes were made to .bash_profile file.\n" >> ~/Repository_Manager/logs/Configuration.log
                break ;;
            *)
                echo -e "${RED}Please answer y or n.${NC}" ;;
        esac
    done
else
    echo -e "${YELLOW}Creating a new .bash_profile...${NC}"
    cp ~/Repository_Manager/config/.bash_profile "$HOME/.bash_profile"
    echo -e "${GREEN}.bash_profile file created successfully.${NC}"
    echo -e ".bash_profile has been updated successfully.\n" >> ~/Repository_Manager/logs/Configuration.log
fi

echo -e "${GREEN}\nSetup execution completed successfully.\n
${NC}${BOLD}Enter ${YELLOW}'. .bash_profile'${NC}${BOLD} to initialize your profile.\n${NC}"

echo -e "Setup execution completed successfully.\n" >> ~/Repository_Manager/logs/Configuration.log
