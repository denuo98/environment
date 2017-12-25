#!/bin/sh
# 使用此脚本启动钉钉以免wine环境崩溃
# 仅用于使用crossover安装的钉钉

# 目前只发现一个引起错误的文件
EXCEPTION_FILENAME_1=/home/$(whoami)/.cxoffice/DingTalk/drive_c/users/crossover/Local\ Settings/Application\ Data/DingTalk/index

if [ -f "$EXCEPTION_FILENAME_1" ];then
    rm "$EXCEPTION_FILENAME_1"
fi

# 代替执行 ~/.cxoffice/Dingtalk/desktopdata/cxmenu/Desktop.C^5E3A_users_Public_Desktop/钉钉.lnk
exec "/opt/cxoffice/bin/wine" --bottle "DingTalk" --check --wait-children --start "C:/users/Public/Desktop/钉钉.lnk" "$@" >/tmp/dingtalk.output 2>&1 &
