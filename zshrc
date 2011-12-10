# Göran Gustafsson (gustafsson.g@gmail.com)

export GEM_HOME=~/.ruby
export LC_COLLATE=C
export PAGER=less

TODO_FILE=~/Documents/Text\ Files/Things\ to\ Do.txt

HISTFILE=~/.zsh_histfile
HISTSIZE=2000
SAVEHIST=4000

if [[ $OSTYPE == darwin* ]]; then
	export EDITOR="/Applications/MacVim.app/Contents/MacOS/Vim -g --remote-tab-silent"
	export VISUAL=$EDITOR

	FLACDIR=/Volumes/Black\ Disk/Music/FLAC
	MP3DIR=/Volumes/Black\ Disk/Music/MP3

	path=(/usr/local/bin /usr/local/sbin /bin /sbin /usr/bin /usr/sbin /usr/X11/bin ~/Scripts ~/.ruby/gems/*/bin)
else
	export EDITOR=vim
	export VISUAL=$EDITOR

	export LS_COLORS="ln=01;34"
	export LS_COLORS="$LS_COLORS:*.bmp=01;33:*.gif=01;33:*.ico=01;33:*.jpg=01;33:*.jpeg=01;33:*.png=01;33:*.svg=01;33:*.tiff=01;33"
	export LS_COLORS="$LS_COLORS:*.flac=01;35:*.nsf=01;35:*.nsfe=01;35:*.m4r=01;35:*.mp3=01;35:*.ogg=01;35:*.wav=01;35"
	export LS_COLORS="$LS_COLORS:*.avi=01;36:*.flv=01;36:*.f4v=01;36:*.mkv=01;36:*.mov=01;36:*.mpg=01;36:*.mpeg=01;36:*.mp4=01;36:*.m4v=01;36:*.wmv=01;36"
	export LS_COLORS="$LS_COLORS:*.dmg=01;31:*.iso=01;31:*.rar=01;31:*.tar=01;31:*.tar.bz2=01;31:*.tar.gz=01;31:*.zip=01;31"

	FLACDIR=~/Music/FLAC
	MP3DIR=~/Music/MP3

	path=(/bin /sbin /usr/bin /usr/sbin /usr/local/bin /usr/local/sbin ~/Scripts)

	if [[ $(tty) == /dev/tty1 ]]; then
		startx

		[ $? -eq 0 ] && exit
	fi
fi

setopt correctall
setopt interactivecomments
setopt longlistjobs
setopt nobeep
setopt notify
setopt promptsubst

setopt appendhistory
setopt extendedhistory
setopt histexpiredupsfirst
setopt histignoredups
setopt histverify
setopt incappendhistory

setopt combiningchars
setopt noautomenu

[[ ! $TERM == dumb ]] && autoload -U colors && colors
autoload -U compinit && compinit
autoload -U url-quote-magic && zle -N self-insert url-quote-magic

bindkey -v
bindkey '^?' backward-delete-char
bindkey -M vicmd 'R' custom-vi-replace

zstyle ':completion:*'          matcher-list 'm:{a-z}={A-Z}'
zstyle ':completion:*'          special-dirs true
zstyle ':completion:*:cd:*'     ignore-parents parent pwd
zstyle ':completion:*:warnings' format "zsh: no matches found."

compdef _man man-preview
compdef _path_files cd

precmd() {
	echo
}

if [[ $OSTYPE == darwin* ]]; then
	SED=gsed
else
	SED=sed
fi

function git_branch {
	ref=$(git symbolic-ref HEAD 2> /dev/null) || return
	BRANCH_FIXED=$(echo "${ref#refs/heads/}" | sed 's/^./\U&/')

	if [[ -n $(git status -s 2> /dev/null) ]]; then
		echo "%{$fg[red]%}$BRANCH_FIXED%{$reset_color%}"
	else
		echo "%{$fg[green]%}$BRANCH_FIXED%{$reset_color%}"
	fi
}

function custom-vi-replace {
	REPLACE=1 && zle vi-replace && REPLACE=0
}
zle -N custom-vi-replace

function zle-line-init zle-keymap-select {
	zle reset-prompt
}
zle -N zle-line-init && zle -N zle-keymap-select

function zsh_mode {
	if [[ $KEYMAP == vicmd ]]; then
		echo "%{$fg[red]%}E%{$reset_color%}"
	elif [[ $REPLACE == 1 ]]; then
		echo "%{$fg[magenta]%}R%{$reset_color%}"
	else
		echo "%{$fg[blue]%}$%{$reset_color%}"
	fi
}

USER_FIXED=$(echo $USER | $SED 's/^./\U&/')
HOST_FIXED=$(hostname -s | $SED 's/^./\U&/')

PROMPT='%B$USER_FIXED %{$fg[yellow]%}$HOST_FIXED%{$reset_color%} %~ $(zsh_mode)%b '
RPROMPT='%B$(git_branch)%b'

if [[ $OSTYPE == darwin* ]]; then
	alias c="clear"
	alias dontsleep="pmset noidle"
	alias eject="osascript -e 'tell application \"Finder\" to eject (every disk whose ejectable is true)'"

	alias cvim="/Applications/MacVim.app/Contents/MacOS/Vim"
	alias vimp="/Applications/MacVim.app/Contents/MacOS/Vim - -g >& /dev/null"

	alias dae="ls -lae"
	alias de="ls -le"
	alias ls="ls -Gh"

	alias f="open ."
	alias o="open"

	alias awk="gawk"
	alias head="ghead"
	alias sed="gsed"
	alias sort="gsort"
	alias tail="gtail"
	alias wc="gwc"

	alias startmpd="mpd"
	alias stopmpd="mpc stop; mpd --kill"
else
	alias c="clearcmd"
	alias cal="cal -m"
	alias ls="ls -h --color=auto"
	alias vimp="vim -"
	alias vl="tail -n $LINES -f /var/log/everything.log"

	alias paci="sudo pacman -S"
	alias pacr="sudo pacman -Rs"
	alias pacu="sudo pacman -Syu"
fi

alias bc="bc -q"
alias df="df -h"
alias favs="cat ~/.mpd/playlists/Favorites.m3u > ~/.mpd/tmp.playlist && sort ~/.mpd/tmp.playlist | uniq > ~/.mpd/playlists/Favorites.m3u"
alias fetch="wget --no-clobber --page-requisites --adjust-extension --convert-links"
alias ff='find . -iname'
alias grep="grep --color=auto -i"
alias hi="history"
alias ip="curl -s http://automation.whatismyip.com/n09230945.asp | html2text"
alias ka="killall"
alias mkdir="mkdir -pv"
alias ping="ping -c 10"
alias pyweb="python3 -m http.server 8080"
alias reload="source ~/.zshrc"
alias s="screen"
alias tv="vim '$TODO_FILE'"
alias yt="youtube-dl -l"

alias -- -="cd -"
alias ...="cd ../.."
alias ..="cd .."
alias cdd="cd ~/Downloads"

alias cl="wc -l"
alias cw="wc -w"
alias g="grep"
alias he="head"
alias l="less"
alias rg="grep -r"
alias so="sort"
alias ta="tail"
alias un="uniq"

alias cp="cp -vi"
alias mv="mv -vi"
alias rm="rm -v"

alias d="ls -l"
alias da="ls -la"
alias l1="ls -1"
alias la="ls -a"

alias gd="popd"
alias sd="pushd"

alias int="tim.sh -i"
alias pomo="tim.sh -p"
alias ti="tim.sh"

alias next="mpc next"
alias prev="mpc prev"
alias song="mpc current"
alias toggle="mpc toggle"

alias top="top -o cpu"
alias topme="top -o cpu -U twiggy"

alias v="vim"
alias vd="vimdiff"
alias vp="vimp"

if [[ $OSTYPE == darwin* ]]; then
	function freespace {
		rm -rf ~/Library/Caches/com.apple.Safari/Webpage\ Previews
		rm -rf ~/Library/Caches/Homebrew
		rm -rf ~/Library/iTunes/iPhone\ Software\ Updates
	}

	function man-preview {
		for arg in $*; do
			man -t $arg | open -f -a Preview
		done
	}

	function ql {
		for arg in $*; do
			qlmanage -p $* >& /dev/null
		done
	}

	function vim {
		if [ -z $1 ]; then
			/Applications/MacVim.app/Contents/MacOS/Vim -g
		else
			/Applications/MacVim.app/Contents/MacOS/Vim -g --remote-tab-silent $*
		fi
	}

	function vimdiff {
		/Applications/MacVim.app/Contents/MacOS/Vim -d -g $* >& /dev/null
	}
else
	if [[ $TERM == rxvt-unicode ]]; then
		function clearcmd {
			for ((i = 1; i < $LINES; i++)); do
				echo
			done

			clear
		}
	else
		alias clearcmd="clear"
	fi

	function pacs {
		CL='\\e['
		RS='\\e[0;0m'

		echo -e "$(pacman -Ss "$*" | sed "
			/^core/         s,.*,${CL}1;31m&${RS},
			/^extra/        s,.*,${CL}0;32m&${RS},
			/^community/    s,.*,${CL}1;35m&${RS},
			/^[^[:space:]]/ s,.*,${CL}0;36m&${RS},
		")" | less -R
	}

	function restart {
		for arg in $*; do
			sudo /etc/rc.d/$arg restart
		done
	}

	function start {
		for arg in $*; do
			sudo /etc/rc.d/$arg start
		done
	}

	function stop {
		for arg in $*; do
			sudo /etc/rc.d/$arg stop
		done
	}
fi

function checkmusic {
	find "$FLACDIR" -type f ! -iname *.flac ! -iname *.log
	find "$MP3DIR" -type f ! -iname *.mp3
}

function h {
	if [ -z $1 ]; then
		history -i 1 | less +G
	else
		history -i 1 | grep "$*"
	fi
}

function mkcd {
	mkdir -p "$*"
	cd "$*"
}

function p {
	if [ -z $1 ]; then
		ps ax
	else
		ps ax | grep -v "grep --color -i $*" | grep "$*"
	fi
}

function permfix {
	[[ $OSTYPE == darwin* ]] && find . -exec chmod -N "{}" \;

	find . -type d -exec chmod 755 "{}" \;
	find . -type f -exec chmod 644 "{}" \;
}

function privatepermfix {
	[[ $OSTYPE == darwin* ]] && find . -exec chmod -N "{}" \;

	find . -type d -exec chmod 700 "{}" \;
	find . -type f -exec chmod 600 "{}" \;
}

function t {
	if [ ! -f $TODO_FILE ]; then
		echo "TODO file does not exist."

		return
	elif [ ! -s $TODO_FILE ]; then
		echo "TODO file is currently empty."

		return
	fi

	if [ -z $1 ]; then
		cat $TODO_FILE
	else
		echo "$*" >> $TODO_FILE
	fi
}

function unp {
	for arg in $*; do
		if [ -f $arg ]; then
			case $arg in
				*.7z)      7z x       $arg ;;
				*.Z)       uncompress $arg ;;
				*.bz2)     bunzip2    $arg ;;
				*.gz)      gunzip     $arg ;;
				*.rar)     unrar x    $arg ;;
				*.tar)     tar vxf    $arg ;;
				*.tar.bz2) tar vxjf   $arg ;;
				*.tar.gz)  tar vxzf   $arg ;;
				*.tbz2)    tar vxjf   $arg ;;
				*.tgz)     tar vxzf   $arg ;;
				*.zip)     unzip      $arg ;;
				*)
					echo "File $arg cannot be extracted via unp."
				;;
			esac
		else
			echo "File $arg does not exist."
		fi
	done
}

