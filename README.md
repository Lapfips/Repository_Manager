# Repository_Manager

```bash
#!/bin/bash

if [[ ! -f "main.zip" ]]; then
    sudo wget https://github.com/Lapfips/Repository_Manager/archive/refs/heads/main.zip
fi

echo "Checking for 7zip installation..."
if ! dpkg -l | grep -q "7zip"; then
    echo -e "7zip is not installed. Installing 7zip...\n"
    sudo apt update && sudo apt install -y 7zip
    echo ""
else
    echo -e "7zip is already installed.\n"
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
