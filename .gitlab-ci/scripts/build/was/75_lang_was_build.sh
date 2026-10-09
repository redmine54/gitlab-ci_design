# .gitlab-ci/scripts/build/was/75_lang_was_build.sh # WAS Traditional Build
#!/bin/bash

set -eu

echo "===================================="
echo "WAS Build Started"
echo "===================================="

mkdir -p build-output

mvn -B clean package

EAR_FILE=$(find target -name "*.ear" | head -1)

if [ -z "${EAR_FILE}" ]; then
    echo "EAR file not found"
    exit 1
fi

cp "${EAR_FILE}" build-output/

echo "Artifact:"
ls -l build-output

echo "WAS Build Finished"
