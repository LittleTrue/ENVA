#!/usr/bin/expect
# expect脚本循环接受传入的数组
foreach d $argv {
  # send $d
  spawn rsync -azutp $d/ root@121.170.234.109:$d

  expect {
  "(yes/no)?" {
    send "yes\n"
    expect "*assword:" { send "LIZHIFENG2212\n"}
    }
    "*assword:" {
    send "LIZHIFENG2212\n"
    }
  }
  expect eof
}