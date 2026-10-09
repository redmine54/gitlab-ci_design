# .gitlab-ci/scripts/build/was/76_lang_liberty_build.sh # Liberty Build
#!/bin/bash

set -eu

echo "===================================="
echo "Liberty Build Started"
echo "===================================="

mkdir -p build-output

mvn -B clean package

WAR_FILE=$(find target -name "*.war" | head -1)

if [ -z "${WAR_FILE}" ]; then
    echo "WAR file not found"
    exit 1
fi

cp "${WAR_FILE}" build-output/

echo "Artifact:"
ls -l build-output

echo "Liberty Build Finished"

