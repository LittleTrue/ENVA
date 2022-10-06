@echo off
ECHO Starting PHP FastCGI...
set PATH=g:\ENVA\php\php7.1.12;
%PATH%

c:/RunHiddenConsole/RunHiddenConsole.exe g:/ENVA/php/php7.1.12/php-cgi.exe -b 127.0.0.1:9000