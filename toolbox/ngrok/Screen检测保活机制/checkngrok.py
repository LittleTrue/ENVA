# coding:utf-8
import os
import datetime
import time

def check_process():
    process="/ngrok/ngrok_cron.lock"
    os.system("ps -ef|grep ngrokd|grep -v grep >%s" % process)

    if not(os.path.getsize(process)):
        print ('触发启动ngrok')
        os.system('/ngrok/ngrok_nohup.sh')  
    else:
        f=open('/ngrok/ngrok_cron.lock', "r+")
        f.truncate()

if __name__ == '__main__':
    i = 0
    while True:
        print ('check times : %s' % str(i))
        check_process()
        time.sleep(60)
        i+=1