
# 检查用户权限的代码段
if [ 0 != $(id -u) ];then
    echo 'This script must be run as root.'
    exit 0
fi
