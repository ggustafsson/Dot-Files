# Göran Gustafsson <gustafsson.g@gmail.com>

export GEM_HOME=~/.ruby
export LC_COLLATE=C

export LESS=FRX
export PAGER=less

if [[ $OSTYPE == darwin* ]]; then
  export EDITOR="/Applications/MacVim.app/Contents/MacOS/Vim -g --remote-tab-silent"
  export GIT_EDITOR="/Applications/MacVim.app/Contents/MacOS/Vim"
  export VISUAL=$EDITOR
else
  export EDITOR=vim
  export GIT_EDITOR=$EDITOR
  export VISUAL=$EDITOR
fi

[ -f ~/.ssh/config ] && SSH_HOSTS=($(sed -ne 's/^Host //p' < ~/.ssh/config))
DIRSTACKSIZE=17
TODO_FILE=~/Documents/Text\ Files/To-do\ List.txt

HISTFILE=~/.zsh_histfile
HISTSIZE=2000
SAVEHIST=6000

if [[ $OSTYPE == darwin* ]]; then
  path=(/usr/local/bin /usr/local/sbin /bin /sbin /usr/bin /usr/sbin /usr/X11/bin ~/Scripts ~/.ruby/gems/*/bin(N))
else
  path+=(~/Scripts ~/.ruby/gems/*/bin(N))
fi

setopt correct
setopt interactivecomments
setopt longlistjobs
setopt nobeep
setopt noclobber
setopt notify
setopt promptsubst

setopt appendhistory
setopt extendedhistory
setopt histexpiredupsfirst
setopt histignoredups
setopt histreduceblanks
setopt histverify
setopt incappendhistory

setopt autopushd
setopt pushdignoredups

setopt combiningchars
setopt noautomenu

[[ ! $TERM == dumb ]] && autoload -U colors && colors
autoload -U compinit && compinit
autoload -U url-quote-magic && zle -N self-insert url-quote-magic

bindkey -v
bindkey '^?' backward-delete-char
bindkey -M vicmd 'R' custom-vi-replace

zstyle ':completion:*'          insert-tab pending
zstyle ':completion:*'          matcher-list 'm:{a-z}={A-Z}'
zstyle ':completion:*'          special-dirs true
zstyle ':completion:*:cd:*'     ignore-parents parent pwd
zstyle ':completion:*:warnings' format "zsh: no matches found."

[[ $OSTYPE == darwin* ]] && compdef _man manp
compdef _path_files cd
compdef _path_files git add

precmd() {
  echo
}

function git_branch {
  REFERENCE=$(git symbolic-ref HEAD 2> /dev/null) || return
  BRANCH=${REFERENCE#refs/heads/}

  if [[ -n $(git rev-list origin..HEAD 2> /dev/null) ]]; then
    if [[ -n $(git status -s 2> /dev/null) ]]; then
      echo "%F{cyan}ahead %F{red}$BRANCH%f"
    else
      echo "%F{cyan}ahead %F{green}$BRANCH%f"
    fi
  elif [[ -n $(git status -s 2> /dev/null) ]]; then
    echo "%F{red}$BRANCH%f"
  else
    echo "%F{green}$BRANCH%f"
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
    echo "%F{red}E%f"
  elif [[ $REPLACE == 1 ]]; then
    echo "%F{magenta}R%f"
  else
    echo "%F{blue}$%f"
  fi
}

if [[ $TERM == dumb ]]; then
  PROMPT='%~ $ '
else
  PROMPT='%B${(C)USER} %F{yellow}${(C)HOST%%.*}%f%b %~ %B$(zsh_mode)%b '
  RPROMPT='%B$(git_branch)%b'
fi

if [[ $OSTYPE == darwin* ]]; then
  alias capit="imagesnap -t 2 -w 1"
  alias cdb="cd /Volumes/Black\ Disk"
  alias dontsleep="pmset noidle"
  alias eject="osascript -e 'tell application \"Finder\" to eject (every disk whose ejectable is true)' && echo 'All external drives ejected!'"
  alias ls="ls -Gh"
  alias o="open"
  alias update="brew update && brew upgrade"

  alias awk="gawk"
  alias cal="gcal -s 1"
  alias head="ghead"
  alias sed="gsed"
  alias sort="gsort"
  alias tail="gtail"
  alias wc="gwc"

  alias console="open -a Console"
  alias safari="open -a Safari"

  alias cv="cvim"
  alias cvim="/Applications/MacVim.app/Contents/MacOS/Vim"
  alias vimdiff="/Applications/MacVim.app/Contents/MacOS/Vim -d -g $* >& /dev/null"

  alias dae="ls -lae"
  alias de="ls -le"
else
  alias cal="cal -m"
  alias ls="ls -h --color=auto"
  alias vl="tail -n $LINES -f /var/log/everything.log"

  alias paci="sudo pacman -S"
  alias pacr="sudo pacman -Rs"
  alias pacu="sudo pacman -Syu"
fi

type hub >& /dev/null && alias git="hub"
type ip >& /dev/null && alias lip="ip addr" || alias lip="ifconfig"

alias bc="bc -q"
alias c="clear"
alias chkm="find ~/Music/MP3 -type f ! -iname '*.mp3'"
alias df="df -h"
alias dh="dirs -v | sort -r"
alias fetch="wget --page-requisites --adjust-extension --convert-links"
alias grep="grep --color=auto -i"
alias hi="history"
alias iip="curl -s http://automation.whatismyip.com/n09230945.asp | html2text"
alias ka="killall"
alias mkdir="mkdir -pv"
alias ping="ping -c 10"
alias pyweb="python3 -m http.server 8080"
alias random='FILES=(*) && echo $FILES[$RANDOM%$#FILES+1]'
alias reload="source ~/.zshrc"
alias rf="ls -t | head -n 5"
alias rgrep="grep -r"
alias s="screen"
alias tv='vim "$TODO_FILE"'
alias ycal='cal $(date +%Y)'
alias yt="youtube-dl -l"

alias -- -="cd -"
alias ...="cd ../.."
alias ..="cd .."

alias cdd="cd ~/Downloads"
alias cdp="cd ~/Projects"
alias cds="cd ~/Sites"
alias cdt="cd ~/Documents/Text\ Files"

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

alias csd='echo "Change directory to saved PATH." && cd $SAVE_DIR'
alias sd='echo "Saving current PATH." && SAVE_DIR=$PWD'

alias d="ls -l"
alias da="ls -la"
alias l1="ls -1"
alias la="ls -a"

alias gad="git add"
alias gbr="git branch"
alias gca="git commit -a -v"
alias gch="git checkout"
alias gcl="git clone"
alias gco="git commit -v"
alias gdi="git diff"
alias gfe="git fetch"
alias gin="git init"
alias glo="git log"
alias gme="git merge"
alias gmv="git mv"
alias gpl="git pull"
alias gpu="git push"
alias grm="git rm"
alias gst="git status -s -b"
alias gun="git reset --soft HEAD^"

alias int="tim -i"
alias pomo="tim -p"
alias rint="tim -ri"

alias top="top -o cpu"
alias topme="top -o cpu -U $USER"

alias v="vim"
alias vd="vimdiff"

for X in $SSH_HOSTS; do
  alias $X="ssh $X"
done

for X in {1..16}; do
  alias +$X="cd +$X >& /dev/null"
done

if [[ $OSTYPE == darwin* ]]; then
  function f {
    if [ ! -z $1 ]; then
      open -a Finder $*
    else
      open .
    fi
  }

  function frees {
    mv ~/Library/Caches/Homebrew ~/.Trash
    mv ~/Library/Caches/com.apple.Safari/Webpage\ Previews ~/.Trash
    mv ~/Library/iTunes/iPhone\ Software\ Updates ~/.Trash
  }

  function manp {
    if [ ! -z $1 ]; then
      for ARGUMENT in $*; do
        man -t $ARGUMENT | open -f -a Preview
      done
    else
      echo "Usage: $0 [MAN PAGE]..."
    fi
  }

  function ql {
    if [ ! -z $1 ]; then
      qlmanage -p $* >& /dev/null
    else
      qlmanage
    fi
  }

  function vim {
    if [ -z $1 ]; then
      /Applications/MacVim.app/Contents/MacOS/Vim -g
    else
      /Applications/MacVim.app/Contents/MacOS/Vim -g --remote-tab-silent $*
    fi
  }
else
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
    for ARGUMENT in $*; do
      sudo /etc/rc.d/$ARGUMENT restart
    done
  }

  function start {
    for ARGUMENT in $*; do
      sudo /etc/rc.d/$ARGUMENT start
    done
  }

  function stop {
    for ARGUMENT in $*; do
      sudo /etc/rc.d/$ARGUMENT stop
    done
  }
fi

function ff {
  if [ ! -z $1 ]; then
    find . -iname $* | sed 's/.\///'
  else
    echo "Usage: $0 [PATTERN]..."
  fi
}

function ffp {
  if [ ! -z $1 ]; then
    find "$PWD" -iname $*
  else
    echo "Usage: $0 [PATTERN]..."
  fi
}

function h {
  if [ ! -z $1 ]; then
    history -i 1 | grep "$*"
  else
    history -i 1 | less +G
  fi
}

function mkcd {
  if [ ! -z $1 ]; then
    mkdir -p "$*"
    cd "$*"
  else
    echo "Usage: $0 [NAME]..."
  fi
}

function p {
  if [ ! -z $1 ]; then
    ps ax | grep -v "grep --color=auto -i $*" | grep "$*"
  else
    ps ax
  fi
}

function permf {
  if [[ $OSTYPE == darwin* ]]; then
    find . -type d -exec chmod -N 755 "{}" \;
    find . -type f -exec chmod -N 644 "{}" \;
  else
    find . -type d -exec chmod 755 "{}" \;
    find . -type f -exec chmod 644 "{}" \;
  fi
}

function ppermf {
  if [[ $OSTYPE == darwin* ]]; then
    find . -type d -exec chmod -N 700 "{}" \;
    find . -type f -exec chmod -N 600 "{}" \;
  else
    find . -type d -exec chmod 700 "{}" \;
    find . -type f -exec chmod 600 "{}" \;
  fi
}

function t {
  [ ! -f $TODO_FILE ] && echo "TODO file does not exist." && return

  if [ -z $1 ]; then
    if [ ! -s $TODO_FILE ]; then
      echo "TODO file is currently empty." && return
    else
      cat $TODO_FILE
    fi
  else
    echo "$*" >> $TODO_FILE
  fi
}

