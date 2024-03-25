#!/bin/bash
source ~/.zshrc

# Function to check if a command is available and install it if not
install_if_missing() {
    local command_name=$1
    local install_command=$2

    if ! command -v "$command_name" &> /dev/null; then
        echo "$command_name is not installed. Installing $command_name..."
        eval "$install_command"
    else
        echo "$command_name is already installed."
    fi
}

# Check if Homebrew is installed
install_if_missing "brew" '/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh)"'

#TODO find out what command to use to check for oh-my-zsh
install_if_missing "oh-my-zsh" 'sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)'

# Check if node is installed
if command -v node &> /dev/null; then
    echo "Node.js is already installed."
else
    echo "Installing Node.js via Homebrew..."
    brew install node
fi

## TODO ITEMS
# Check what shell they are running , either zshrc or bashrc before hand through the current shell they are running
# by checking the current shell

## TODO ITEMS
## uninstall export brew package config so that it can be used again on reinstall
## help out testers so they don't lose homebrew packages
## If you don't want to lose your homebrew packages on uninstall export your config first message

# Check if NVM is installed
if ! command -v nvm &> /dev/null; then
    echo "NVM is not installed. Installing NVM..."
    brew install nvm
    mkdir ~/.nvm

    export NVM_DIR=~/.nvm
    source $(brew --prefix nvm)/nvm.sh

   # Check if .zshrc already has nvm lines
   if grep -q 'export NVM_DIR="$HOME/.nvm"' ~/.zshrc && grep -q '[ -s "$(brew --prefix nvm)/nvm.sh" ] && . "$(brew --prefix nvm)/nvm.sh"' ~/.zshrc; then
    echo "NVM setup lines are already present in ~/.zshrc."
    else
    # Append the lines if they don't exist
    echo 'export NVM_DIR="$HOME/.nvm"' >> ~/.zshrc
    echo '[ -s "$(brew --prefix nvm)/nvm.sh" ] && . "$(brew --prefix nvm)/nvm.sh"' >> ~/.zshrc
    echo "NVM setup lines added to ~/.zshrc."
    fi
else
    echo "NVM is already installed."
fi


# Check if Docker Desktop is installed
  if [ -d "/Applications/Docker.app" ]; then
       echo "Docker is installed"
    else
       echo "Docker is not installed"
       echo "Please install Docker Desktop and run the setup command once more"
       exit 1
    fi



# Display Node.js, NVM, PNPM
echo "Brew version: $(brew -v)"
echo "Node.js version: $(node -v)"
echo "NVM version: $(nvm --version)"


# Make sure the commands are available in PATH
source ~/.zshrc


# Install Node Moudules
echo "Installing Node Modules"

# The whole repo node modules will be installed
# Check if the node_modules directory exists
if [ -d "node_modules" ]; then
    echo "The 'node_modules' directory exists"
else
    echo "The 'node_modules' directory does not exist"
    npm run install:temp
fi

