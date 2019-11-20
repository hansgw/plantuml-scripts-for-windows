@echo off

call plantuml-config.cmd

set proxy_param=
if defined http_proxy set proxy_param=--proxy %http_proxy%
if defined https_proxy set proxy_param=--proxy %https_proxy%

curl ^
  --output "%PLANTUML_JAR_PATH%" ^
  --remote-name ^
  %proxy_param% ^
  "%PLANTUML_JAR_URL%"

pause
