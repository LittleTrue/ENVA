#!/usr/bin/expect
# 服务器ip
#set back_ip '192.168.3.50'

#日期
set dd [exec date "+%Y-%m-%d-%H"]

#将要备份的数据库
set database_name "xuanxijia"

# 服务器ip
#set back_password 'LIZHIFENG2212'
# 使用参数变量有错误,避免
# 将主服务器备份的sql文件同步到副服务器
spawn scp -r /var/mysqlbackup/sql_backup/$database_name-$dd.sql root@47.107.176.36:/var/db_backup/xxj

expect {
 "(yes/no)?" {
   send "yes\n"
   expect "*assword:" { send "LIZHIFENG2212\n"}
  }
  "*assword:" {
   send "LIZHIFENG2212\n"
  }
}
expect "100%"
expect eof