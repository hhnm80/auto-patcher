#!/bin/bash

abspath () {
	case `uname -s` in
	CYGWIN*)
		echo $(cygpath -ua "$1") | sed 's:/$::g'
		;;
	Darwin)
		#[[ $(echo $1 | awk '/^\//') == $1 ]] && echo "$1" || echo "$PWD/$1"
		[[ ${1:0:1} == "/" ]] && echo "$1" || echo "$PWD/$1"
		;;
	Linux)
                echo $(readlink -f "$1")
		;;
	*)
		if [[ ${1:0:1} == "/" ]]; then
			echo "$1"
		elif [[ ${1:0:2} == "./" ]]; then
			echo "$PWD/${1:2}"
		else
			echo "$PWD/$1"
		fi
		;;
	esac
}

extpath () {
	case `uname -s` in
	CYGWIN*)
		echo $(cygpath -da "$1")
		;;
	*)
		echo $(abspath "$1")
		;;
	esac
}
ROOT="$(abspath "$(dirname "$(abspath "$(type -p "$0")")")")"
ROM=$(abspath "$1")
ROMX=$(extpath "$1")
