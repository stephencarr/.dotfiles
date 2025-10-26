# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH

# Path to your oh-my-zsh installation.
export ZSH="$HOME/.oh-my-zsh"

# Set name of the theme to load. Optionally, if you set this to "random"
# it'll load a random theme each time that oh-my-zsh is loaded.
# See https://github.com/robbyrussell/oh-my-zsh/wiki/Themes
ZSH_THEME="robbyrussell"

# Spaceship theme variables

SPACESHIP_PACKAGE_SHOW=false

SPACESHIP_GIT_SYMBOL="👉  "

# GIT STATUS
SPACESHIP_GIT_STATUS_SHOW=true
SPACESHIP_GIT_STATUS_PREFIX=" "
SPACESHIP_GIT_STATUS_SUFFIX=" "
SPACESHIP_GIT_STATUS_COLOR="yellow"
SPACESHIP_GIT_STATUS_UNTRACKED="?"
SPACESHIP_GIT_STATUS_ADDED="+"
SPACESHIP_GIT_STATUS_MODIFIED="!"
SPACESHIP_GIT_STATUS_RENAMED="»"
SPACESHIP_GIT_STATUS_DELETED="✘"
SPACESHIP_GIT_STATUS_STASHED="☾ "
SPACESHIP_GIT_STATUS_UNMERGED="="
SPACESHIP_GIT_STATUS_AHEAD="⇡"
SPACESHIP_GIT_STATUS_BEHIND="⇣"
SPACESHIP_GIT_STATUS_DIVERGED="⇕"

# Set list of themes to load
# Setting this variable when ZSH_THEME=random
# cause zsh load theme from this variable instead of
# looking in ~/.oh-my-zsh/themes/
# An empty array have no effect
# ZSH_THEME_RANDOM_CANDIDATES=( "robbyrussell" "agnoster" )

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion. Case
# sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

# Uncomment the following line to disable bi-weekly auto-update checks.
# DISABLE_AUTO_UPDATE="true"

# Uncomment the following line to change how often to auto-update (in days).
# export UPDATE_ZSH_DAYS=13

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# The optional three formats: "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# HIST_STAMPS="mm/dd/yyyy"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(
  git
  docker
  docker-compose
  npm
  node
  python
  golang
  rust
  aws
  kubectl
  terraform
  z                          # Jump to frecent directories
  sudo                       # Press ESC twice to add sudo
  colored-man-pages         # Colorize man pages
  command-not-found         # Suggest package for missing commands
  history-substring-search  # Better history search
)

# Source oh-my-zsh if it exists
if [ -f "$ZSH/oh-my-zsh.sh" ]; then
  source $ZSH/oh-my-zsh.sh
else
  echo "Warning: oh-my-zsh not found at $ZSH"
  echo "Install it with: sh -c \"\$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)\""
fi

# Source additional bash configs if they exist
[ -f "$HOME/dev/dotfiles/bash/belt.bash" ] && source "$HOME/dev/dotfiles/bash/belt.bash"

# Load zsh-autosuggestions if installed
if [ -f /usr/local/share/zsh-autosuggestions/zsh-autosuggestions.zsh ]; then
  source /usr/local/share/zsh-autosuggestions/zsh-autosuggestions.zsh
elif [ -f /usr/share/zsh-autosuggestions/zsh-autosuggestions.zsh ]; then
  source /usr/share/zsh-autosuggestions/zsh-autosuggestions.zsh
fi

# Load zsh-syntax-highlighting if installed (must be last)
if [ -f /usr/local/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh ]; then
  source /usr/local/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
elif [ -f /usr/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh ]; then
  source /usr/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
fi

# User configuration

# Better history configuration
HISTSIZE=50000
SAVEHIST=50000
setopt EXTENDED_HISTORY          # Write timestamp to history
setopt INC_APPEND_HISTORY        # Write to history immediately
setopt SHARE_HISTORY             # Share history between sessions
setopt HIST_IGNORE_DUPS          # Don't record duplicates
setopt HIST_IGNORE_ALL_DUPS      # Delete old duplicates
setopt HIST_FIND_NO_DUPS         # Don't show duplicates in search
setopt HIST_IGNORE_SPACE         # Don't record commands starting with space
setopt HIST_SAVE_NO_DUPS         # Don't save duplicates
setopt HIST_REDUCE_BLANKS        # Remove superfluous blanks

# Autocomplete with hidden files
setopt globdots

# Better directory navigation
setopt AUTO_CD                   # cd by typing directory name
setopt AUTO_PUSHD                # Push directories to stack
setopt PUSHD_IGNORE_DUPS         # Don't push duplicates
setopt PUSHD_SILENT              # Don't print directory stack

# Set default editor
export EDITOR='vim'
export VISUAL='vim'

# Better language settings
export LANG=en_US.UTF-8
export LC_ALL=en_US.UTF-8

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

# ssh
# export SSH_KEY_PATH="~/.ssh/rsa_id"

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.
#

# Modern ls replacement (eza/exa) or fallback to ls
if command -v eza >/dev/null 2>&1; then
  alias ls="eza --icons --group-directories-first"
  alias ll="eza -l --icons --group-directories-first"
  alias la="eza -la --icons --group-directories-first"
  alias lt="eza --tree --level=2 --icons"
  alias lsd="eza -lD --icons"
elif command -v exa >/dev/null 2>&1; then
  alias ls="exa --icons --group-directories-first"
  alias ll="exa -l --icons --group-directories-first"
  alias la="exa -la --icons --group-directories-first"
  alias lt="exa --tree --level=2 --icons"
  alias lsd="exa -lD --icons"
else
  # Fallback to traditional ls
  if ls --color > /dev/null 2>&1; then # GNU `ls`
    colorflag="--color"
  else # macOS `ls`
    colorflag="-G"
  fi
  alias ls="ls -GFh ${colorflag}"
  alias ll="ls -AlFh"
  alias la="ls -laF ${colorflag}"
  alias lsd='ls -lF ${colorflag} | grep "^d"'
fi

# Modern cat replacement
command -v bat >/dev/null 2>&1 && alias cat="bat --style=plain"

# Better grep with color
alias grep="grep --color=auto"
alias fgrep="fgrep --color=auto"
alias egrep="egrep --color=auto"

# Modern find/grep
command -v fd >/dev/null 2>&1 && alias find="fd"
command -v rg >/dev/null 2>&1 && alias grep="rg"

alias startihdev="bundle exec passenger start -a 0.0.0.0 -p 3000 --max-pool-size 1 --spawn-method conservative -e development"

# Sublime Text alias (macOS only)
if [[ "$OSTYPE" == "darwin"* ]] && [ -d "/Applications/Sublime Text.app" ]; then
  alias subl="/Applications/Sublime\ Text.app/Contents/SharedSupport/bin/subl"
fi

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

  # Modern prompt: Starship (cross-shell) or Spaceship (zsh-only)
  # Starship is the modern recommendation - install with: brew install starship
  if command -v starship >/dev/null 2>&1; then
    eval "$(starship init zsh)"
  elif [ -n "$ZSH_CUSTOM" ] && [ -f "$ZSH_CUSTOM/themes/spaceship.zsh-theme" ]; then
    # Fallback to Spaceship if installed
    autoload -U promptinit; promptinit
    prompt spaceship
  fi

# Add RVM to PATH for scripting (if installed)
[ -d "$HOME/.rvm/bin" ] && export PATH="$PATH:$HOME/.rvm/bin"

# Imagemagick to PATH (macOS Homebrew)
[ -d "/usr/local/opt/imagemagick@6/bin" ] && export PATH="/usr/local/opt/imagemagick@6/bin:$PATH"

# Add Postgres App to PATH (macOS)
[ -d "/Applications/Postgres.app/Contents/Versions/9.6/bin" ] && export PATH="/Applications/Postgres.app/Contents/Versions/9.6/bin:$PATH"

# Qt to PATH (if installed)
[ -d "$HOME/Qt5.5.0/5.5/clang_64/bin" ] && export PATH="$HOME/Qt5.5.0/5.5/clang_64/bin:$PATH"

# thefuck alias (if installed)
# command -v thefuck >/dev/null 2>&1 && eval $(thefuck --alias)

# Adds all known identities to the SSH agent (macOS)
[[ "$OSTYPE" == "darwin"* ]] && ssh-add -A 2>/dev/null
