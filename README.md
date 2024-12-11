# Repository_Manager

```bash
#!/bin/bash

if [[ ! -f "main.zip" ]]; then
    sudo wget https://github.com/Lapfips/Repository_Manager/archive/refs/heads/main.zip
fi

echo "Checking for 7zip installation..."
if ! dpkg -l | grep -q "7zip"; then
    echo "7zip is not installed. Installing Git..."
    sudo apt update && sudo apt install -y 7zip
else
    echo "7zip is already installed."
fi

if [[ -f Repository_Manager-main ]]; then
    sudo rm -rf Repository_Manager-main
fi

sudo unzip main.zip
sudo mv Repository_Manager-main Repository_Manager
sudo rm -rf main.zip

sudo chmod +x Repository_Manager/program
sudo ./Repository_Manager/program
```
