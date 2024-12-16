# Repository_Manager

## Presentation

Hi, my name is Ethan, I'm a french second year student and I created this repository to automatis my github repository managing. This script need to be executed on your pc without any conditions, it will automaticly configure an environnement for you github repositories.

## Configuration

To configure the repository manager on our pc you just need to copy paste the code bellow in a file named like `main.sh` then give it rights with `chmod +x main.sh` finally execute the file `./main.sh` then follow the configurations steps in the program.

```bash
#!/bin/bash

# Colors
RED='\033[0;31m'
YELLOW='\033[0;33m'
GREEN='\033[0;32m'
NC='\033[0m'

cd $HOME

# Download the main repository
if [[ ! -f "main.zip" ]]; then
    echo -e "${YELLOW}\nDownloading the repository...${NC}"
    wget -q https://github.com/Lapfips/Repository_Manager/archive/refs/heads/main.zip && echo -e "${GREEN}The repository has been successfully downloaded${NC}" || {
        echo -e "${RED}Failed to download main.zip. Exiting.${NC}"
        exit 1
    }
fi

# Ensuring 7zip installation
echo -e "${YELLOW}\nChecking for p7zip installation...${NC}"
if ! dpkg -l | grep -qw "p7zip-full"; then
    echo -e "${YELLOW}\np7zip is not installed. Installing p7zip-full...${NC}"
    sudo apt update && sudo apt install -y p7zip-full || {
        echo -e "${RED}Failed to install p7zip-full. Exiting.${NC}"
        exit 1
    }
else
    echo -e "${GREEN}p7zip is already installed.${NC}"
fi

# Ensuring unicity
if [[ -d "Repository_Manager-main" || -d "Repository_Manager" ]]; then
    echo -e "${YELLOW}\nRemoving old directories...${NC}"
    rm -rf Repository_Manager-main Repository_Manager
fi

# Extracting .zip file
echo -e "${YELLOW}\nExtracting the repository...${NC}"
unzip -q main.zip && echo -e "${GREEN}main.zip has been successfully extracted${NC}" || {
    echo -e "${RED}Failed to extract main.zip. Exiting.${NC}"
    exit 1
}

# Renaming giving rights and removing .zip file
mv Repository_Manager-main Repository_Manager
chmod -R +x Repository_Manager
rm -f main.zip

# Launching setup.sh
echo -e "${YELLOW}\nLaunching the setup...${NC}"
cd Repository_Manager && echo -e "${GREEN}Program launched${NC}" || {
    echo -e "${RED}Failed to navigate to Repository_Manager. Exiting.${NC}"
    exit 1
}
./config/setup.sh || echo -e "${RED}\nFailed to execute the setup.${NC}"

```
