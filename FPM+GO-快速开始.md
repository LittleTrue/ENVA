## 一、环境变量配置
高级系统设置 -- 高级 - 环境变量系统环境变量

### 新建 - 系统变量
```bash
// 替换为你clone本项目的根目录地址
ENVA_PATH  => G:\ENVA  

// 源码解压位置 和 工作目录配置
GOROOT  =>  %ENVA_PATH%\go\go
GOPATH  =>  %ENVA_PATH%\go\workspace
```

### PATH加入以下变量
有些系统每个间需要加英文分号。

```bash
//FPM变量增加
%ENVA_PATH%\nginx-fpm-php

//GO编译器和链接器的安装位置
%GOPATH%\bin
%GOROOT%\bin

//GCC环境变量
%ENVA_PATH%\mingw64\bin
```

## 二、解压源码和安装环境软件
### 1、FPM 环境相关
#### 执行脚本fpm.bat生成nginx+fpm
```bash
// 脚本解释
// 解压 /nginx-fpm-php/nginx1.8.1.zip  -> 本项目根目录重命名为nginx
// 解压 /nginx-fpm-php/RunHiddenConsole.zip  -> 本项目根目录 /nginx-fpm-php/下
// 复制 /nginx-fpm-php/conf文件夹复制进入解压出来的nginx下conf目录下 [后续自己项目的sites.d文件夹可以自己定义]

./fpm.bat
```


### 2、解压PHP并配置extension_dir和path
在PHP目录中解压需要预留的PHP版本【7.1.12 或者7.2.26】需要其他PHP环境则自行下载解压, 配置php.ini中extension_dir为绝对路径。

```php
//环境变量 以解压7.1.12为例
//新建 - 系统变量
PHP_PATH   => %ENVA_PATH%\php\php7.1.12

//PATH加入以下变量
%PHP_PATH%
```
### 3、GO环境相关
https://studygolang.com/dl 下载推荐1.3 和 1.8 解压到本项目go目录下, 命名为go文件夹


#### 解压mingw64成为GCC环境
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