'''
搭建环境: 
    1、python 3.8 安装并加入系统path
    2、pip更新、更换源
    3、使用pip安装需要的拓展: tinify validators qiniu

转换md文件中的图片、Windows中本地路径是用反斜杠:

python 脚本地址 文件地址 [是否需要压缩]  0 - 不需要图片压缩  1 - 需要图片压缩


python C:\Users\64481\Desktop\md.py C:\Users\64481\Desktot.md 0


注意windos需要在 C:\Windows\System32 下创建一个文件 .qiniu_pythonsdk_hostscache.json 写入以下内容:

{"http:PeQFvQqq4qjahZl6-y8ONlAP_b3pSdXqC_ayE1BK:mynewss": {"upHosts": ["http://up-z2.qiniu.com", "http://upload-z2.qiniu.com", "-H up-z2.qiniu.com http://14.152.58.16"], "ioHosts": ["http://iovip-z2.qbox.me"], "deadline": 1577978849}}
'''
