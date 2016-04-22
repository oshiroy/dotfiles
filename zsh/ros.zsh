#!usr/bin/env zsh
## ROS DISTRO
#source $HOME/ros/groovy/setup.bash
#source $HOME/ros/hydro/devel/setup.zsh
source $HOME/ros/indigo/devel/setup.zsh

## Rviz for a laptop user
export OGRE_RTT_MODE=Copy

#euslib
export CVSDIR=~/prog
export OPENHRPHOME=$CVSDIR/OpenHRP

export GOROOT=/usr/local/go
export GOPATH=$HOME/go
export PATH=$PATH:$GOROOT/bin:$GOPATH/bin

## rlwrap roseus alias
if ! [ $EMACS ]; then
    alias roseus="rlwrap -c -b '(){}.,;|'-a -pGREEN roseus"
fi

########################################
##            rossethrp2              ##
########################################
function rossethrp2017() {
    rossetrobot hrp2017v 10017
    export ROBOT=HRP2JSKNTS
    export HRP2NO=17
    rossetip
}
function rossethrp2016() {
    rossetrobot hrp2016v 10016
    export ROBOT=HRP2JSKNT
    export HRP2NO=16
    rossetip
}
function rossethrp2007() {
    rossetrobot hrp2007v 10007
    export ROBOT=HRP2JSK
    export HRP2NO=7
    rossetip
}
function rossethrp2008() {
    rossetrobot hrp2008v 10008
    export ROBOT=HRP2W
    export HRP2NO=8
    rossetip
}
function rossethrp2018() {
    rossetrobot hrp2018v 10018
    export ROBOT=HRP2W
    export HRP2NO=8
    rossetip
}

# function roscd {
#     local rosvals
#     if [[ $1 = "--help" ]] | [[ $# -gt 1 ]]; then
#         echo -e "usage: roscd package\n\nJump to target package."
#         return 0
#     fi

#     if [ -z $1 ]; then
#       cd ~/ros/hydro/devel
#       return 0
#     fi

#     _ros_decode_path $1 forceeval

#     if [ $? != 0 ]; then
#       echo "roscd: No such package '$1'"
#       return 1
#     elif [ -z ${rosvals[1]} ]; then
#       cd ~ros/hydro/devel
#       return 0
#     else
# 	cd ${rosvals[2]}${rosvals[3]}${rosvals[4]}
#       return 0
#     fi
# }
