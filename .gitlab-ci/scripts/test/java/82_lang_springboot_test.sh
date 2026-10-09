# .gitlab-ci/scripts/test/java/82_lang_springboot_test.sh # SpringBoot UnitTest
#!/bin/bash

set -eu

echo "===================================="
echo "SpringBoot Unit Test Started"
echo "===================================="

mkdir -p reports/test
mkdir -p coverage

mvn -B test

if [ -d target/surefire-reports ]; then
    cp -r target/surefire-reports reports/test/
fi

echo "SpringBoot Unit Test Finished"

