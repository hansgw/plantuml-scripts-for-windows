@echo off

call plantuml-config.cmd

curl ^
  --output "%PLANTUML_JAR_PATH%" ^
  --proxy-ntlm ^
  --remote-name ^
  "%PLANTUML_JAR_URL%"

pause
