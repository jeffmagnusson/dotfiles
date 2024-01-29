#!/usr/bin/env bash
function clean_link_file {
    source="${PWD}/$1"
    target="${2}/${1/_/.}"
	link_file $source $target
}

function link_file {
	source=$1
	target=$2

    if [ -e "${target}" ]; then
        mv $target $target.bak
    fi

    ln -sf ${source} ${target}
}

for i in _*
do
	clean_link_file $i $1
done

source="${PWD}/_vim/_vimrc"
target="${1}/.vimrc"
link_file $source $target 

cat submodules | perl -e 'while(<>){($a,$b) = split(/\s+/, $_); print `git submodule add $a $b`;}'

git reset

echo "\n*****************************************************************************************"
echo "For tmux powerline on os X:\ngit clone https://github.com/powerline/fonts.git\ncd powerline/fonts\n./install.sh\n"
echo "Then change font in terminal profile settings for non-ASCII characters to a powerline font (search 'powerline')"
echo "\n*****************************************************************************************\n"
