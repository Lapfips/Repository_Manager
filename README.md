# Repository_Manager

if [[! -f "main.zip"]]; then
wget https://github.com/Lapfips/Repository_Manager/archive/refs/heads/main.zip
fi

echo "Checking for 7zip installation..."
if ! dpkg -l | grep -q "7zip"; then
echo "7zip is not installed. Installing Git..."
sudo apt update && sudo apt install -y 7zip
else
echo "7zip is already installed."
fi

if [[-f Repository_Manager-main]]; then
rm -rf Repository_Manager-main
fi

unzip main.zip
mv Repository_Manager-main Repository_Manager
rm -rf main.zip

chmod +x Repository_Manager/program
./Repository_Manager/program
