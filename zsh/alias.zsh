#!usr/bin/env zsh
#
# alias
#
alias la='ls -a'
alias ll='ls -l'

alias rm='rm -i'
alias cp='cp -i'
alias mv='mv -i'

alias mkdir='mkdir -p'
 
# sudo の後のコマンドでエイリアスを有効にする
alias sudo='sudo '

# グローバルエイリアス
alias -g L='| less'
alias -g G='| grep'
 
# C で標準出力をクリップボードにコピーする
# mollifier delta blog : http://mollifier.hatenablog.com/entry/20100317/p1
if which pbcopy >/dev/null 2>&1 ; then
    # Mac
    alias -g C='| pbcopy'
elif which xsel >/dev/null 2>&1 ; then
    # Linux
    alias -g C='| xsel --input --clipboard'
elif which putclip >/dev/null 2>&1 ; then
    # Cygwin
    alias -g C='| putclip'
fi

#python alias
alias ipy='ipython'
alias py='python'

#emacs alias
#alias em='emacs -nw'
alias eshell='emacs -nw -f shell'

function em(){
    if [[ -z $(ps ax | egrep -i emacs | egrep daemon) ]]; then
	emacs --daemon
    fi
    emacsclient -nw $@
}

function kill-emacs(){
    emacsclient -e "(kill-emacs)"
}


alias jsknet='ssh aries -D localhost:1080' #HTTP_PROXY = 0, Socks host=localhost,1080
#alias eusdemo='cd ~/prog/euslib/demo/oshiro'
