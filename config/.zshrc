# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH

# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# Path to your oh-my-zsh installation.
omz="~/.oh-my-zsh"
export ZSH="${omz/#\~/$HOME}"

# Set name of the theme to load --- if set to "random", it will
# load a random theme each time oh-my-zsh is loaded, in which case,
# to know which specific one was loaded, run: echo $RANDOM_THEME
# See https://github.com/robbyrussell/oh-my-zsh/wiki/Themes
#ZSH_THEME="robbyrussell"
ZSH_THEME="blinks"
# ZSH_THEME="powerlevel10k/powerlevel10k"
# Set list of themes to pick from when loading at random
# Setting this variable when ZSH_THEME=random will cause zsh to load
# a theme from this variable instead of looking in ~/.oh-my-zsh/themes/
# If set to an empty array, this variable will have no effect.
# ZSH_THEME_RANDOM_CANDIDATES=( "robbyrussell" "agnoster" )

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion.
# Case-sensitive completion must be off. _ and - will be interchangeable.
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
# You can set one of the optional three formats:
# "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# or set a custom format using the strftime function format specifications,
# see 'man strftime' for details.
# HIST_STAMPS="mm/dd/yyyy"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Which plugins would you like to load?
# Standard plugins can be found in ~/.oh-my-zsh/plugins/*
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(
  bundler
  dotenv
  osx
  rake
  rbenv
  ruby
  git
  z
  fzf
  extract
  docker
  docker-compose
  zsh-syntax-highlighting
  zsh-autosuggestions
)

source $ZSH/oh-my-zsh.sh

# User configuration

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
# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"
# make ctl-r returns immediately

HISTFILE=~/.zsh_history
HISTSIZE=999999999
SAVEHIST=$HISTSIZE

# Appends every command to the history file once it is executed
setopt inc_append_history

export FZF_MARKS_JUMP=^h
export FZFZ_SUBDIR_LIMIT=0
export FZFZ_EXTRA_OPTS="--reverse"
export FZF_CTRL_R_OPTS="--reverse"

export LD_LIBRARY_PATH="/usr/local/lib/"

export TERM="xterm-256color"

alias vim="nvim"
alias vi="nvim"
alias v="nvim"

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

alias space="du -hs * | sort -h"
alias rg1="rg --max-depth=1"

alias tm="tmux"
alias tma="tmux a"

alias rgf='rg --files | rg'

fshere() {
  cmd="sshfs -o cache=no -o IdentityFile=/home/$USER/.ssh/id_rsa $USER@$@ $PWD"
  echo $cmd
  eval $cmd
  cd ..
  cd -
} 

TRAPWINCH() {
  zle && { zle reset-prompt; zle -R }
}

source-git() {
  target=~/.zsh/$1:t:r
  plugin=$target/$1:t:r.plugin.zsh
  if [ ! -d "$target" ] ; then
    git clone $1 $target
    #echo "git clone $1 $target"
  fi
  if [ ! -f "$plugin" ]; then
    plugin=$target/$1:t:r
  fi
  source $plugin
  #echo "source $plugin"
}

source-git https://github.com/supasorn/fzf-z.git 
source-git https://github.com/changyuheng/zsh-interactive-cd.git 
source-git https://github.com/zsh-users/zsh-autosuggestions.git 
source-git https://github.com/hchbaw/zce.zsh.git
source-git https://github.com/urbainvaes/fzf-marks
source-git https://github.com/zsh-users/zsh-completions
source-git https://github.com/zsh-users/zsh-history-substring-search
source-git https://github.com/zsh-users/zsh-syntax-highlighting.git

bindkey '^[[Z' autosuggest-accept
bindkey '^f' zce

ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE="fg=#ff00ff,bg=cyan,bold,underline"

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ -f ~/.p10k.zsh ]] && source ~/.p10k.zsh

autoload -U compinit && compinit

if [ -f /etc/os-release ]; then
    # freedesktop.org and systemd
    . /etc/os-release
    OS=$NAME
    VER=$VERSION_ID
elif type lsb_release >/dev/null 2>&1; then
    # linuxbase.org
    OS=$(lsb_release -si)
    VER=$(lsb_release -sr)
elif [ -f /etc/lsb-release ]; then
    # For some versions of Debian/Ubuntu without lsb_release command
    . /etc/lsb-release
    OS=$DISTRIB_ID
    VER=$DISTRIB_RELEASE
elif [ -f /etc/debian_version ]; then
    # Older Debian/Ubuntu/etc.
    OS=Debian
    VER=$(cat /etc/debian_version)
elif [ -f /etc/SuSe-release ]; then
    # Older SuSE/etc.
    ...
elif [ -f /etc/redhat-release ]; then
    # Older Red Hat, CentOS, etc.
    ...
else 
    # Fall back to uname, e.g. "Linux <version>", also works for BSD, etc.
    OS=$(uname -s)
    VER=$(uname -r)
fi

if [[ $OS == "Ubuntu" ]]; then

  # Lib
  export LD_LIBRARY_PATH="/usr/local/cuda/lib64":$LD_LIBRARY_PATH

  # Path
  export PATH=$PATH:~/go/bin
  export PATH="/mnt/glacier/home/w/anaconda3/bin:$PATH"

  # Alias
  alias vi="nvim"
  alias ssh139="ssh root@128.199.88.139"

fi