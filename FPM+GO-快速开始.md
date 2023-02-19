## 一、环境变量配置
高级系统设置 -- 高级 - 环境变量系统环境变量

前置工作： 
1、解压php目录下的压缩包【7.1.12 或者7.2.26】并配置extension_dir和path, 其他PHP环境则自行下载解压, 
2、配置php.ini中extension_dir为ext目录此时的绝对路径
### 新建 - 系统变量
```bash
// 替换为你clone本项目的根目录地址
ENVA_PATH  => G:\ENVA  

// 新增PHP环境变量以解压了【php7.1.12】为例子
PHP_PATH   => %ENVA_PATH%\php\php7.1.12

// 进行GO源码解压位置 和 工作目录配置
GOROOT  =>  %ENVA_PATH%\go\go
GOPATH  =>  %ENVA_PATH%\go\workspace
```

### PATH加入以下变量
有些系统每个间需要加英文分号。

```bash
//FPM变量增加
%ENVA_PATH%\nginx-fpm-php

//PHP变量
%PHP_PATH%

//GO编译器和链接器的安装位置
%GOPATH%\bin
%GOROOT%\bin

//GCC环境变量
%ENVA_PATH%\mingw64\bin
```

## 二、解压源码和安装环境软件
### 1、自动生成FPM 环境相关
#### 执行脚本fpm.bat生成nginx+fpm
```bash
// 运行脚本, 注意生成nginx后中conf文件夹下区分不同办公环境的sites.d目录 , 后续自己项目的sites.d文件夹可以自己参考着定义
./nginx-fpm.bat
```

### 2、自行配置GO环境相关
https://studygolang.com/dl 下载推荐1.3 和 1.8 解压到本项目go目录下, 命名为go文件夹


#### 解压mingw64.7z 成为GCC环境
解压go/mingw64.7z 到根目录成为mingw64


************************************
## 开始使用
直接使用这两个命令管理PHP-FPM-NGINX

```php
启动nginx+PHP+FPM
nginx-fpm-start

重启nginx+PHP+FPM
nginx-fpm-restart

验证GO环境和gcc环境
go version
gcc -v
```
************************************
## 需要需要额外的应用 / 需要docker安装的各种应用
参考【DOCKER-应用开启使用.md】在安装好docker前提下

```java
# 直接运行创建默认的应用容器
$ docker-compose up                         # 创建并且启动所有容器
```