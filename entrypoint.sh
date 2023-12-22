#!/bin/bash

git config --global user.email "example@email.com"
git config --global user.name "your name"

# Set SSH key permissions
chmod 600 /root/.ssh/id_rsa
chmod 644 /root/.ssh/id_rsa.pub

# Log the new permissions
echo "New permissions for /root/.ssh:"
ls -l /root/.ssh/id_rsa
ls -l /root/.ssh/id_rsa.pub

# Run the container's main process (/bin/bash in this example)
exec "$@"
