#!/bin/bash

# 脚本根目录
backup_dir=/var/ethRestart/

#日期
dd=`date +%Y-%m-%d-%H-%M-%S`

set -x
test=`ping -c 5 192.168.3.1 | grep "100% packet loss" | wc -l`
test
echo $test
if [ $test = 0 ];
then
        echo "$dd--------The network is working--------" >> $backup_dir/log.txt
else
        echo "$dd-----------------restart--------------" >> $backup_dir/log.txt
        ifconfig em1 up
fi