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
plugins=(git)

# Source oh-my-zsh if it exists
if [ -f "$ZSH/oh-my-zsh.sh" ]; then
  source $ZSH/oh-my-zsh.sh
else
  echo "Warning: oh-my-zsh not found at $ZSH"
  echo "Install it with: sh -c \"\$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)\""
fi

# Source additional bash configs if they exist
[ -f "$HOME/dev/dotfiles/bash/belt.bash" ] && source "$HOME/dev/dotfiles/bash/belt.bash"

# User configuration

# Autocomplete with hidden files
setopt globdots

# export MANPATH="/usr/local/man:$MANPATH"

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
# if [[ -n $SSH_CONNECTION ]]; then
#   export EDITOR='vim'
# else
#   export EDITOR='mvim'
# fi

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

# ssh
# export SSH_KEY_PATH="~/.ssh/rsa_id"

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.
#

# Detect which `ls` flavor is in use
if ls --color > /dev/null 2>&1; then # GNU `ls`
 colorflag="--color"
else # OS X `ls`
 colorflag="-G"
fi

alias ls="ls -GFh ${colorflag}"
alias ll="ls -AlFh"
alias la="ls -laF ${colorflag}" # List all files colorized in long format, including dot files
alias lsd='ls -lF ${colorflag} | grep "^d"' # List only directories

alias startihdev="bundle exec passenger start -a 0.0.0.0 -p 3000 --max-pool-size 1 --spawn-method conservative -e development"

# Sublime Text alias (macOS only)
if [[ "$OSTYPE" == "darwin"* ]] && [ -d "/Applications/Sublime Text.app" ]; then
  alias subl="/Applications/Sublime\ Text.app/Contents/SharedSupport/bin/subl"
fi

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

  # Set Spaceship ZSH as a prompt (if installed)
  if [ -n "$ZSH_CUSTOM" ] && [ -f "$ZSH_CUSTOM/themes/spaceship.zsh-theme" ]; then
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
