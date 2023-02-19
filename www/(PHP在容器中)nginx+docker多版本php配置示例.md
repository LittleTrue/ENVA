## (特殊使用) nginx使用宿主机应用, php+fpm使用docker内部。
## 1、宿主机的nginx关联项目项目需要映射进入PHP容器中
/www/localhost 为ENVA固定映射到docker-PHP容器的位置, 项目放入此处即可。

```php
root /www/localhost/project/pandora/pandora.backend/web;
```

## 2、宿主机ROOT和$document_root变量需要设置为PHP容器中项目位置
```php
fastcgi_param SCRIPT_FILENAME /www/localhost/project/pandora/pandora.backend/web/$fastcgi_script_name;
```

## 完整配置示例

```php
server {
    charset utf-8;
    client_max_body_size 20M;
    listen 80;
    server_name localadminpandora.inkept.cn;
    root /www/localhost/project/pandora/pandora.backend/web;
    
    index index.php;

    location / {
        try_files $uri $uri/ /index.php$is_args$args;
    }

    error_page 500 502 503 504 /50x.html;

    location = /50x.html {
        root html;
    }

    add_header Access-Control-Allow-Origin $http_origin;
    add_header Access-Control-Allow-Headers medalType,X-Requested-With,x_requested_with,Content-Type,Origin,Accept,ticket;
    add_header Access-Control-Allow-Methods GET,POST,OPTIONS;
    add_header Access-Control-Allow-Credentials true;

    location ~ \.php$ {
        #root           html;
        fastcgi_pass 127.0.0.1:9000;
        fastcgi_index index.php;
        fastcgi_param SCRIPT_FILENAME /www/localhost/project/pandora/pandora.backend/web/$fastcgi_script_name;
        include fastcgi_params;
    }

    location ~ ^/assets/.*\.php$ {
        deny all;
    }
}
```
