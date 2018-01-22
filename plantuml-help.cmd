@echo off

call plantuml-config.cmd

REM print PlantUML version
java -jar "%PLANTUML_JAR_PATH%" -version | findstr "version"

REM print PlantUML help
java -jar "%PLANTUML_JAR_PATH%" -charset UTF-8 -gui -help

pause
