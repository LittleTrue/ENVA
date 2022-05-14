DNMP（Docker + Nginx + MySQL + PHP7/5 + Redis）是一款全功能的**LNMP一键安装程序**。

## 1.项目总体目录结构

```
/
├── data                        数据库数据目录
│   ├── esdata                  ElasticSearch 数据目录
│   ├── mongo                   MongoDB 数据目录
│   ├── mysql                   MySQL8 数据目录
│   └── mysql5                  MySQL5 数据目录
├── services                    服务构建文件和配置文件目录
│   ├── elasticsearch           ElasticSearch 配置文件目录
│   ├── mysql                   MySQL8 配置文件目录
│   ├── mysql5                  MySQL5 配置文件目录
│   ├── nginx                   Nginx 配置文件目录
│   ├── php                     PHP5.6 - PHP7.3 配置目录
│   ├── php54                   PHP5.4 配置目录
│   └── redis                   Redis 配置目录
├── logs                        日志目录
├── docker-compose.sample.yml   Docker 服务配置示例文件
├── env.smaple                  环境配置示例文件
└── www                         PHP 代码目录
```

## 2. windows下快速使用
1. `clone`本项目：
2. 调整开发需求的env和compose.yml文件(需要啥就在yml解开并env配置好参数)
4. 在安装好docker-compose的基础上启动项目：

```java
# 在当前项目的目录下创建/管理
# 更多管理命令往下看
$ docker-compose up                         # 创建并且启动所有容器
$ docker-compose up -d    # 创建并且后台运行方式启动所有容器
```

4. 在浏览器中访问：`http://localhost`
PHP代码放在nginx中配置的文件目录`./www/localhost/index.php`。

## 3.PHP和扩展
### 3.1 切换Nginx使用的PHP版本
首先，需要启动其他版本的PHP，比如PHP5.4，那就先在`docker-compose.yml`文件中删除PHP5.4前面的注释，再启动PHP5.4容器。

PHP5.4启动后，打开Nginx 配置，修改`fastcgi_pass`的主机地址，由`php`改为`php54`，如下：
```
    fastcgi_pass   php:9000;
```
为：
```
    fastcgi_pass   php54:9000;
```
其中 `php` 和 `php54` 是`docker-compose.yml`文件中服务器的名称。

最后，**重启 Nginx** 生效。
```bash
$ docker exec -it nginx nginx -s reload
```
这里两个`nginx`，第一个是容器名，第二个是容器中的`nginx`程序。


### 3.2 安装PHP扩展
PHP的很多功能都是通过扩展实现，而安装扩展是一个略费时间的过程，
所以，除PHP内置扩展外，在`env.sample`文件中我们仅默认安装少量扩展，
如果要安装更多扩展，请打开你的`.env`文件修改如下的PHP配置，
增加需要的PHP扩展：
```bash
PHP_EXTENSIONS=pdo_mysql,opcache,redis       # PHP 要安装的扩展列表，英文逗号隔开
PHP54_EXTENSIONS=opcache,redis                 # PHP 5.4要安装的扩展列表，英文逗号隔开
```
然后重新build PHP镜像。
```bash
docker-compose build php
```
可用的扩展请看同文件的`env.sample`注释块说明。

### 3.3 使用composer
**方法1：liunx主机中基于bashrc使用composer命令**
1. 确定composer缓存的路径。比如，我的dnmp下载在`~/dnmp`目录，那composer的缓存路径就是`~/dnmp/data/composer`。
2. 参考[bash.alias.sample](bash.alias.sample)示例文件，将对应 php composer 函数拷贝到主机的 `~/.bashrc`文件。
    > 这里需要注意的是，示例文件中的`~/dnmp/data/composer`目录需是第一步确定的目录。
3. 让文件起效：
    ```bash
    source ~/.bashrc
    ```
4. 在主机的任何目录下就能用composer了：
    ```bash
    cd ~/dnmp/www/
    composer create-project yeszao/fastphp project --no-dev
    ```
5. （可选）第一次使用 composer 会在 `~/dnmp/data/composer` 目录下生成一个**config.json**文件，可以在这个文件中指定国内仓库，例如：
    ```json
    {
        "config": {},
        "repositories": {
            "packagist": {
                "type": "composer",
                "url": "https://packagist.laravel-china.org"
            }
        }
    }

    ```
**方法二：容器内使用composer命令**

还有另外一种方式，就是进入容器，再执行`composer`命令，以PHP7容器为例：
```bash
docker exec -it php /bin/sh
cd /www/localhost
composer update
```
    
## 4.管理相关命令
### 4.1 服务器启动和构建命令
如需管理服务，请在命令后面加上服务器名称，例如：
```bash
$ docker-compose up                         # 创建并且启动所有容器
$ docker-compose up -d                      # 创建并且后台运行方式启动所有容器
$ docker-compose up nginx php mysql         # 创建并且启动nginx、php、mysql的多个容器
$ docker-compose up -d nginx php  mysql     # 创建并且已后台运行的方式启动nginx、php、mysql容器


$ docker-compose start php                  # 启动服务
$ docker-compose stop php                   # 停止服务
$ docker-compose restart php                # 重启服务
$ docker-compose build php                  # 构建或者重新构建服务

$ docker-compose rm php                     # 删除并且停止php容器
$ docker-compose down                       # 停止并删除容器，网络，图像和挂载卷
```

### 4.2 liunx下添加快捷命令
在开发的时候，我们可能经常使用`docker exec -it`进入到容器中，把常用的做成命令别名是个省事的方法。

首先，在主机中查看可用的容器：
```bash
$ docker ps           # 查看所有运行中的容器
$ docker ps -a        # 所有容器
```
输出的`NAMES`那一列就是容器的名称，如果使用默认配置，那么名称就是`nginx`、`php`、`php56`、`mysql`等。

然后，打开`~/.bashrc`或者`~/.zshrc`文件，加上：
```bash
alias dnginx='docker exec -it nginx /bin/sh'
alias dphp='docker exec -it php /bin/sh'
alias dphp56='docker exec -it php56 /bin/sh'
alias dphp54='docker exec -it php54 /bin/sh'
alias dmysql='docker exec -it mysql /bin/bash'
alias dredis='docker exec -it redis /bin/sh'
```
下次进入容器就非常快捷了，如进入php容器：
```bash
$ dphp
```

## 5.使用Log日志

Log文件生成的位置依赖于conf下各log配置的值。

### 5.1 Nginx日志
Nginx日志是我们用得最多的日志，所以我们单独放在根目录`log`下。

`log`会目录映射Nginx容器的`/var/log/nginx`目录，所以在Nginx配置文件中，需要输出log的位置，我们需要配置到`/var/log/nginx`目录，如：
```
error_log  /var/log/nginx/nginx.localhost.error.log  warn;
```


### 5.2 PHP-FPM日志
大部分情况下，PHP-FPM的日志都会输出到Nginx的日志中，所以不需要额外配置。

另外，建议直接在PHP中打开错误日志：
```php
error_reporting(E_ALL);
ini_set('error_reporting', 'on');
ini_set('display_errors', 'on');
```

如果确实需要，可按一下步骤开启（在容器中）。

1. 进入容器，创建日志文件并修改权限：
    ```bash
    $ docker exec -it php /bin/sh
    $ mkdir /var/log/php
    $ cd /var/log/php
    $ touch php-fpm.error.log
    $ chmod a+w php-fpm.error.log
    ```
2. 主机上打开并修改PHP-FPM的配置文件`conf/php-fpm.conf`，找到如下一行，删除注释，并改值为：
    ```
    php_admin_value[error_log] = /var/log/php/php-fpm.error.log
    ```
3. 重启PHP-FPM容器。

### 5.3 MySQL日志
因为MySQL容器中的MySQL使用的是`mysql`用户启动，它无法自行在`/var/log`下的增加日志文件。所以，我们把MySQL的日志放在与data一样的目录，即项目的`mysql`目录下，对应容器中的`/var/lib/mysql/`目录。
```bash
slow-query-log-file     = /var/lib/mysql/mysql.slow.log
log-error               = /var/lib/mysql/mysql.error.log
```
以上是mysql.conf中的日志文件的配置。
