#!/bin/bash

function set_window_title {
  echo -en '\033]2;'$1'\007'
}

function init {
  readonly scriptName=$( basename "$BASH_SOURCE" )
  readonly scriptDir=$( cd "$( dirname "$BASH_SOURCE" )" && pwd )
  readonly scriptFullpath=${scriptDir}/${scriptName}
  readonly scriptTitle="PlantUML-Menu"
  set_window_title "$scriptTitle"
  cd "$scriptDir"

  # output file format. see parameter -t* http://plantuml.com/choice-line
  readonly PLANTUML_OUTPUT_FORMAT=svg

  # file extensions to consider when monitoring for PlantUML Code
  readonly PLANTUML_FILE_PATTERN="html, java, txt, uml"

  # size limit parameter for pixel output formats that PlantUML itself evaluates
  readonly PLANTUML_LIMIT_SIZE=8192

  # path to local PlantUML JAR file
  readonly PLANTUML_JAR_PATH=/c/Program\ Files/plantuml.jar

  # PlantuML download url for the latest JAR file. see http://plantuml.com/download
  readonly PLANTUML_JAR_URL=https://netix.dl.sourceforge.net/project/plantuml/plantuml.jar
}

function do_clear {
  clear
  return 0
}

function show_menu {
  showPlantUmlVersion
  echo
  choice=choose
  echo $scriptTitle
  echo "b    Bash"
  echo "c    cmd"
  echo "e    Edit menu (contains config)"
  echo "h    Display PlantUML Help"
  echo "q    Quit"
  echo "s    Start PlantUml GUI"
  echo "u    Update (or install) PlantUML JAR file"
  echo "x    Explorer"
  echo -n "I choose: "
  read choice
  start_choice "$choice" && do_clear || ( do_clear && echo Unknown choice: $choice )
  if [[ "$batchMode" != "1" ]]; then
    show_menu
  fi
}

function start_choice {
  case "$1" in
    0) exit 0
      ;;
    e|E) openCurrentScript
      ;;
    exit|EXIT) exit 0
      ;;
    b|B) startBash
      ;;
    c|C) startConsole
      ;;
    h|H) showPlantUmlHelp
      ;;
    q|Q) exit 0
      ;;
    s|S) startPlantUmlGui
      ;;
    u|U) updatePlantUmlJar
      ;;
    x|X) startExplorer
      ;;
    "") restartScript
      ;;
    *) return 1 # fail
      ;;
  esac
  return 0
}

function openCurrentScript {
  echo Opening this script...
  "${EDITOR:-vi}" "$scriptName"
}

function restartScript {
  clear
  exec "$scriptFullpath"
}

function showPlantUmlHelp {
  # print PlantUML help
  java -jar "$PLANTUML_JAR_PATH" -charset UTF-8 -gui -help

  read
}

function showPlantUmlVersion {
  # print PlantUML version
  java -jar "$PLANTUML_JAR_PATH" -version | grep version
}

function startBash {
  echo Starting Bash...
  cmd //c start mintty bash
}

function startConsole {
  echo Starting Console...
  start cmd //k
}

function startExplorer {
  echo Starting Explorer...
  pushd "$scriptDir"
  explorer.exe .
  popd
}

function startPlantUmlGui {
  # The path that was last used in PlantUML GUI gets restored from registry.
  # To avoid that we delete this value from registry so the default gets used.
  # The default is the current directory.
  reg delete \
    HKCU\Software\JavaSoft\Prefs\net\sourceforge\plantuml\swing \
    /v cur \
    /f \
    >/dev/null 2>&1

  reg add \
    HKCU\Software\JavaSoft\Prefs\net\sourceforge\plantuml\swing \
    /v pat \
    /d "$PLANTUML_FILE_PATTERN" \
    /f \
    >/dev/null 2>&1

  echo Starting PlantUML GUI...
  start \
    javaw \
    -jar "$PLANTUML_JAR_PATH" \
    -charset UTF-8 \
    -gui \
    -output "$PWD" \
    -t$PLANTUML_OUTPUT_FORMAT
}

function updatePlantUmlJar {
  echo Updating PlantUML...
  curl \
    --output "$PLANTUML_JAR_PATH" \
    --remote-name \
    --time-cond "$PLANTUML_JAR_PATH" \
    "$PLANTUML_JAR_URL" \
    && echo "PlantUML is up-to-date." \
    || echo "Failed updating PlantUml."
  read
}

init

if [[ -z "$1" ]]; then
  show_menu
else
  batchMode=1
  start_choice $1
fi
