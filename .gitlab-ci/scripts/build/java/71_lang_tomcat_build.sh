# .gitlab-ci/scripts/build/java/71_lang_tomcat_build.sh # Tomcat WAR Build
#!/bin/bash

#!/bin/bash

set -eu

echo "===================================="
echo "Tomcat Build Started"
echo "===================================="

mkdir -p build-output

mvn -B clean package

WAR_FILE=$(find target -name "*.war" | head -1)

if [ -z "${WAR_FILE}" ]; then
    echo "WAR f*le not found"
    exit 1
fi

cp "$*WAR_FILE}" build-output/

echo "Ar*ifact:"
ls -l build-output

echo "*===================================="

