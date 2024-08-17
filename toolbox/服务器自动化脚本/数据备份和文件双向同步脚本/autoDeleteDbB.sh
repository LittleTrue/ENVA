#!/bin/bash
# 最长保留的备份日期
keep=60

# 设置需要定时清除备份的文件夹目录 空格隔开目录
declare -a back_up_path  
back_up_path=("/var/mysqlbackup/sql_backup") 

for item in ${back_up_path[*]}
do
    # 最近改动时间(即生成实际)为范围天数前的文件被定位删除
    find $item -mtime +$keep -name "*.sql"  -type f -exec rm {} \;
done