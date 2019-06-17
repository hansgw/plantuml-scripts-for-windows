# PlantUML scripts for windows

## Setup

* Download Graphviz (current stable release .msi) http://www.graphviz.org/Download_windows.php
* Install Graphviz
* Download PlantUML (compiled Jar, tagged file) http://plantuml.com/download.html
* Put PlantUML JAR file into `%ProgramFiles%` e.g. `"C:\Program Files\plantuml.8037.jar"`.
* Test Graphviz installation with PlantUML: `java -jar "%ProgramFiles%\plantuml.8037.jar" -testdot`.
    * Last line of output after successful test:
        > Installation seems OK. File generation OK  

## Example PlantUML file

* Create `example2.uml` with this content:
    > @startuml
    > ' This is a comment on a single line
    > Bob->Alice : hello
    > /' This is a comment split
    > on several lines '/
    > @enduml
* Compile example2.uml: `java -jar "%ProgramFiles%\plantuml.jar" -charset UTF-8 example2.uml`.
* Result file example2.png will be generated.

## Working with diagrams

While working on PlantUML files the PlantUML GUI should be running.
The GUI automatically generates an updated PNG file for every change to the PlantUML file.
The GUI can be started via script `plantuml-start-change-monitor.cmd`.
If you keep the generated PNG file opened in the Windows Photo Viewer, you will see the it refreshes its content automatically.

## Additional hints

PlantUML uses the standardised HTML color names: http://www.w3schools.com/colors/colors_hex.asp
