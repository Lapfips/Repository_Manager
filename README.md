# Repository_Manager

```bash
#!/bin/bash

RED='\033[0;31m'
YELLOW='\033[0;33m'
GREEN='\033[0;32m'
NC='\033[0m'

if [[ ! -f "main.zip" ]]; then
    echo -e "${YELLOW}\nDownloading the repository...${NC}"
    wget -q https://github.com/Lapfips/Repository_Manager/archive/refs/heads/main.zip && echo -e "${GREEN}The repository has been successfully downloaded${NC}" || {
        echo -e "${RED}Failed to download main.zip. Exiting.${NC}"
        exit 1
    }
fi

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

if [[ -d "Repository_Manager-main" || -d "Repository_Manager" ]]; then
    echo -e "${YELLOW}\nRemoving old directories...${NC}"
    rm -rf Repository_Manager-main Repository_Manager
fi

echo -e "${YELLOW}\nExtracting the repository...${NC}"
unzip -q main.zip && echo -e "${GREEN}main.zip has been successfully extracted${NC}" || {
    echo -e "${RED}Failed to extract main.zip. Exiting.${NC}"
    exit 1
}

mv Repository_Manager-main Repository_Manager
chmod -R +x Repository_Manager

rm -f main.zip

echo -e "${YELLOW}\nLaunching the setup...${NC}"
cd Repository_Manager && echo -e "${GREEN}Program launched${NC}" || {
    echo -e "${RED}Failed to navigate to Repository_Manager. Exiting.${NC}"
    exit 1
}
./config/setup.sh || echo -e "${RED}\nFailed to execute the setup.${NC}"

```
