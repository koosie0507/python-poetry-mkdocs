#!/bin/sh

PLANTUML_JAR_PATH="/opt/plantuml/lib/plantuml.jar"
test -f "${PLANTUML_JAR_PATH}" || ( printf "PlantUML JAR file not found. Exiting.\n" && exit 2 )
which java > /dev/null 2>&1  || ( printf "Java executable not in PATH. Exiting.\n" && exit 1 )

exec java -Djava.awt.headless=true -jar "${PLANTUML_JAR_PATH}" $@
