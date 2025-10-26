# Dotfiles

A comprehensive, cross-platform dotfiles setup for a productive development environment.

## Features

- **Modern 2025 Stack** - Using current best practices and latest tools
- **Automated Installation** - One command setup with dependency checking
- **Cross-Platform** - Works on macOS and Linux
- **Idempotent** - Safe to run multiple times
- **Smart Backups** - Automatic timestamped backups of existing configs
- **True Color Support** - 24-bit color in terminal, vim, and tmux
- **Fast & Efficient** - Modern alternatives (fzf, ripgrep, eza, bat)
- **Easy Removal** - Clean uninstall script included

## What's Included

### Core Configurations

- **Vim** (`.vimrc`) - Modern Vim configuration with:
  - vim-plug plugin manager
  - **fzf.vim** - Modern fuzzy finder (replaces CtrlP)
  - **vim-fugitive** - Best-in-class Git integration
  - **lightline** - Beautiful status line
  - **vim-polyglot** - 100+ language syntax support
  - **gitgutter** - Git diff in gutter
  - **True color support** (24-bit)
  - Multiple modern colorschemes (gruvbox, onedark, solarized)
  - Persistent undo history
  - Smart defaults and keybindings

- **Tmux** (`.tmux.conf`) - Modern tmux configuration with:
  - **True color support** (24-bit)
  - Custom prefix key (Ctrl+s)
  - Vim-like split keybindings and copy mode
  - Mouse support with modern scrolling
  - Plugin manager (TPM) with useful plugins
  - Auto-restore sessions (tmux-continuum)
  - Enhanced copy/paste (tmux-yank)
  - Attractive status bar

- **Zsh** (`zsh/.zshrc`) - Modern zsh configuration with:
  - oh-my-zsh with 15+ useful plugins
  - **Starship prompt** - Fast, cross-shell, modern prompt (preferred)
  - Spaceship prompt as fallback
  - **zsh-autosuggestions** - Fish-like command suggestions
  - **zsh-syntax-highlighting** - Command syntax highlighting
  - Modern command aliases (eza, bat, ripgrep, fd)
  - Smart history management (50k entries)
  - Better directory navigation
  - NVM, RVM, and version manager support
  - Conditional loading for cross-platform compatibility

- **Git** (`.gitconfig`) - Modern git configuration with:
  - **Default branch: main** (not master)
  - **Pull rebase by default** - Cleaner history
  - **Auto-setup remote** - Easier push workflow
  - **Better diff algorithm** - Histogram algorithm
  - **Color moved detection** - See moved code in diffs
  - Useful aliases (co, st, lg, lf, sw, restore, graph)
  - Auto-prune on fetch
  - Force-with-lease for safer force pushes
  - Updated cleanup to handle main/master

- **SSH** (`ssh/config`) - SSH configuration (optional)

### Tools

- **install.sh** - Automated installation script with OS detection
- **uninstall.sh** - Clean removal of symlinks
- **Brewfile** - Modern package management for macOS (70+ curated tools)

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
   - Install modern CLI tools (recommended, see below)

### Modern CLI Tools (Recommended)

These modern alternatives make your terminal experience significantly better:

```bash
# On macOS (via Homebrew)
brew install starship      # Modern cross-shell prompt
brew install eza           # Modern ls replacement
brew install bat           # Cat with syntax highlighting
brew install ripgrep       # Fast grep (rg)
brew install fd            # Fast find
brew install fzf           # Fuzzy finder
brew install zoxide        # Smarter cd
brew install lazygit       # Terminal UI for git
brew install btop          # Better system monitor

# Or install everything at once
brew bundle --file=~/.dotfiles/Brewfile
```

On Linux, install via your package manager or see individual tool docs.

## What's New - 2025 Modernization

This dotfiles setup has been fully modernized with current best practices:

### Replaced
- ❌ ~~CtrlP~~ → ✅ **fzf** - Faster, more powerful fuzzy finder
- ❌ ~~256 colors~~ → ✅ **True color (24-bit)** - Better color rendering
- ❌ ~~Basic plugins~~ → ✅ **Modern plugin suite** - Fugitive, polyglot, gitgutter, etc.
- ❌ ~~Spaceship only~~ → ✅ **Starship prompt** - Cross-shell, faster, more configurable
- ❌ ~~ls~~ → ✅ **eza/exa** - Modern, colorful directory listings
- ❌ ~~cat~~ → ✅ **bat** - Syntax highlighting for cat
- ❌ ~~grep~~ → ✅ **ripgrep** - Blazingly fast search
- ❌ ~~find~~ → ✅ **fd** - User-friendly find alternative

### Added
- ✅ Git: `defaultBranch = main`, `pull.rebase = true`, `colorMoved`, histogram diff
- ✅ Git: `sw` (switch) and `restore` aliases for modern git commands
- ✅ Zsh: 15+ oh-my-zsh plugins for better productivity
- ✅ Zsh: zsh-autosuggestions and zsh-syntax-highlighting
- ✅ Zsh: Smart history (50k entries) with deduplication
- ✅ Tmux: True color support and modern vi copy mode
- ✅ Tmux: Additional plugins (yank, open, cpu)
- ✅ Vim: Comprehensive plugin suite for modern development
- ✅ Comprehensive Brewfile with 70+ curated modern tools

### Improved
- ⚡ Faster shell startup with conditional loading
- 🎨 Better color support across all tools
- 🔧 More intuitive keybindings and aliases
- 📦 Better package management and installation
- 🌍 Better cross-platform compatibility
- 📚 Comprehensive documentation

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

### Shell Prompt

The `.zshrc` is configured to use **Starship** as the default prompt (modern, cross-shell). If not installed, it falls back to Spaceship.

**Recommended: Install Starship**
```bash
# macOS
brew install starship

# Linux
curl -sS https://starship.rs/install.sh | sh
```

**Alternative: Install Spaceship** (zsh-only)
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

- `Ctrl+p` - Fuzzy file finder (fzf)
- `Ctrl+b` - Buffer list (fzf)
- `Ctrl+f` - Search in files with ripgrep (fzf)
- `<leader>c` - Command palette (fzf)
- Auto pairs: Automatic bracket/quote pairing
- Fugitive: `:Git` for git commands, `:Gdiff`, `:Gblame`, etc.
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
- `git sw`: switch branches (modern git)
- `git restore`: restore files (modern git)
- `git graph`: visual commit graph
- `git cleanup`: delete merged branches (handles both main/master)

## Contributing

Feel free to fork this repository and customize it for your own use. If you have suggestions or improvements, pull requests are welcome!

## License

This project is open source and available under the MIT License.

## Credits

Inspired by various dotfiles repositories and the developer community.
