setopt no_global_rcs # Don't use config files from /etc.
umask 022

export GOPATH=~/Golang

export LANG=en_US.UTF-8
export LC_ALL=en_US.UTF-8

if [[ $OSTYPE == darwin* ]]; then
  path=(
    ~/.local/bin(N)
    ~/Golang/bin(N)
    ~/Scripts/OSX(N)
    ~/Scripts(N)
    /usr/local/bin(N)
    /usr/local/Cellar/curl/*/bin(N)
    /usr/local/opt/go/libexec/bin(N)
    /usr/local/sbin(N)
    /usr/bin
    /usr/sbin
    /bin
    /sbin
  )
else
  path=(
    ~/.local/bin(N)
    ~/Golang/bin(N)
    ~/Scripts/Linux(N)
    ~/Scripts(N)
    /usr/local/bin
    /usr/local/sbin
    /usr/bin
    /usr/bin/core_perl(N)
    /usr/games
    /usr/sbin
    /bin
    /sbin
  )
fi
