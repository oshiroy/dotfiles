#!usr/bin/env zsh

#rosm
function rosm () {
 for msg in `rosmsg list | peco`
 do
     echo $msg
     rosmsg show $msg
 done
}
zle -N rosm

#rosc
function rosc () {
  for dir in `rospack list |awk '{ print $1 }'|peco`
  do
    roscd $dir
  done
}
zle -N rosc

#rosbp (rosbag play)
function rosbp () {
    for bag in `find ~/rosbags -type f ! -name '*.orig.bag'|peco`
    do
	rosbag play $bag $*
    done
}
zle -N rosbp


#rosnode
function rosn () {
    #  case $1 in
    #   ping)
    #   option="ping"
    #   ;;
    #   info)
    #   option="info"
    #   ;;
    #   machine)
    #   option="machine"
    #   ;;
    #   kill)
    #   option="kill"
    #   ;;
    #   cleanup)
    #   option="cleanup"
    #   ;;
    #   * )
    #   help
    #   return
    #   ;;
    # esac
 for nod in `rosnode list | peco `
 do
  rosnode info $nod
 done
}
zle -N rosn

#rostopic
function rost() {
 for tpc in `rostopic list | peco`
 do
     rostopic info $tpc
 done
}
zle -N rost

function eusgrep() {
    for res in `find ~/ -type f -name "*.l" |xargs grep $1| peco`
}
zle -N eusgrep

function eusdef() {
    for res in `find ~/ -type f -name "*.l" |xargs grep $1 |egrep 'defun|defclass|defmethod|defmacro'| peco`
}
zle -N eusdef


# topic name percol select
function percol-select-topic() {
  BUFFER=$LBUFFER$(rostopic list | percol)
  zle -R -c
}
zle -N percol-select-topic
