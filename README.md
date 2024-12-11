# Repository_Manager

```bash
#!/bin/bash

RED='\033[0;31m'
YELLOW='\033[0;33m'
NC='\033[0m'

if [[ ! -f "main.zip" ]]; then
    sudo wget https://github.com/Lapfips/Repository_Manager/archive/refs/heads/main.zip
fi
echo -e "${YELLOW}Checking for 7zip installation...${NC}"
echo ""
if ! dpkg -l | grep -q "7zip"; then
    echo -e "${YELLOW}7zip is not installed. Installing 7zip...\n${NC}"
    echo ""
    sudo apt update && sudo apt install -y 7zip
    echo ""
else
    echo -e "${RED}7zip is already installed.\n${NC}"
fi
if [[ -f "Repository_Manager-main" ]]; then
    sudo rm -rf Repository_Manager-main
fi
sudo unzip main.zip
sudo mv Repository_Manager-main Repository_Manager
sudo rm -rf main.zip
sudo chmod +x Repository_Manager/program
./Repository_Manager/program
```
