#!usr/bin/env zsh

# kill function
function pekill () {
  for pid in `ps -ef | peco | awk '{ print $2 }'`
  do
    kill $pid
  done
}
zle -N pekill

# search history
function peco-select-history() {
  local tac
  if which tac > /dev/null; then
    tac="tac"
  else
    tac="tail -r"
  fi
  BUFFER=$(\history -n 1 | eval $tac | peco --query "$LBUFFER")
  CURSOR=$#BUFFER
  zle clear-screen
}
zle -N peco-select-history

function launchgrep() {
    for launch in `find ~/ros/hydro -type f -name "*.launch" |xargs grep $1| peco`
}
zle -N launchgrep

# emacs open file by using peco
function emp() {
    for file in `ls -a |peco`
    do
      em $file
    done
}
zle -N emp

