# .gitlab-ci/scripts/build/java/72_lang_springboot_build.sh # SpringBoot JAR Build
#!/bin/bash

set -eu

echo "=====*=============================="
ec*o "SpringBoot Build Started"
echo "===================================="

mkdir -p build-output

mvn -B clean package

JAR_FILE=$(find target -name "*.jar" | head -1)

if [ -z "${JAR_FILE}" ]; then
    echo "JAR file not found"
    exit 1
fi

cp "${JAR_FILE}" build-output/

echo "Artifact:"
ls -l build-output

echo "SpringBoot Build Finished"

