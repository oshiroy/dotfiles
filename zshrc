#!usr/bin/env zsh
# Path
export ZSH=$HOME/.dotfiles/zsh/plugins/oh-my-zsh
export DOTZSHDIR=$HOME/.dotfiles/zsh
export GOPATH=$HOME/.local/bin/go
export PATH=$PATH:$HOME/bin:$GOPATH/bin

# pip --user path
export PATH=$HOME/.local/bin:$PATH

# caffe pythonpath
if [ -e $HOME/caffe ] ; then
    export PYTHONPATH=$HOME/caffe/python/:$PYTHONPATH
fi

#
# export PYTHONPATH=~/chainer/:$PYTHONPATH

# cuda path
if [ -e /usr/local/cuda ] ; then
    export CUDA_ROOT=/usr/local/cuda
    export CUDA_PATH=$CUDA_ROOT
    export PATH=$CUDA_ROOT/bin:$PATH
    export LD_LIBRARY_PATH=$CUDA_ROOT/lib64:$LD_LIBRARY_PATH
fi


###### OpenCV
 # PKG_CONFIG_PATH=$PKG_CONFIG_PATH:/usr/local/lib/pkgconfig
 # export PKG_CONFIG_PATH

if ! [ $EMACS ]; then
    ZSH_THEME="agnoster"
else
    ZSH_THEME="gentoo"
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

export PATH=$HOME/bin:/usr/local/bin:$PATH
# export MANPATH="/usr/local/man:$MANPATH"

# oh-my-zsh plugins
plugins=(git)

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
bindkey '^[r' percol-select-topic

# for pycd activation
# source `which pycd.sh`

# for checking zsh speed
# if (which zprof > /dev/null) ;then
#     zprof | less
# fi

# vncserver :1

# pyenv
if [ -e $HOME/.pyenv ] ; then
    export PYENV_ROOT=$HOME/.pyenv
    export PATH=$PYENV_ROOT/bin:$PATH
    eval "$(pyenv init -)"
fi
