#!/usr/bin/env bash

# Dotfiles uninstallation script
# This script removes symlinks created by install.sh

set -e

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Get the directory where this script is located
DOTFILES_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

# Logging functions
info() {
    echo -e "${BLUE}[INFO]${NC} $1"
}

success() {
    echo -e "${GREEN}[SUCCESS]${NC} $1"
}

warning() {
    echo -e "${YELLOW}[WARNING]${NC} $1"
}

error() {
    echo -e "${RED}[ERROR]${NC} $1"
}

# Remove symlink if it points to our dotfiles
remove_symlink() {
    local target=$1
    local source=$2

    if [ -L "$target" ]; then
        local link_target=$(readlink "$target")
        if [ "$link_target" == "$source" ]; then
            rm "$target"
            success "Removed symlink: $target"
        else
            warning "Skipping $target - points to $link_target (not our dotfile)"
        fi
    elif [ -e "$target" ]; then
        warning "Skipping $target - not a symlink"
    else
        info "Skipping $target - doesn't exist"
    fi
}

# Main uninstallation
main() {
    echo -e "${RED}"
    echo "╔═══════════════════════════════════════╗"
    echo "║   Dotfiles Uninstallation Script     ║"
    echo "╚═══════════════════════════════════════╝"
    echo -e "${NC}"

    echo
    warning "This will remove symlinks to dotfiles from your home directory."
    warning "Your actual dotfiles in $DOTFILES_DIR will not be deleted."
    echo

    read -p "Continue? (y/N) " -n 1 -r
    echo
    if [[ ! $REPLY =~ ^[Yy]$ ]]; then
        info "Uninstallation cancelled"
        exit 0
    fi

    echo
    info "Removing symlinks..."

    # Remove main config files
    remove_symlink "$HOME/.vimrc" "$DOTFILES_DIR/.vimrc"
    remove_symlink "$HOME/.tmux.conf" "$DOTFILES_DIR/.tmux.conf"
    remove_symlink "$HOME/.gitconfig" "$DOTFILES_DIR/.gitconfig"
    remove_symlink "$HOME/.gitignore" "$DOTFILES_DIR/.gitignore"
    remove_symlink "$HOME/.zshrc" "$DOTFILES_DIR/zsh/.zshrc"
    remove_symlink "$HOME/.vim" "$DOTFILES_DIR/.vim"
    remove_symlink "$HOME/.ssh/config" "$DOTFILES_DIR/ssh/config"

    echo
    echo -e "${GREEN}"
    echo "╔═══════════════════════════════════════╗"
    echo "║   Uninstallation Complete!            ║"
    echo "╚═══════════════════════════════════════╝"
    echo -e "${NC}"

    echo
    info "Next steps:"
    echo "  1. Any backup files created during installation remain in ~/.dotfiles_backup_*"
    echo "  2. The dotfiles directory at $DOTFILES_DIR has not been removed"
    echo "  3. To restore backups, look in ~/.dotfiles_backup_* directories"
    echo "  4. Tools like oh-my-zsh, vim-plug, and tmux plugins remain installed"
}

main "$@"
