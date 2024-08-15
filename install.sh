#!/bin/bash

# Source environment variables
source ./scripts/setup_environment.sh

# Install tools
./scripts/install_node.sh
./scripts/install_python.sh
./scripts/install_golang.sh
./scripts/install_tools.sh

# Set up configurations
ln -sf ~/dotfiles/zsh/.zshrc ~/.zshrc
ln -sf ~/dotfiles/tmux/.tmux.conf ~/.tmux.conf
ln -sf ~/dotfiles/nvim/init.vim ~/.config/nvim/init.vim
ln -sf ~/dotfiles/git/.gitconfig ~/.gitconfig

echo "Dotfiles installed successfully!"
