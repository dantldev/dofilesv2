#!/bin/bash

# Run the install script
cd /home/testuser/dotfiles
./install.sh

# Execute the command passed to docker run
exec "$@"
