#!usr/bin/env zsh

setopt noautoremoveslash

# 同時に起動したzshの間でヒストリを共有する
setopt share_history
 
# 同じコマンドをヒストリに残さない
setopt hist_ignore_all_dups

# setup history
HISTFILE=~/.zsh_history
HISTSIZE=1000000
SAVEHIST=1000000

########################################
# 補完
# 補完機能を有効にする
autoload -Uz compinit
compinit -C

#alias補完
setopt complete_aliases
 
# 補完で小文字でも大文字にマッチさせる
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}'
# ../ の後は今いるディレクトリを補完しない
zstyle ':completion:*' ignore-parents parent pwd .. 
# sudo の後ろでコマンド名を補完する
zstyle ':completion:*:sudo:*' command-path /usr/local/sbin /usr/local/bin \
                   /usr/sbin /usr/bin /sbin /bin /usr/X11R6/bin
# ps コマンドのプロセス名補完
zstyle ':completion:*:processes' command 'ps x -o pid,s,args'

autoload -Uz zmv
