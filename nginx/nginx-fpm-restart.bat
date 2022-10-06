@echo off
set FPM_PATH=g:\ENVA\php\php7.1.12

ECHO FLUSH DNS END...
ipconfig /flushdns

ECHO Reload PHP FastCGI...
taskkill /F /IM php-cgi.exe > null
g:/ENVA/nginx/RunHiddenConsole/RunHiddenConsole.exe %FPM_PATH%/php-cgi.exe -b 127.0.0.1:9000

ECHO Reload NGINX ...
taskkill /F /IM  nginx.exe > null
cmd /k "cd /d G:ENVA/nginx & start nginx & exit"