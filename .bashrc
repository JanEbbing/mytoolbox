#!/bin/bash

#
# ~/.bashrc
# 

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

# Colorful LS
alias ls='ls --color=auto'

shopt -s autocd # When entering directory without command, cd to dir
shopt -s cdspell # When mistyping by 1 in interactive shell, correct the spelling for the cd command
source /usr/share/doc/pkgfile/command-not-found.bash # Command not found utility
source /etc/profile.d/autojump.bash #

alias android-disconnect="fusermount -u /mnt/a" # Oneplus Two mount aliases


# Source global definitions
if [ -f /etc/bashrc ]; then
	. /etc/bashrc
fi


# Bash aliases
if [ -f ~/.bash_aliases ]; then
        . ~/.bash_aliases
fi

# Git prompt

source ~/.git-prompt.sh
PS1='\D{%F %R} \u@\h:\W$(__git_ps1 " (%s)")\$ ' # Fancy infos in the shell

c() {
  dir="$(python /afs/cern.ch/user/j/jebbing/.local/lib/python2.7/site-packages/dirlog.pyo "$@")"
  if [ "$dir" != "" ]; then
    cd "$dir" && ls
  fi
}

c ILC

# function Extract for common file formats
function extract {
 if [ -z "$1" ]; then
    # display usage if no parameters given
    echo "Usage: extract <path/file_name>.<zip|rar|bz2|gz|tar|tbz2|tgz|Z|7z|xz|ex|tar.bz2|tar.gz|tar.xz>"
 else
    if [ -f $1 ] ; then
        NAME=${1%.*}
        mkdir $NAME && cd $NAME
        case $1 in
          *.tar.bz2)   tar xvjf ../$1    ;;
          *.tar.gz)    tar xvzf ../$1    ;;
          *.tar.xz)    tar xvJf ../$1    ;;
          *.lzma)      unlzma ../$1      ;;
          *.bz2)       bunzip2 ../$1     ;;
          *.rar)       unrar x -ad ../$1 ;;
          *.gz)        gunzip ../$1      ;;
          *.tar)       tar xvf ../$1     ;;
          *.tbz2)      tar xvjf ../$1    ;;
          *.tgz)       tar xvzf ../$1    ;;
          *.zip)       unzip ../$1       ;;
          *.Z)         uncompress ../$1  ;;
          *.7z)        7z x ../$1        ;;
          *.xz)        unxz ../$1        ;;
          *.exe)       cabextract ../$1  ;;
          *)           echo "extract: '$1' - unknown archive method" ;;
        esac
    else
        echo "$1 - file does not exist"
    fi
fi
} 

# Function to create directory and immediately cd to it
mcd () {
    mkdir -p $1
    cd $1
}

# Function to swap two files on local disk
function swap()
{ # Swap 2 filenames around, if they exist (from Uzi's bashrc).
    local TMPFILE=tmp.$$

    [ $# -ne 2 ] && echo "swap: 2 arguments needed" && return 1
    [ ! -e $1 ] && echo "swap: $1 does not exist" && return 1
    [ ! -e $2 ] && echo "swap: $2 does not exist" && return 1

    mv "$1" $TMPFILE
    mv "$2" "$1"
    mv $TMPFILE "$2"
}


# Function to go up N directories, e.g. up 4 goes from /opt/dirac/pro/1/2/3/4 to /opt/dirac/pro
function up( )
{
LIMIT=$1
P=$PWD
for ((i=1; i <= LIMIT; i++))
do
    P=$P/..
done
cd $P
export MPWD=$P
}

# use back after using up to go back to where you came from
function back( )
{
LIMIT=$1
P=$MPWD
for ((i=1; i <= LIMIT; i++))
do
    P=${P%/..}
done
cd $P
export MPWD=$P
}

# Usage: Use mycd $DIRECTORY to cd to a directory with a long name
# This directory is now added to a list of often visited directories.
# If you want to go back there, type mycd (or mycd $NUMBER if you know the number) and press the corresponding number
function mycd {

MYCD=/tmp/mycd.txt
touch ${MYCD}

typeset -i x
typeset -i ITEM_NO
typeset -i i
x=0

if [[ -n "${1}" ]]; then
   if [[ -d "${1}" ]]; then
      echo "${1}" >> ${MYCD}
      sort -u ${MYCD} > ${MYCD}.tmp
      mv ${MYCD}.tmp ${MYCD}
      FOLDER=${1}
   else
      i=${1}
      FOLDER=$(sed -n "${i}p" ${MYCD})
   fi
fi

if [[ -z "${1}" ]]; then
   echo ""
   cat ${MYCD} | while read f; do
      x=$(expr ${x} + 1)
      echo "${x}. ${f}"
   done
   print "\nSelect #"
   read ITEM_NO
   FOLDER=$(sed -n "${ITEM_NO}p" ${MYCD})
fi

if [[ -d "${FOLDER}" ]]; then
   cd ${FOLDER}
fi

}

