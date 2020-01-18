#!/bin/bash

SETUP=$(pwd)

add(){
  target=$1
  location=$2

  if [ -f "${target}" ]; then
	  diff "${target}" "${location}" >/dev/null && echo "${target} already installed"
	  diff "${target}" "${location}" >/dev/null || echo "Existing ${target}"
	  return
  fi

  echo "Linking ${location} to ${target}"
  ln -s "${SETUP}/${location}" "${target}"
}

add ~/.gitconfig git/config
add ~/.gitignore git/ignore
add ~/.bash_profile bash/bashrc
add ~/.psqlrc psqlrc
add ~/.vimrc vimrc
