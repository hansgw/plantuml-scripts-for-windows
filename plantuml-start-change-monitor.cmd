@echo off

pushd "%~dp0"

call plantuml-config.cmd

REM The path that was last used in PlantUML GUI gets restored from registry.
REM To avoid that we delete this value from registry so the default gets used.
REM The default is the current directory.
reg delete ^
  HKCU\Software\JavaSoft\Prefs\net\sourceforge\plantuml\swing ^
  /v cur ^
  /f ^
  >nul 2>&1

reg add ^
  HKCU\Software\JavaSoft\Prefs\net\sourceforge\plantuml\swing ^
  /v pat ^
  /d "%PLANTUML_FILE_PATTERN%" ^
  /f ^
  >nul 2>&1

echo Starting PlantUML GUI...
start ^
  javaw ^
  -jar "%PLANTUML_JAR_PATH%" ^
  -charset UTF-8 ^
  -gui ^
  -output "%CD%" ^
  -t%PLANTUML_OUTPUT_FORMAT%
