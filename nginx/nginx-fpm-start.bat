@echo off
set FPM_PATH=g:\ENVA\php\php7.1.12

ECHO FLUSH DNS END...
ipconfig /flushdns

ECHO Starting PHP FastCGI...
g:/ENVA/nginx/RunHiddenConsole/RunHiddenConsole.exe %FPM_PATH%/php-cgi.exe -b 127.0.0.1:9000

ECHO Starting NGINX ...
cmd /k "cd /d G:ENVA/nginx & start nginx & exit"