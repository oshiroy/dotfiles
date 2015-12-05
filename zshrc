
# Path
export ZSH=$HOME/.oh-my-zsh
export DOTZSHDIR=$HOME/.dotfiles/zsh

if ! [ $EMACS ]; then
    ZSH_THEME="oshiroy"
else
    ZSH_THEME="gentoo"
fi
if [ -n "$DISPLAY" -a "$TERM" = "xterm" ]; then
  export TERM=xterm-256color
fi

# tmux auto start
#if [ -z $TMUX ]; then
  # tmuxのオプションに-2を付けないとubuntuのtmux上でvimがカラーにならない
# tmux -2
#fi

# Uncomment the following line to use hyphen-insensitive completion. Case
# sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

# Uncomment the following line to disable bi-weekly auto-update checks.
# DISABLE_AUTO_UPDATE="true"

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

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(git)

# User configuration

export PATH=$HOME/bin:/usr/local/bin:$PATH
# export MANPATH="/usr/local/man:$MANPATH"

source $ZSH/oh-my-zsh.sh
for plugin ($DOTZSHDIR/plugins/*) source $plugin
for config_file ($DOTZSHDIR/*.zsh) source $config_file

# Compilation flags
# export ARCHFLAGS="-arch x86_64"
# ssh
# export SSH_KEY_PATH="~/.ssh/dsa_id"

## SVN and SSH
export SSH_USER=oshiro
export SVN_SSH="ssh -l ${SSH_USER}"

## bind key
bindkey '^r' peco-select-history


# for checking zsh speed
# if (which zprof > /dev/null) ;then
#     zprof | less
# fi
