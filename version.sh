# /bin/sh

# Variables
CONTROL_NAME=ReactControl

# Locals
CONTROL_FOLDER=control
CONTROL_MANIFEST_PATH=./$CONTROL_FOLDER/$CONTROL_NAME/ControlManifest.Input.xml
SOLUTION_XML_PATH=./solution/src/Other/Solution.xml
VERSION=$(cat VERSION)

# Version: ControlManifest.Input.xml
xmlstarlet ed --inplace -u '/manifest/control/@version' -v $VERSION $CONTROL_MANIFEST_PATH
xmlstarlet ed --inplace -u '/manifest/control/resources/resx/@version' -v $VERSION $CONTROL_MANIFEST_PATH

# Version: package.json / package-lock.json
npm --prefix $CONTROL_FOLDER version $VERSION --allow-same-version   

# Version: Solution.xml
xmlstarlet ed --inplace -u '/ImportExportXml/SolutionManifest/Version' -v $VERSION $SOLUTION_XML_PATH
