#!usr/bin/env zsh

# z
autoload -Uz is-at-least
if is-at-least 4.3.11
then
  autoload -Uz chpwd_recent_dirs cdr add-zsh-hook
  add-zsh-hook chpwd chpwd_recent_dirs
  zstyle ':chpwd:*' recent-dirs-max 5000
  zstyle ':chpwd:*' recent-dirs-default yes
  zstyle ':completion:*' recent-dirs-insert both
fi

function peco-cdr {
    for dir in `cdr -l | awk '{print $2}' | peco `
    do
      cd $dir
    done
}
zle -N peco-cdr

alias pcd='peco-cdr'
