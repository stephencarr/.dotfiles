#!/bin/bash 
set -e

script_dir_path=$( cd $(dirname $0) ; pwd -P )
repo_path=$script_dir_path/../
config_path=$script_dir_path/config
backup_path=~/.ssh/config.`date +%Y-%m-%d`.bak

# Check if config is already installed
if [ -L ~/.ssh/config  ]; then
  echo "Config already setup."
else
  # Backup existing config
  if [ -f ~/.ssh/config  ]; then
    mv ~/.ssh/config $backup_path
    echo "Backed up existing config to '$backup_path'."
  fi
  
  ln -s $config_path ~/.ssh/config
  echo "Linked custom SSH config."
fi

# Update to latest configuration
echo "Updating..."
( cd $repo_path; git pull --ff-only )

# Verify the config file is secure
echo "Verifying secure file permissions..."
chmod og-wx $config_path

echo "All done!"
