#!/bin/bash
# 用 update-alternatives 切换php和相关组件的版本

help() {
    echo -e "\033[1;33mDefault run of 'php -v'\n-----------"
    php -v
    exit 0
}

if [ $# == 0 ];then
    help
elif [ $1 == "change-version" ];then
    source $(dirname $(readlink -f "$0"))/checkroot.sh

    update-alternatives --config php \
    && update-alternatives --config phar \
    && update-alternatives --config phar.phar \
    && update-alternatives --config phpdbg \
    && update-alternatives --config php-cgi \
    && update-alternatives --config php-cgi-bin \
    && update-alternatives --config php-config \
    && update-alternatives --config phpize
else
    help
fi
