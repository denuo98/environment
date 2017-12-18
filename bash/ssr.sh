#!/bin/bash

source $(dirname $(readlink -f "$0"))/checkroot.sh

set -e
if [ -z $EDITOR ];then
    EDITOR=vi
fi

help() {
    echo -e "\033[1;32m"
    echo ShadowSocksR python client tool
    echo -e if you have not install ssr, please run \"ssr install\"
    echo Usage:
    echo -e "   " ssr help
    echo -e "   " ssr config : edit config.json
    echo -e "   " ssr install : install shadowsocksr client
    echo -e "   " ssr uninstall : uninstall shadowsocksr client
    echo -e "   " ssr start : start the shadowsocks service
    echo -e "   " ssr stop : stop the shadowsocks service
    echo -e "   " ssr restart : restart the shadowsocks service
    echo -e "   " ssr log : cat the log of shadowsocks
}

install_path=/usr/local/share/shadowsocksr

change_workbench() {
    cd $install_path/shadowsocks/
}

start() {
    python local.py -d start
}

stop() {
    python local.py -d stop
}

if [ $# == 0 ];then
    help

elif [ $1 == "help" ];then
    help

elif [ $1 == "install" ];then
    git clone -b manyuser https://github.com/shadowsocksr-backup/shadowsocksr.git $install_path

elif [ $1 == "uninstall" ];then
    echo "Danger! are you to remove $install_path forever?(y/N)"
    read doit
    if [ $doit == 'y' ];then
        stop
        rm -rvf $install_path
    fi

elif [ $1 == "config" ];then
    $EDITOR $install_path/config.json
    change_workbench
    stop
    start

elif [ $1 == "start" ];then
    change_workbench
    start

elif [ $1 == "stop" ];then
    change_workbench
    stop

elif [ $1 == "restart" ];then
    change_workbench
    stop
    start

elif [ $1 == "log" ];then
    tail -f /var/log/shadowsocks.log

# elif [ $1 == "shell" ];then
#     change_workbench
#     python local.py $@

fi
