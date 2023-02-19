@echo off
set FPM_PATH=%PHP_PATH%
set ENV_PATH=%ENVA_PATH%

ECHO FLUSH DNS END...
ipconfig /flushdns

ECHO Reload PHP FastCGI...
taskkill /F /IM php-cgi.exe > null
%ENV_PATH%/nginx-fpm-php/RunHiddenConsole.exe %FPM_PATH%\php-cgi.exe -b 127.0.0.1:9000

ECHO Reload NGINX ...
taskkill /F /IM  nginx.exe > null
cmd /k "cd /d %ENV_PATH%/nginx & start nginx & exit"