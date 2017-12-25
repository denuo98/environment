#!/bin/bash
# 生成sshkey

if [ ! $1 ]; then
    echo '需要一个 sshkey title.'
    exit 0
fi

ssh-keygen -t rsa -b 4096 -o -a 100 -C "$1"
