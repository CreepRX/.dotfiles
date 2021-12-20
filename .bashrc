
# If not running interactively, don't do anything
case $- in
    *i*) ;;
      *) return;;
esac

if ! shopt -oq posix; then
  if [ -f /usr/share/bash-completion/bash_completion ]; then
    . /usr/share/bash-completion/bash_completion
  elif [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
  fi
fi

source /usr/share/git/completion/git-prompt.sh

export PS1="\[\033[38;5;6m\]\u\[\033[38;5;8m\]@\[\033[38;5;10m\]\h\[\033[38;5;8m\]-\[\033[38;5;6m\][\[\033[38;5;9m\]\W\[\033[38;5;7m\]\$(__git_ps1 ' (%s) ')\[\033[38;5;6m\]]\[\033[38;5;8m\]\\$ \[\$(tput sgr0)\]"

#coloured manpages
export LESS_TERMCAP_mb=$'\e[1;32m'
export LESS_TERMCAP_md=$'\e[1;32m'
export LESS_TERMCAP_me=$'\e[0m'
export LESS_TERMCAP_se=$'\e[0m'
export LESS_TERMCAP_so=$'\e[01;33m'
export LESS_TERMCAP_ue=$'\e[0m'
export LESS_TERMCAP_us=$'\e[1;4;31m'
export PAGER="most"

alias less=most

export VISUAL=nvim
export EDITOR=nvim

alias grep='grep --color=auto'

alias c=clear

alias pick-color="colorpicker --short --one-shot 2> /dev/null | tee | xclip -sel c "

function nav(){
	dir='.'
	while [[ ! $dir == "" ]]; do
		cd $dir
		list="$(/bin/ls $@)"
    for l in $list
    do
      [[ -d $l ]] && dirlist="$dirlist $l" || flist="$l $flist"
    done
		[[ $dirlist == *'..'* ]] || dirlist=".. . $dirlist"
    header="$(dirs)
${flist:+Files: }
$flist"
	  dir="$(echo  $dirlist | tr ' ' '\n' | fzf --no-sort --header="$header" --prompt='Search: ' --no-info)"
    unset dirlist list header flist
	done
}

function delete(){
	files="$( /bin/ls -a | fzf -m | tr '\n' ' ' )"
	[[ $files == "" ]] && return
	rm $@ $files
}
function make-homework(){
	if [ $# -eq 0 ]
  	then
    		echo "err: No arguments"
		return -1
	fi
	touch vclj2729_B$1_A{1..4}.tex
}

function ind(){
    $1 &>>~/.app.log &disown
}

function rename-homework(){
	declare -i i=1
	for f in $(ls . | grep .$2); do
        echo $i
		 mv -- "$f" "vclj2729_B$1_A$i.$2" 
		i=$((i+1))
	done
} 

function fix-keybind(){
    xkbcomp /home/gibi/.xkbmap $DISPLAY &> /home/gibi/.keybind.log
    # gsettings set org.gnome.settings-daemon.plugins.keyboard active false
}

function clip (){
   xclip -sel c <$1
}

function generate-ssh-github(){

  if ! test -f "${HOME}/.ssh/id_ed25519.pub"
  then
  ssh-keygen -t ed25519 -C "24712554+Ghibranalj@users.noreply.github.com"
  ssh-add ~/.ssh/id_ed25519
  fi
  echo ==============================================
  cat ~/.ssh/id_ed25519.pub
  clip ~/.ssh/id_ed25519.pub
  echo == copied to clipboard ==
  
}

if command -v exa &> /dev/null
then 
    alias ls='exa -g'
else
    alias ls='ls --color=auto'
fi
alias ll='ls -alhF'
alias la='ls -Ah'
alias l='ls -Fh'

alias lso='/bin/ls'

alias grep='grep --color=auto'
alias fgrep='fgrep --color=auto'
alias egrep='egrep --color=auto'

if command -v cpg &> /dev/null
then
	alias cp='cpg -g'
fi

if command -v mvg &> /dev/null
then
	alias mv='mvg -g'
fi

if command -v ranger &> /dev/null
then
  alias f=ranger
fi

if command -v go &> /dev/null
then
    export GOPATH="$HOME/.go"
    export PATH=$PATH:$(go env GOPATH)/bin
fi

if command -v todo-cli &> /dev/null
then
  todo-cli check 2> /dev/null
  if [ $? -eq 0 ] && [ -z ${TODO+x} ]
  then
	todo-cli print
	export TODO="shown"
  fi
fi
