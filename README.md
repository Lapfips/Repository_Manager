# Repository_Manager

## Presentation

Hi, my name is Ethan, I'm a french second year student and I created this repository to automate my github repository management. This script needs to be executed on your pc without any conditions, it will automatically configure an environnement for you github repositories.

## Configuration

To configure the repository manager on your pc you just need to copy paste the code bellow in a file named `main.sh` then give it rights with `chmod +x main.sh` finally execute the file `. main.sh` then follow the configuration steps in the program.

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
    wget -q https://github.com/Lapfips/Repository_Manager/archive/refs/heads/main.zip || {
        echo -e "${RED}Failed to download main.zip. Exiting.${NC}"
        exit 1
    }
    echo -e "${GREEN}The repository has been successfully downloaded${NC}"
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
cd || . .bash_profile || echo -e "${RED}\nFailed to setup the bash profile.${NC}"
```

## Documentation

How to use my program ? After having parametred the program you should be able to call it with `prog`. There is multiple options for this main command :

| Command      | Description                                     |
| ------------ | ----------------------------------------------- |
| `prog -upt`  | Update repositories.                            |
| `prog -cat`  | Manage categories for repositories.             |
| `prog -repo` | Manage repositories.                            |
| `prog -list` | Show you categories and repositories structure. |
| `prog -log`  | Display the logs for a specific file            |
| `prog -help` | Display help for commands or options.           |

### Update

Option used to update your repositories based on you choices. You can update all you repositories in a row or online ones in a specific category or simply just a repository. You can also choose to right directly your own commit message or to automate it. Thre is multiple options for the update option :

| Command                                                        | Description                                                                        |
| -------------------------------------------------------------- | ---------------------------------------------------------------------------------- |
| `prog -upt -a`                                                 | Every repositories.                                                                |
| `prog -upt --all`                                              | Every repositories.                                                                |
| `prog -upt <category_name>`                                    | Select category.                                                                   |
| `prog -upt <category_name> auto`                               | Auto commit message to all the repository in the category that needs to be update. |
| `prog -upt <category_name> <commit_message>`                   | Update with custom commit message all the repository in the category.              |
| `prog -upt <category_name> <repository_name>`                  | Specific repository in the category.                                               |
| `prog -upt <category_name> <repository_name> auto`             | Auto commit message to choosed repository in selected category.                    |
| `prog -upt <category_name> <repository_name> <commit_message>` | Update repository in the category with custom commit message.                      |
| `prog -upt -help`                                              | Display help for commands or options.                                              |

### Category

Manage categories to group repositories with some options :

| Command                                               | Description                                      |
| ----------------------------------------------------- | ------------------------------------------------ |
| `prog -cat -add <category_name>`                      | Add new category to hold repositories.           |
| `prog -cat -add <category_name> <repository_name>`    | Add new repository in a new category.            |
| `prog -cat -add <category_name> <repository_name> -r` | Add a single new repository in a new category.   |
| `prog -cat -rm <category_name>`                       | Remove category and all his repositories.        |
| `prog -cat -rm <category_name>`                       | Remove category .                                |
| `prog -cat -rm <category_name> -r`                    | Remove category without asking for confirmation. |
| `prog -cat -list`                                     | Show categories available.                       |
| `prog -cat -help`                                     | Display help for commands or options.            |

### Repository

Manage repositories in categories :

| Command                                             | Description                               |
| --------------------------------------------------- | ----------------------------------------- |
| `prog -repo -add <category_name> <repository_name>` | Add new repository to specific category.  |
| `prog -repo -rm <category_name> <repository_name>`  | Remove repository from specific category. |
| `prog -repo -list`                                  | Show categories available.                |
| `prog -repo -help`                                  | Display help for commands or options.     |

### Log

Display the log file with colors :

| Command                     | Description                           |
| --------------------------- | ------------------------------------- |
| `prog -log <Log_file_name>` | Show logs from a specific file.       |
| `prog -log -help`           | Display help for commands or options. |
