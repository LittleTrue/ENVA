#!/bin/bash
#       ___           ___           ___
#      /\  \         |\__\         /\  \
#     /::\  \        |:|  |        \:\  \
#    /:/\:\  \       |:|  |         \:\  \
#   /:/  \:\  \      |:|__|__        \:\  \
#  /:/__/_\:\__\ ____/::::\__\ _______\:\__\
#  \:\  /\ \/__/ \::::/~~/~    \::::::::/__/
#   \:\ \:\__\    ~~|:|~~|      \:\~~\~~
#    \:\/:/  /      |:|  |       \:\  \
#     \::/  /       |:|  |        \:\__\
#      \/__/         \|__|         \/__/
# 自动化运维脚本, 自动更新对应代码仓库所有分支项目的代码版本, add by guo 2019年6月18日
# 本脚本更新的产品仓库是 [服务后台报关版(单商户)]
# 目前加入该仓库的共有  爱库存.
# 前提条件:  1、centos上git的部署, 基于公钥绑定所有项目的超级管理员 2、基于git stash 暂存服务器上调试代码 3、git pull拉取指定分支代码

echo "$(date)_____________update midsocket post declare single start_____________!" >> /var/webhook/mid_single/git_log.txt
# 开始更新--  爱库存服务后台
cd /var/www/html/akcMidSocket
sudo git stash
sudo git pull origin master >>/var/webhook/mid_single/git_log.txt
sudo git stash pop stash@{0}

echo "$(date)_____________update midsocket post declare single end_______________!" >> /var/webhook/mid_single/git_log.txt

echo "$(date)-- update midsocket with haitao!" >> /var/webhook/mid_single/log.txt