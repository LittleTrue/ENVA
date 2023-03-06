@echo off
set FPM_PATH=%PHP_PATH%
set ENV_PATH=%ENVA_PATH%

ECHO FLUSH DNS END...
ipconfig /flushdns

ECHO Starting PHP FastCGI...
%ENV_PATH%/nginx-fpm-php/RunHiddenConsole.exe %FPM_PATH%\php-cgi.exe -b 127.0.0.1:9000

ECHO %ENV_PATH%/nginx-fpm-php/RunHiddenConsole.exe %FPM_PATH%\php-cgi.exe -b 127.0.0.1:9000

ECHO Starting NGINX ...
cmd /k "cd /d %ENV_PATH%/nginx & start nginx & exit"