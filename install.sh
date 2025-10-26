#!/usr/bin/env bash

# Dotfiles installation script
# This script creates symlinks from the home directory to dotfiles in this repo
# It's designed to be idempotent and safe to run multiple times

set -e

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Get the directory where this script is located
DOTFILES_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
BACKUP_DIR="$HOME/.dotfiles_backup_$(date +%Y%m%d_%H%M%S)"

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

# Detect OS
detect_os() {
    if [[ "$OSTYPE" == "linux-gnu"* ]]; then
        OS="linux"
    elif [[ "$OSTYPE" == "darwin"* ]]; then
        OS="macos"
    else
        OS="unknown"
    fi
    info "Detected OS: $OS"
}

# Check if a command exists
command_exists() {
    command -v "$1" >/dev/null 2>&1
}

# Backup existing file/directory
backup_file() {
    local file=$1
    if [ -e "$file" ] && [ ! -L "$file" ]; then
        mkdir -p "$BACKUP_DIR"
        local backup_path="$BACKUP_DIR/$(basename "$file")"
        mv "$file" "$backup_path"
        warning "Backed up existing $file to $backup_path"
        return 0
    fi
    return 1
}

# Create symlink
create_symlink() {
    local source=$1
    local target=$2

    # If target is already a symlink pointing to source, skip
    if [ -L "$target" ] && [ "$(readlink "$target")" == "$source" ]; then
        info "Already linked: $target -> $source"
        return 0
    fi

    # If target exists and is not our symlink, back it up
    if [ -e "$target" ]; then
        backup_file "$target"
    fi

    # Remove broken symlink if exists
    if [ -L "$target" ]; then
        rm "$target"
    fi

    # Create parent directory if it doesn't exist
    mkdir -p "$(dirname "$target")"

    # Create symlink
    ln -s "$source" "$target"
    success "Linked: $target -> $source"
}

# Check dependencies
check_dependencies() {
    info "Checking dependencies..."

    local missing_deps=()

    # Check for essential tools
    if ! command_exists git; then
        missing_deps+=("git")
    fi

    if ! command_exists vim; then
        missing_deps+=("vim")
    fi

    if ! command_exists tmux; then
        warning "tmux not found - .tmux.conf will be linked but tmux needs to be installed"
    fi

    if ! command_exists zsh; then
        warning "zsh not found - .zshrc will be linked but zsh needs to be installed"
    fi

    if [ ${#missing_deps[@]} -gt 0 ]; then
        error "Missing required dependencies: ${missing_deps[*]}"
        echo "Please install them and run this script again."
        exit 1
    fi

    success "All required dependencies found"
}

# Install vim-plug if not already installed
install_vim_plug() {
    local vim_plug_path="${XDG_DATA_HOME:-$HOME/.local/share}/nvim/site/autoload/plug.vim"
    local vim_plug_path_classic="$HOME/.vim/autoload/plug.vim"

    if [ ! -f "$vim_plug_path_classic" ]; then
        info "Installing vim-plug..."
        curl -fLo "$vim_plug_path_classic" --create-dirs \
            https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
        success "vim-plug installed"
    else
        info "vim-plug already installed"
    fi
}

# Install oh-my-zsh if not already installed
install_oh_my_zsh() {
    if [ ! -d "$HOME/.oh-my-zsh" ]; then
        info "oh-my-zsh not found. Installation recommended for full zsh experience."
        read -p "Install oh-my-zsh now? (y/N) " -n 1 -r
        echo
        if [[ $REPLY =~ ^[Yy]$ ]]; then
            info "Installing oh-my-zsh..."
            sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended
            success "oh-my-zsh installed"
        fi
    else
        info "oh-my-zsh already installed"
    fi
}

# Install tmux plugin manager
install_tpm() {
    local tpm_dir="$HOME/.tmux/plugins/tpm"
    if [ ! -d "$tpm_dir" ]; then
        info "Installing Tmux Plugin Manager (TPM)..."
        git clone https://github.com/tmux-plugins/tpm "$tpm_dir"
        success "TPM installed. Press prefix + I in tmux to install plugins"
    else
        info "TPM already installed"
    fi
}

# Link dotfiles
link_dotfiles() {
    info "Linking dotfiles..."

    # Link main config files
    create_symlink "$DOTFILES_DIR/.vimrc" "$HOME/.vimrc"
    create_symlink "$DOTFILES_DIR/.tmux.conf" "$HOME/.tmux.conf"
    create_symlink "$DOTFILES_DIR/.gitconfig" "$HOME/.gitconfig"
    create_symlink "$DOTFILES_DIR/.gitignore" "$HOME/.gitignore"
    create_symlink "$DOTFILES_DIR/zsh/.zshrc" "$HOME/.zshrc"

    # Link vim directory
    create_symlink "$DOTFILES_DIR/.vim" "$HOME/.vim"

    # Link SSH config if desired
    if [ -f "$DOTFILES_DIR/ssh/config" ]; then
        read -p "Link SSH config? This will replace ~/.ssh/config (y/N) " -n 1 -r
        echo
        if [[ $REPLY =~ ^[Yy]$ ]]; then
            create_symlink "$DOTFILES_DIR/ssh/config" "$HOME/.ssh/config"
            # Ensure proper permissions
            chmod 600 "$DOTFILES_DIR/ssh/config"
        fi
    fi
}

# macOS specific setup
setup_macos() {
    if [ "$OS" != "macos" ]; then
        return
    fi

    info "Running macOS-specific setup..."

    # Check for Homebrew
    if ! command_exists brew; then
        warning "Homebrew not found. Would you like to install it?"
        read -p "Install Homebrew? (y/N) " -n 1 -r
        echo
        if [[ $REPLY =~ ^[Yy]$ ]]; then
            info "Installing Homebrew..."
            /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
            success "Homebrew installed"
        fi
    fi

    # Install from Brewfile if it exists and brew is available
    if command_exists brew && [ -f "$DOTFILES_DIR/Brewfile" ]; then
        read -p "Install packages from Brewfile? (y/N) " -n 1 -r
        echo
        if [[ $REPLY =~ ^[Yy]$ ]]; then
            info "Installing from Brewfile..."
            brew bundle --file="$DOTFILES_DIR/Brewfile"
            success "Packages installed from Brewfile"
        fi
    fi
}

# Main installation
main() {
    echo -e "${BLUE}"
    echo "╔═══════════════════════════════════════╗"
    echo "║   Dotfiles Installation Script        ║"
    echo "╚═══════════════════════════════════════╝"
    echo -e "${NC}"

    detect_os
    check_dependencies

    echo
    info "This script will:"
    echo "  - Create symlinks for dotfiles in your home directory"
    echo "  - Backup any existing files to $BACKUP_DIR"
    echo "  - Install missing tools (with your permission)"
    echo

    read -p "Continue? (y/N) " -n 1 -r
    echo
    if [[ ! $REPLY =~ ^[Yy]$ ]]; then
        warning "Installation cancelled"
        exit 0
    fi

    echo
    link_dotfiles

    echo
    install_vim_plug
    install_oh_my_zsh
    install_tpm

    echo
    setup_macos

    echo
    echo -e "${GREEN}"
    echo "╔═══════════════════════════════════════╗"
    echo "║   Installation Complete! 🎉           ║"
    echo "╚═══════════════════════════════════════╝"
    echo -e "${NC}"

    if [ -d "$BACKUP_DIR" ]; then
        info "Backup created at: $BACKUP_DIR"
    fi

    echo
    info "Next steps:"
    echo "  1. Restart your terminal or run: source ~/.zshrc"
    echo "  2. Open vim and run :PlugInstall to install vim plugins"
    echo "  3. Open tmux and press prefix (Ctrl+s) + I to install tmux plugins"
    echo "  4. Review and customize configs as needed"
    echo
    info "To uninstall, run: ./uninstall.sh"
}

main "$@"
