@echo off

REM optional: configure proxy
rem set http_proxy=http://host:8080
rem set https_proxy=https://host:8443

REM output file format. see parameter -t* http://plantuml.com/command-line
set PLANTUML_OUTPUT_FORMAT=svg

REM file extensions to consider when monitoring for PlantUML Code
set PLANTUML_FILE_PATTERN=html, java, txt, uml

REM size limit parameter for pixel output formats that PlantUML itself evaluates
set PLANTUML_LIMIT_SIZE=8192

REM path to local PlantUML JAR file
set PLANTUML_JAR_PATH=%ProgramFiles%\plantuml.jar

REM PlantuML download url for the latest JAR file. see http://plantuml.com/download
set PLANTUML_JAR_URL=https://netix.dl.sourceforge.net/project/plantuml/plantuml.jar
