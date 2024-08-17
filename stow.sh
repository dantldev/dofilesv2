#!/bin/bash

# Directory containing the dotfiles
DOTFILES_DIR="$HOME/dotfilesv2/config"

# Directory where the symlinks will be created
TARGET_DIR="$HOME/.config"

# Create the target directory if it doesn't exist
mkdir -p "$TARGET_DIR"

# Loop through each directory in the .config folder
for dir in "$DOTFILES_DIR"/*; do
    if [ -d "$dir" ]; then
        # Get the base name of the directory
        base_name=$(basename "$dir")
        
        echo "Stowing $base_name..."
        
        # Use stow to create symlinks
        stow -d "$DOTFILES_DIR" -t "$TARGET_DIR" -R "$base_name"
        
        # Check if stow was successful
        if [ $? -eq 0 ]; then
            echo "Successfully stowed $base_name"
        else
            echo "Failed to stow $base_name"
        fi
    fi
done

echo "Stowing complete!"

