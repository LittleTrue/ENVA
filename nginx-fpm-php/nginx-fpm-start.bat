@echo off
set PHP_VERSION=7.1.12
set ENV_PATH=g:ENVA
set FPM_PATH=%ENV_PATH%\php\php%PHP_VERSION%

ECHO FLUSH DNS END...
ipconfig /flushdns

ECHO Starting PHP FastCGI...
%ENV_PATH%/nginx-fpm-php/RunHiddenConsole.exe %FPM_PATH%\php-cgi.exe -b 127.0.0.1:9000

ECHO Starting NGINX ...
cmd /k "cd /d %ENV_PATH%/nginx & start nginx & exit"