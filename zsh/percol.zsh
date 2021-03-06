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
    for launch in `find ~/ros/hydro -type f -name "*.launch" |xargs grep $1| percol`
}
zle -N launchgrep

# emacs open file by using percol
function emp() {
    for file in `ls -a |percol`
    do
      em $file
    done
}
zle -N emp


# grep ward in file and open em by percol
function grep-open () {
    for file in `grep -riIn $1 * .|percol | awk '{ print $1 }'| sed  's/\:\(.*\)//g'`
    do
	em  $file
    done
}
zle -N grep-open


function gcloud-set-project() {
  project=`gcloud projects list | peco |awk '{print$1}'`
  echo "gcloud config set project ${project}"
  gcloud config set project ${project}
}
zle -N gcloud-set-project

function gcloud-set-account(){
    account=`gcloud auth list | sed 1,2d |sed  -e "s/*//g" |sed -e "s/\ //g" |awk "{print$1}" | peco`
    echo "gcloud config set account ${account}"
    gcloud config set account ${account}
}
zle -N gcloud-set-account
