@echo off

:: ENVA环境变量
set ENV_PATH=%ENVA_PATH%

:: 复制NGINX
:: 创建临时目录
set TEMP_FOLDER=%TEMP%\TEMP_ENVA
md %TEMP_FOLDER%


set FPM_SOURCE_FOLDER=%ENV_PATH%\nginx-fpm-php
set FPM_DESTINATION_FOLDER=%ENV_PATH%\nginx


:: 解压缩Zip文件到临时目录
powershell -command "Expand-Archive -LiteralPath '%FPM_SOURCE_FOLDER%\nginx-1.8.1.zip' -DestinationPath '%FPM_DESTINATION_FOLDER%'"
powershell -command "Expand-Archive -LiteralPath '%FPM_SOURCE_FOLDER%\RunHiddenConsole.zip' -DestinationPath '%FPM_SOURCE_FOLDER%'"

:: 复制解压缩后的文件到目标文件夹, 复制conf
xcopy "%TEMP_FOLDER%\*" "%FPM_DESTINATION_FOLDER%\" /e /y
xcopy "%ENV_PATH%\nginx-fpm-php\conf" "%FPM_DESTINATION_FOLDER%\conf" /e /y

:: 删除临时目录
rmdir /s /q %TEMP_FOLDER%

echo "NGINX -FPM Done!"