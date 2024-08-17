ngrok -config=ngrok.cfg -subdomain=nas  80

# 配置子端口则为以下写法
# ngrok -config=ngrok.cfg start sub1 sub2
# WINDOWS需要当前目前生成ngrok.exe文件执行, unix 则为/usr/local/ngrok/bin/ngrokd