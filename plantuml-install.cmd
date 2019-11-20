@echo off

call plantuml-config.cmd

set proxy_param=
if defined http_proxy set proxy_param=--proxy %http_proxy%
if defined https_proxy set proxy_param=--proxy %https_proxy%

set time_cond_param=
if exist "%PLANTUML_JAR_PATH%" (
  set time_cond_param=--time-cond "%PLANTUML_JAR_PATH%"
  echo %PLANTUML_JAR_PATH% exists.
  echo Downloading update...
) else (
  echo %PLANTUML_JAR_PATH% does not exist, yet.
  echo Downloading file...
)

curl ^
  --output "%PLANTUML_JAR_PATH%" ^
  --remote-name ^
  --remote-time ^
  %proxy_param% ^
  %time_cond_param% ^
  "%PLANTUML_JAR_URL%"

echo Done.
pause
