# Dotfiles

A comprehensive, cross-platform dotfiles setup for a productive development environment.

## Features

- Automated installation with dependency checking
- Cross-platform support (macOS and Linux)
- Idempotent installation (safe to run multiple times)
- Automatic backups of existing configurations
- Modern, well-documented configurations
- Easy uninstallation

## What's Included

### Core Configurations

- **Vim** (`.vimrc`) - Feature-rich Vim configuration with:
  - vim-plug plugin manager
  - Sensible defaults for development
  - Support for modern file types (JSX, etc.)
  - CtrlP fuzzy finder
  - Persistent undo history
  - Solarized color scheme

- **Tmux** (`.tmux.conf`) - Enhanced tmux configuration with:
  - Custom prefix key (Ctrl+s)
  - Vim-like split keybindings
  - Mouse support
  - Plugin manager (TPM) support
  - Attractive status bar
  - Session persistence (tmux-resurrect, tmux-continuum)

- **Zsh** (`zsh/.zshrc`) - Powerful zsh configuration with:
  - oh-my-zsh integration
  - Spaceship prompt support
  - Useful aliases
  - NVM, RVM, and other version manager support
  - Conditional loading for cross-platform compatibility

- **Git** (`.gitconfig`) - Productive git configuration with:
  - Useful aliases (co, st, lg, lf, etc.)
  - Better diff and log formatting
  - Auto-prune on fetch
  - Colored output

- **SSH** (`ssh/config`) - SSH configuration (optional)

### Tools

- **install.sh** - Automated installation script
- **uninstall.sh** - Clean removal of symlinks
- **Brewfile** - Package management for macOS (Homebrew)

## Quick Start

### Prerequisites

- Git (required)
- Vim (required)
- Tmux (optional, but recommended)
- Zsh (optional, but recommended)

### Installation

1. Clone this repository:
   ```bash
   git clone https://github.com/yourusername/dotfiles.git ~/.dotfiles
   cd ~/.dotfiles
   ```

2. Run the installation script:
   ```bash
   ./install.sh
   ```

3. Follow the prompts to:
   - Install missing dependencies (oh-my-zsh, vim-plug, TPM)
   - Link SSH config (optional)
   - Install packages from Brewfile (macOS only, optional)

4. Restart your terminal or source your shell config:
   ```bash
   source ~/.zshrc
   ```

5. Complete the setup:
   - Open vim and run `:PlugInstall` to install vim plugins
   - Open tmux and press `Ctrl+s` then `I` to install tmux plugins

### macOS Additional Setup

If you're on macOS and want to install the recommended tools:

```bash
# Install Homebrew if not already installed
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

# Install packages from Brewfile
brew bundle --file=~/.dotfiles/Brewfile
```

## What the Installation Does

1. Detects your operating system (macOS or Linux)
2. Checks for required dependencies
3. Backs up existing configurations to `~/.dotfiles_backup_TIMESTAMP`
4. Creates symlinks from your home directory to the dotfiles
5. Optionally installs:
   - vim-plug (Vim plugin manager)
   - oh-my-zsh (Zsh framework)
   - TPM (Tmux plugin manager)
6. On macOS, optionally installs packages via Homebrew

## Directory Structure

```
.dotfiles/
├── .vim/               # Vim configuration directory
├── ssh/                # SSH configuration
│   ├── config          # SSH config file
│   └── install-ssh-config.sh
├── zsh/                # Zsh configuration
│   └── .zshrc          # Zsh config file
├── .gitconfig          # Git configuration
├── .gitignore          # Global gitignore
├── .tmux.conf          # Tmux configuration
├── .vimrc              # Vim configuration
├── Brewfile            # macOS package list
├── install.sh          # Installation script
├── uninstall.sh        # Uninstallation script
└── README.md           # This file
```

## Customization

### Git Configuration

Edit `.gitconfig` and update the `[user]` section with your information:

```gitconfig
[user]
    name = Your Name
    email = your.email@example.com
```

### Zsh Theme

The `.zshrc` is configured to use the Spaceship theme. To install it:

```bash
git clone https://github.com/spaceship-prompt/spaceship-prompt.git "$ZSH_CUSTOM/themes/spaceship-prompt" --depth=1
ln -s "$ZSH_CUSTOM/themes/spaceship-prompt/spaceship.zsh-theme" "$ZSH_CUSTOM/themes/spaceship.zsh-theme"
```

Then restart your shell.

### Adding Your Own Configurations

1. Add your config files to the `.dotfiles` directory
2. Edit `install.sh` to include symlink creation for your files
3. Update this README to document your additions

## Uninstallation

To remove all symlinks created by the installation:

```bash
cd ~/.dotfiles
./uninstall.sh
```

This will:
- Remove all symlinks pointing to this dotfiles directory
- Preserve your backup files in `~/.dotfiles_backup_*` directories
- Not delete the `.dotfiles` directory itself

## Troubleshooting

### oh-my-zsh not found

If you see a warning about oh-my-zsh, install it:

```bash
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
```

### Vim plugins not loading

Run `:PlugInstall` inside vim to install all plugins.

### Tmux plugins not loading

Inside tmux, press the prefix key (`Ctrl+s`) followed by `I` (capital i) to install plugins.

### Tmux status bar not displaying correctly

Make sure your terminal supports 256 colors. Add this to your terminal profile:

```bash
export TERM=xterm-256color
```

## Maintenance

### Updating

To update your dotfiles and pull the latest changes:

```bash
cd ~/.dotfiles
git pull
```

Then restart your terminal or source your configs.

### Adding New Packages (macOS)

Edit the `Brewfile` and add your packages, then run:

```bash
brew bundle --file=~/.dotfiles/Brewfile
```

## Key Bindings Reference

### Tmux

- Prefix: `Ctrl+s`
- `Prefix + v`: Split vertically
- `Prefix + s`: Split horizontally
- `Prefix + c`: New window
- `Prefix + S`: Choose session
- `Prefix + r`: Reload config
- `Prefix + I`: Install plugins

### Vim

- CtrlP: `Ctrl+p` - Fuzzy file finder
- Auto pairs: Automatic bracket/quote pairing
- Standard vim keybindings enhanced with sensible defaults

### Git Aliases

- `git st`: status
- `git co`: checkout
- `git br`: branch
- `git lf`: pretty log format
- `git lg`: log with patches
- `git aa`: add all
- `git ap`: add patch
- `git put`: push to origin HEAD
- `git cleanup`: delete merged branches

## Contributing

Feel free to fork this repository and customize it for your own use. If you have suggestions or improvements, pull requests are welcome!

## License

This project is open source and available under the MIT License.

## Credits

Inspired by various dotfiles repositories and the developer community.
