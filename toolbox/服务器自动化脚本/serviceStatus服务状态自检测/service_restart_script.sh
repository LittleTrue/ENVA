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
# 自动化运维脚本, 维护必须服务的运行状态, add by guo 2018年12月21日
# 使用行列截取字符串功能来截取systemctl status httpd.service 的输出信息的某些区域状态字符串
# 检测httpd
httpd_status=$(systemctl status httpd | grep Active | awk '{print $3}' | cut -d "(" -f2 | cut -d ")" -f1)
    # 截取httpd进程状态输出信息，并把结果赋予变量status
    if [ "$httpd_status" == "running" ] || [ "$httpd_status" == "exited" ] || [ "$httpd_status" == "waiting" ]
    # 如果status的值不为空且处于(running,exited,waiting),即服务正在运行，则执行then中的命令
            then
            # 将当前的正确状态记录入正确运行日志中
            echo "$(date) httpd is OK!" >> /var/serviceStatus/log.txt
            else
            # httpd服务异常时，重新启动httpd服务，如果是因为故障停止, 则再次start会有错误,将错误启动信息扔入restartlog文件
            systemctl start httpd.service &>/var/serviceStatus/restartlog.txt
            echo "$(date) restart httpd!" >>  /var/serviceStatus/log.txt
    fi
# 检测mysql
mysql_status=$(systemctl status mysqld | grep Active | awk '{print $3}' | cut -d "(" -f2 | cut -d ")" -f1)
    if [ "$mysql_status" == "running" ] || [ "$mysql_status" == "exited" ] || [ "$mysql_status" == "waiting" ]
            then
            echo "$(date) mysql is OK!" >> /var/serviceStatus/log.txt
            else
            systemctl start mysqld.service &>/var/serviceStatus/restartlog.txt
            echo "$(date) restart mysql!" >>  /var/serviceStatus/log.txt
    fi
# 检测redis
redis_status=$(systemctl status redis | grep Active | awk '{print $3}' | cut -d "(" -f2 | cut -d ")" -f1)
    if [ "$redis_status" == "running" ] || [ "$redis_status" == "exited" ] || [ "$redis_status" == "waiting" ]
            then
            echo "$(date) redis is OK!_______________________________________" >> /var/serviceStatus/log.txt
            else
            systemctl start redis.service &>/var/serviceStatus/restartlog.txt
            echo "$(date) restart redis!_____________________________________" >>  /var/serviceStatus/log.txt
    fi