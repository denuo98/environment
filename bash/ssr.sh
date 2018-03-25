#!/bin/bash

source $(dirname $(readlink -f "$0"))/checkroot.sh

set -e
if [ -z $EDITOR ];then
    EDITOR=vi
fi

install_path=/usr/local/share/shadowsocksr

help() {
    echo -e "\033[0;32m     _                 _
 ___(_)_ __ ___  _ __ | | ___   ___ ___ _ __
/ __| | '_ \` _ \| '_ \| |/ _ \ / __/ __| '__|
\__ \ | | | | | | |_) | |  __/ \__ \__ \ |
|___/_|_| |_| |_| .__/|_|\___| |___/___/_|
                |_|
"
    echo ShadowSocksR python client tool
    echo -e If you have not install ssr, please run \"ssr install\"
    echo ""
    echo -e "\033[0;33m"Default install path:" \033[0m"$install_path
    echo -e "\033[0;33m"Usage:
    echo -e "    \033[0;32m" ssr help"             \033[0m"Display this help message
    echo -e "    \033[0;32m" ssr config"           \033[0m"Edit config.json and run "\033[1;32mssr restart"
    echo -e "    \033[0;32m" ssr install"          \033[0m"Install shadowsocksr client
    echo -e "    \033[0;32m" ssr uninstall"        \033[0m"Uninstall shadowsocksr client
    echo -e "    \033[0;32m" ssr start"            \033[0m"Start the shadowsocksr local service
    echo -e "    \033[0;32m" ssr stop"             \033[0m"Stop the shadowsocksr local service
    echo -e "    \033[0;32m" ssr restart"          \033[0m"Restart the shadowsocksr local service
    echo -e "    \033[0;32m" ssr log"              \033[0m"Cat the log of shadowsocksr
}

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
