#!/bin/bash

#备份保存路径
backup_dir=/var/mysqlbackup/

#日期
dd=`date +%Y-%m-%d-%H`

#用户名
username=root

#密码
password=DZlzf2018

#将要备份的数据库
database_name=xuanxijia

#简单写法 mysqldump -u root -p123456 users > /root/mysqlbackup/users-$filename.sql
mysqldump -u $username -h 127.0.0.1 -p$password $database_name> $backup_dir/sql_backup/$database_name-$dd.sql

#写创建备份日志
echo "create $database_name-$dd.sql OK" >> $backup_dir/log.txt

# 执行sql备份克隆到副服务器命令
/var/mysqlbackup/clone.sh